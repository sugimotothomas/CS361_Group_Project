var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs361_sugimoth',
  password        : '1234',
  database        : 'cs361_sugimoth',
  dateStrings	  :  true
});

module.exports.pool = pool;
