DROP TABLE IF EXISTS `OrderItem`;
DROP TABLE IF EXISTS `Customer`;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS `Product`;
DROP TABLE IF EXISTS `Supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `created` date,
  `lastLogin` date,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `zipCode` varchar(255),
  `city` varchar(255),
  `state` varchar(255),
  PRIMARY KEY (`ID`) 
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Supplier` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address1` varchar(255),
  `address2` varchar(255),
  `zip` varchar(255),
  `city` varchar(255),
  `state` varchar(255),
  `tel` varchar(255),
  `created` date,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;



/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Order` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `created` date,
  `shipped` date,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY(`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Product` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255),
  `created` date,
  `expiration` date,
  `supplierID` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 0,
  `amount` float(11),
  `cost` float(11) DEFAULT 0,
  PRIMARY KEY(`ID`),
  KEY `supplierID` (`supplierID`),
  CONSTRAINT `ofSupplier` FOREIGN KEY (`supplierID`) REFERENCES `Supplier` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;



/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OrderItem` (
  `orderID` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 0,
  PRIMARY KEY (`orderID`, `productID`),
  CONSTRAINT `order` FOREIGN KEY (`orderID`) REFERENCES `Order` (`ID`),
  CONSTRAINT `product` FOREIGN KEY (`productID`) REFERENCES `Product` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*
------------------------------------------------------------------------------------
-- Data Dumping
------------------------------------------------------------------------------------
*/

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES
(1, 'Thomas', 'Sugimoto', '2018-11-26', '2018-11-26', '123 Cool St.', 'Apt. 203', '98383', 'Silverdale', 'WA');

/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `Supplier` WRITE;
/*!40000 ALTER TABLE `Supplier` DISABLE KEYS */;
INSERT INTO `Supplier` VALUES
(1, 'Wallbeans', '393 Drugstore Ave.', '', '98383', 'Silverdale', 'WA', '3604939231', '2018-11-26', 'Verified'),
(2, 'Drug Mori', '123 Pills St.', '', '27382', 'Los Angeles', 'CA', '2943949586', '2017-01-13', 'Verified'),
(3, 'Insu-Line', '3823 Berry Dr.', '', '27382', 'Los Angeles', 'CA', '2837482938', '2018-11-26', 'Verified'),
(4, 'Barbell Drugs', '121 1st Ave.', '', '38282', 'New York City', 'NY', '2739483738', '2018-11-26', 'Verified'),
(5, 'Wright Aid', '382 5th Ave.', '', '38282', 'New York City', 'NY', '1928374637', '2018-11-26', 'Verified'),
(6, 'CVP Pharmacy', '393 Drugstore Ave.', '', '38291', 'Miami', 'FL', '2938485757', '2018-11-26', 'Verified');

/*!40000 ALTER TABLE `Supplier` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES
(1, 'Insulin-A', '2018-10-10', '2018-12-25', 1, 20, 10, 284.99),
(2, 'Insulin-B', '2018-09-22', '2018-11-24', 2, 20, 10, 99.99),
(3, 'Insulin-C', '2018-10-19', '2018-12-30', 3, 20, 10, 123.89),
(4, 'Insulin-D', '2018-10-30', '2019-01-03', 4, 20, 10, 382.99),
(5, 'Insulin-E', '2018-08-14', '2018-10-30', 5, 20, 20, 584.99),
(6, 'Insulin-F', '2018-10-10', '2018-12-25', 6, 20, 10, 234.99),
(7, 'Insulin-G', '2018-11-25', '2019-01-10', 1, 20, 10, 394.99),
(8, 'Insulin-H', '2018-11-25', '2019-01-10', 2, 20, 10, 321.99);

/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;


LOCK TABLES `Order` WRITE;
/*!40000 ALTER TABLE `Order` DISABLE KEYS */;
INSERT INTO `Order` VALUES
(1, '2018-11-26', '', 'In Progress'),
(2, '2018-11-12', '2018-11-20', 'Completed'),
(3, '2018-11-16', '2018-11-26', 'Completed');

/*!40000 ALTER TABLE `Order` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `OrderItem` WRITE;
/*!40000 ALTER TABLE `OrderItem` DISABLE KEYS */;
INSERT INTO `OrderItem` VALUES
(1, 2, 2),
(2, 5, 3),
(3, 4, 1);

/*!40000 ALTER TABLE `OrderItem` ENABLE KEYS */;
UNLOCK TABLES;