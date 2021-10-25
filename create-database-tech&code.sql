DROP DATABASE IF EXISTS `sql_store`;
CREATE DATABASE `sql_store`; 
USE `sql_store`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `order_statuses` (
  `order_status_id` tinyint(4) NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`order_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `order_statuses` VALUES (1,'Processed');
INSERT INTO `order_statuses` VALUES (2,'Shipped');
INSERT INTO `order_statuses` VALUES (3,'Delivered');

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address_number` varchar(50) NOT NULL,
  `address_name` varchar(50) NOT NULL,
  `postal_code` char(5) NOT NULL,
  `city` varchar(50) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `customers` VALUES (1,'	Émilie','Carrière', '1993-1-14', '02.13.28.05.86', '93', 'avenue du Marechal Juin', '75018' , 'paris', 16);
INSERT INTO `customers` VALUES (2, 'Gaetan', 'Lemelin','1996-1-10', '03.33.21.22.14','46', 'boulevard Albin Durand', '75005', 'paris', 1553);
INSERT INTO `customers` VALUES (3,'Fayme', 'Marceau', '1976-3-15', '07.82.06.66.11', '60', 'rue Marie de Médicis','62400', 'béthune', 142);
INSERT INTO `customers` VALUES (4, 'Royden', 'Vadnais', '1989-6-24', '01.56.87.84.73', '83', 'avenue Jules Ferry', '75013', 'paris', 267);
INSERT INTO `customers` VALUES (5,	'Virginie', 'Patenaude','1961-7-3', '01.81.20.96.47', '53', 'rue de Geneve', '69001', 'lyon', 1784);
INSERT INTO `customers` VALUES (6,'Gill', 'Doucet', '1968-4-26', '01.41.06.76304', '88', 'rue de la Mare aux Carats', '75005', 'paris', 2576 );
INSERT INTO `customers` VALUES (7,'Olivier', 'Rochon', '1976-2-5', '01.31.36.07.49', '104', 'rue Isambard', '75013', 'paris', 134);
INSERT INTO `customers` VALUES (8,'Mirabelle', 'Fluet', '1964-3-9', '06.84.41.11.14', '122', 'rue du Fossé des Tanneurs', '38000', 'grenoble', 245);
INSERT INTO `customers` VALUES (9,'Verrill' , 'Langlois', '1996-6-28','06.34.33.56.29', '44', 'place Stanislas', '54100', 'nancy', 32);
INSERT INTO `customers` VALUES (10,'Joseph','Dodier', '1968-3-22',	'07.17.76.39.74', '69', 'Rue Roussy', '38100', 'grenoble', 3576 );
INSERT INTO `customers` VALUES (11,'Apolline', 'Quenneville' ,'1965-11-26', '04.19.23.75.51', '109', 'rue Banaudon', '69009', 'lyon', 76);
INSERT INTO `customers` VALUES (12, 'Arienne', 'Chesnay', '1956-11-11','01.39.06.27.51', '80', 'rue Sadi Carnot', '93300', 'aubervilliers', 25);
INSERT INTO `customers` VALUES (13, 'Edmee', 'Gregoire', '1986-3-6', '07.07.17.46.96', '72', 'rue Jean Vilar', '75006', 'paris', 56);
INSERT INTO `customers` VALUES (14,'Moore' ,'Charpie', '1968-6-11','05.83.70.66.04','81', 'avenue de l\'Amandier', '33000', 'bordeaux', 38);
INSERT INTO `customers` VALUES (15,'Laurence', 'Favreau', '1964-12-16','06.02.86.77.39','35', 'route de Lyon', '67400', 'mulhouse', 67);


CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `quantity_in_stock` int(11) NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `products` VALUES (1,'housse de couette coton 140x200',70,25.99);
INSERT INTO `products` VALUES (2,'housse de couette coton 200x210',49,25.99);
INSERT INTO `products` VALUES (3,'housse de couette coton 160x210',38,29.99);
INSERT INTO `products` VALUES (4,'housse de coussin coton 50x70',90,12.99);
INSERT INTO `products` VALUES (5,'housse de coussin coton 63x63',94,12.99);
INSERT INTO `products` VALUES (6,'housse de coussin coton 65x100',2,13.99);
INSERT INTO `products` VALUES (7,'drap housse coton 90x200',98,15.99);
INSERT INTO `products` VALUES (8,'drap housse coton 140x200',3,19.99);
INSERT INTO `products` VALUES (9,'drap housse coton 180x200',67,19.99);
INSERT INTO `products` VALUES (10,'taie traversin coton 85x185',0,10.09);
INSERT INTO `products` VALUES (11,'housse de couette lin 140x200',58,55.99);
INSERT INTO `products` VALUES (12,'housse de couette lin 200x210',25,55.99);
INSERT INTO `products` VALUES (13,'housse de couette lin 160x210',16,59.99);
INSERT INTO `products` VALUES (14,'housse de coussin lin 50x70',56,22.99);
INSERT INTO `products` VALUES (15,'housse de coussin lin 63x63',84,22.99);
INSERT INTO `products` VALUES (16,'housse de coussin lin 65x100',62,23.99);
INSERT INTO `products` VALUES (17,'drap housse lin 90x200',1,30.99);
INSERT INTO `products` VALUES (18,'drap housse lin 140x200',19,29.99);
INSERT INTO `products` VALUES (19,'drap housse lin 180x200',17,29.99);
INSERT INTO `products` VALUES (20,'taie traversin lin 85x185',34,20.09);

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `comments` varchar(2000) DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_customers_idx` (`customer_id`),
  KEY `fk_orders_order_statuses_idx` (`status`),
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_order_statuses` FOREIGN KEY (`status`) REFERENCES `order_statuses` (`order_status_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `orders` VALUES (1,1,'2021-01-30',1,NULL,NULL);
INSERT INTO `orders` VALUES (2,2,'2021-08-02',2,NULL,'2021-08-03');
INSERT INTO `orders` VALUES (3,10,'2020-12-01',1,'Very big order',NULL);
INSERT INTO `orders` VALUES (4,5,'2021-01-22',1,NULL,NULL);
INSERT INTO `orders` VALUES (5,14,'2021-08-25',2,'','2021-08-26');
INSERT INTO `orders` VALUES (6,3,'2021-01-18',1,NULL,NULL);
INSERT INTO `orders` VALUES (7,6,'2021-09-02',2,'Very big order','2021-09-03');
INSERT INTO `orders` VALUES (8,11,'2021-06-08',1,NULL,NULL);
INSERT INTO `orders` VALUES (9,13,'2021-07-05',2,NULL,'2021-07-06');
INSERT INTO `orders` VALUES (10,4,'2021-01-30',1,NULL,NULL);
INSERT INTO `orders` VALUES (11,9,'2021-08-02',2,NULL,'2021-08-03');
INSERT INTO `orders` VALUES (12,15,'2020-12-01',1,NULL,NULL);
INSERT INTO `orders` VALUES (13,7,'2021-01-22',1,NULL,NULL);
INSERT INTO `orders` VALUES (14,8,'2021-08-25',2,'','2021-08-26');
INSERT INTO `orders` VALUES (15,14,'2021-09-16',1,NULL,NULL);
#INSERT INTO `orders` VALUES (15,12,'2021-04-22',2,NULL,'2021-04-23');

CREATE TABLE `order_items` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_order_items_products_idx` (`product_id`),
  CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `order_items` VALUES (1,4,4);
INSERT INTO `order_items` VALUES (2,4,4);
INSERT INTO `order_items` VALUES (2,6,2);
INSERT INTO `order_items` VALUES (3,13,1);
INSERT INTO `order_items` VALUES (4,3,1);
INSERT INTO `order_items` VALUES (5,10,7);
INSERT INTO `order_items` VALUES (5,2,6);
INSERT INTO `order_items` VALUES (5,18,2);
INSERT INTO `order_items` VALUES (6,1,1);
INSERT INTO `order_items` VALUES (6,12,4);
INSERT INTO `order_items` VALUES (6,13,4);
INSERT INTO `order_items` VALUES (6,5,2);
INSERT INTO `order_items` VALUES (7,3,1);
INSERT INTO `order_items` VALUES (8,15,2);
INSERT INTO `order_items` VALUES (9,16,4);
INSERT INTO `order_items` VALUES (10,1,1);
INSERT INTO `order_items` VALUES (10,13,1);
INSERT INTO `order_items` VALUES (10,16,1);
INSERT INTO `order_items` VALUES (10,9,2);
INSERT INTO `order_items` VALUES (10,18,2);
INSERT INTO `order_items` VALUES (10,6,2);
INSERT INTO `order_items` VALUES (10,10,2);
INSERT INTO `order_items` VALUES (11,6,1);
INSERT INTO `order_items` VALUES (12,1,1);
INSERT INTO `order_items` VALUES (13,8,4);
INSERT INTO `order_items` VALUES (14,11,2);
INSERT INTO `order_items` VALUES (15,10,2);
#INSERT INTO `order_items` VALUES (15,4,4);





