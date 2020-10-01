// app setup
var express = require('express');
var bodyParser = require('body-parser');
var handlebars = require('express-handlebars').create({defaultLayout:'main'});
var mysql = require('./db.js');
var app = express();

// view engine setup
app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', '6294');

// misc
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static('public'));


// Root Page
app.get('/', function(req, res, next) {
	res.render('home');
});

// Home page
app.get('/home', function(req, res, next) {
	res.render('home');
});

// search page
app.get('/search', function(req, res, next) {
  var context = {};
  mysql.pool.query(
    'SELECT P.name `productName` FROM Product P ORDER BY P.name',
      function(err, rows, fields) {
    if(err) {
      next(err);
      return;
    }
    var list = [];
    for(var row in rows) {
      var toPush = { 
              'productName': rows[row].productName
            };
      list.push(toPush);
    }
    context.product = list;
    res.render('search', context);
  });
});

// List product page
app.get('/listing', function(req, res, next) {
	 var context = {};
  mysql.pool.query(
    'SELECT P.name `productName`, S.name `supplierName` FROM Product P LEFT JOIN Supplier S ON S.ID = P.supplierID ORDER BY P.ID',
      function(err, rows, fields) {
    if(err) {
      next(err);
      return;
    }
    var list = [];
    var list2 = [];
    for(var row in rows) {
      var toPush = { 
              'supplierName': rows[row].supplierName
            };
      list.push(toPush);
    }
    context.supplier = list;

   for(var row in rows) {
      var toPush = { 
              'productName': rows[row].productName
            };
      list2.push(toPush);
    }
    context.product = list2;
    res.render('listing', context);
  });
  
});

// search return page
app.post('/return', function(req, res, next) {
	 var context = {};
	 var prescription = "IS NOT NULL";
	 var minPrice, maxPrice;
	
    for (p in req.body) {
        if (p === "prescription")
	    {
		    if(req.body[p].toString() !== "ANY")
	            	prescription = '= "' + req.body[p].toString() +'"';
	    }
        if (p === "minPrice")
            minPrice = parseInt(req.body[p].toString());
        if (p === "maxPrice")
            maxPrice = parseInt(req.body[p].toString());
    }
  mysql.pool.query(
    'SELECT P.name `productName`, P.created, P.expiration, S.name `supplierName`, P.quantity, P.amount, P.cost FROM Product P LEFT JOIN Supplier S ON S.ID = P.supplierID WHERE P.name '+prescription+' ORDER BY P.ID',
      function(err, rows, fields) {
    if(err) {
      next(err);
      return;
    }
    var list = [];
    for(var row in rows) {
      var toPush = { 
              'productName': rows[row].productName,
              'created': rows[row].created,
              'expiration': rows[row].expiration,
              'supplierName': rows[row].supplierName,
              'quantity': rows[row].quantity,
              'cost': rows[row].cost
            };
      list.push(toPush);
    }
    context.product = list;
    res.render('return', context);
  });
  

});

// Customer Registration
app.get('/customerRegistration', function(req, res, next) {
	res.render('customerReg');
});


// supplier registration
app.get('/supplierReg', function(req, res, next){
  res.render('supplierReg')
});

// supplier portal
app.get('/supplierPortal', function(req, res, next){
  res.render('supplierPortal')
});

// supplier login
app.get('/supplierLogin', function(req, res, next){
  res.render('supplierLogin')
});

app.use(function(req,res){
  res.status(404);
  res.render('404');
});

app.use(function(err, req, res, next){
  console.error(err.stack);
  res.type('plain/text');
  res.status(500);
  res.render('500');
});

app.listen(app.get('port'), function(){
  console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});
