---------------------------------------------------------------------
--                                                                 --
--    TITLE          :   MINI PROJECT                              --
--                                                                 --
--    MODULE         :   EE4202 DATABASE SYSTEMS                   --
--                                                                 --
--    TEAM MEMBERS   :   DISSANAYAKA U.G.D.T   -   EG/2019/3577    --
--                       DASANAYAKA S.V        -   EG/2019/3557    --
--                       DHARMARATHNA L.S.S.T  -   EG/2019/3568    --
--                                                                 --
---------------------------------------------------------------------


-------------------------------------------------
--          IMPLEMENTING DATABASE & TABLES     --
-------------------------------------------------

DROP DATABASE IF EXISTS pos;

CREATE DATABASE pos;

USE pos;

CREATE TABLE `product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `price` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `current_quantity` INT NOT NULL,
  `added_quantity` INT NOT NULL,
  `status` INT NOT NULL,
  `added_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
   PRIMARY KEY (`id`)
) ;



CREATE TABLE `coupen_code` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(100) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `discount` INT NOT NULL,
  `applicable_count` INT NOT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `applied_coupen` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `coupen_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `applied_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `discount` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `discount_amount` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
   PRIMARY KEY (`id`)
);


CREATE TABLE `notification` (
  `id` INT NOT NULL AUTO_INCREMENT,
   `title` varchar(100) NOT NULL,
   `content` varchar(500) NOT NULL,
   	PRIMARY KEY (`id`)
);

CREATE TABLE `order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cashier_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `total` INT NOT NULL,
  `payment` INT NOT NULL,
  `balance` INT NOT NULL,
  `added_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
   PRIMARY KEY (`id`)
);


CREATE TABLE `order_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `product_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `source_stock` INT NOT NULL,
  `destination_stock` INT NOT NULL,
  `added_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `returned_product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `prev_order_id` INT NOT NULL,
  `new_order_id` INT NOT NULL,
   `added_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
   PRIMARY KEY (`id`)
);


CREATE TABLE `stock` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
   PRIMARY KEY (`id`)
);


CREATE TABLE `category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `parent_id` INT DEFAULT NULL,
  PRIMARY KEY (`id`)
);


CREATE TABLE `cashier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `product_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `supplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `stock_id` INT NOT NULL,
  `first_name` VARCHAR(100),
  `last_name` VARCHAR(100),
  `email` VARCHAR(100),
  `phone_number` VARCHAR(20),
  PRIMARY KEY (`id`)
);



CREATE TABLE `luggage` (
  `rack_number` INT NOT NULL,
  `weight` INT NOT NULL,
  `customer_id` INT NOT NULL
);

----------------------------------------
--        IMPLEMENTING REFERENCES     --
----------------------------------------


ALTER TABLE `product` ADD CONSTRAINT product_fk_1 
FOREIGN KEY(`category_id`) 
REFERENCES `category` (`id`)
ON DELETE CASCADE;

ALTER TABLE `product` ADD CONSTRAINT product_fk_2
FOREIGN KEY(`stock_id`) 
REFERENCES `stock` (`id`)
ON DELETE CASCADE;


ALTER TABLE `product` ADD CONSTRAINT product_fk_3
FOREIGN KEY(`status`) 
REFERENCES `product_status` (`id`)
ON DELETE CASCADE;


ALTER TABLE `applied_coupen` ADD CONSTRAINT coupen_fk_1 
FOREIGN KEY(`coupen_id`) 
REFERENCES `coupen_code` (`id`)
ON DELETE CASCADE;


ALTER TABLE `applied_coupen` ADD CONSTRAINT coupen_fk_2
FOREIGN KEY(`order_id`) 
REFERENCES `order` (`id`)
ON DELETE CASCADE;

ALTER TABLE `discount` ADD CONSTRAINT discount_fk_1
FOREIGN KEY(`product_id`) 
REFERENCES `product` (`id`)
ON DELETE CASCADE;

ALTER TABLE `order` ADD CONSTRAINT order_fk_1
FOREIGN KEY(`customer_id`) 
REFERENCES `customer` (`id`)
ON DELETE CASCADE;

ALTER TABLE `order` ADD CONSTRAINT order_fk_2
FOREIGN KEY(`cashier_id`) 
REFERENCES `cashier` (`id`)
ON DELETE CASCADE;

ALTER TABLE `order_item` ADD CONSTRAINT order_item_fk_1
FOREIGN KEY(`order_id`) 
REFERENCES `order` (`id`)
ON DELETE CASCADE;

ALTER TABLE `order_item` ADD CONSTRAINT order_item_fk_2
FOREIGN KEY(`product_id`) 
REFERENCES `product` (`id`)
ON DELETE CASCADE;

ALTER TABLE `product_transaction` ADD CONSTRAINT product_transaction_fk_1
FOREIGN KEY(`product_id`) 
REFERENCES `product` (`id`)
ON DELETE CASCADE;

ALTER TABLE `product_transaction` ADD CONSTRAINT product_transaction_fk_2
FOREIGN KEY(`source_stock`) 
REFERENCES `stock` (`id`)
ON DELETE CASCADE;

ALTER TABLE `product_transaction` ADD CONSTRAINT product_transaction_fk_3
FOREIGN KEY(`destination_stock`) 
REFERENCES `stock` (`id`)
ON DELETE CASCADE;

ALTER TABLE `returned_product` ADD CONSTRAINT returned_product_fk_1
FOREIGN KEY(`product_id`) 
REFERENCES `product` (`id`)
ON DELETE CASCADE;

ALTER TABLE `returned_product` ADD CONSTRAINT returned_product_fk_2
FOREIGN KEY(`prev_order_id`) 
REFERENCES `order` (`id`)
ON DELETE CASCADE;

ALTER TABLE `returned_product` ADD CONSTRAINT returned_product_fk_3
FOREIGN KEY(`new_order_id`) 
REFERENCES `product` (`id`)
ON DELETE CASCADE;

ALTER TABLE `category` ADD CONSTRAINT category_fk_1
FOREIGN KEY(`parent_id`) 
REFERENCES `category` (`id`)
ON DELETE CASCADE;

ALTER TABLE `supplier` ADD CONSTRAINT supplier_fk_1
FOREIGN KEY(`stock_id`) 
REFERENCES `stock` (`id`)
ON DELETE CASCADE;

ALTER TABLE `luggage` ADD CONSTRAINT luggage_fk_1
FOREIGN KEY(`customer_id`) 
REFERENCES `customer` (`id`)
ON DELETE CASCADE;

-------------------------------------
--          INSERTING ITEMS        --
-------------------------------------

INSERT INTO `category` (`title`) VALUES ('Electronics');
INSERT INTO `category` (`title`) VALUES ('Foods');
INSERT INTO `category` (`title`) VALUES ('Grossery');
INSERT INTO `category` (`title`, `parent_id`) VALUES ('Mobile Phones', 1);
INSERT INTO `category` (`title`, `parent_id`) VALUES ('Laptops', 1);


INSERT INTO `cashier` (`username`, `password`) VALUES ('thilan', MD5('p455w07d1'));
INSERT INTO `cashier` (`username`, `password`) VALUES ('dissanayka', MD5('p455w07d2'));
INSERT INTO `cashier` (`username`, `password`) VALUES ('cashier_1', MD5('p455w07d3'));
INSERT INTO `cashier` (`username`, `password`) VALUES ('cashier_2', MD5('p455w07d4'));
INSERT INTO `cashier` (`username`, `password`) VALUES ('cashier_3', MD5('p455w07d5'));


INSERT INTO `coupen_code`
 (`code`, `start_date`, `end_date`, `discount`, `applicable_count`) 
 VALUES 
 ('HAPPYOCTOBER', '2022-10-01', '2022-10-31', '10', '1');

INSERT INTO `coupen_code`
 (`code`, `start_date`, `end_date`, `discount`, `applicable_count`) 
 VALUES 
 ('NEWYEARSALE', '2022-01-01', '2022-01-31', '15', '1');

INSERT INTO `coupen_code`
 (`code`, `start_date`, `end_date`, `discount`, `applicable_count`) 
 VALUES 
 ('HAPPYSEPTEMBER', '2022-09-01', '2022-09-10', '10', '1');

INSERT INTO `coupen_code`
 (`code`, `start_date`, `end_date`, `discount`, `applicable_count`) 
 VALUES 
 ('MERRYCRYSTMASS', '2022-12-01', '2022-12-31', '10', '1');

INSERT INTO `coupen_code`
 (`code`, `start_date`, `end_date`, `discount`, `applicable_count`) 
 VALUES 
 ('EATMORE', '2022-10-01', '2022-10-31', '15', '1');




INSERT INTO `customer` 
 (`first_name`, `last_name`, `email`, `phone_number`) 
 VALUES 
 ('Thilan', 'Dissanayaka', 'thil4n@gmail.com', '0775447294');

INSERT INTO `customer` 
 (`first_name`, `last_name`, `email`, `phone_number`) 
 VALUES 
 ('Test 1 F_name', 'Test 1 F_name', 'test1@gmail.com', '0775447294');

INSERT INTO `customer` 
 (`first_name`, `last_name`, `email`, `phone_number`) 
 VALUES 
 ('Test 2 F_name', 'Test 2 F_name', 'test3@gmail.com', '0775447294');

INSERT INTO `customer` 
 (`first_name`, `last_name`, `email`, `phone_number`) 
 VALUES 
 ('Test 3 F_name', 'Test 3 F_name', 'test3@gmail.com', '0775447294');

INSERT INTO `customer` 
 (`first_name`, `last_name`, `email`, `phone_number`) 
 VALUES 
 ('Test 4 F_name', 'Test 4 F_name', 'test4@gmail.com', '0775447294');



INSERT INTO `notification` 
 (`title`, `content`) 
 VALUES 
 ('Test Notification 1', 'This is the sample dummy text for the notification 1');

INSERT INTO `notification` 
 (`title`, `content`) 
 VALUES 
 ('Test Notification 2', 'This is the sample dummy text for the notification 2');

INSERT INTO `notification` 
 (`title`, `content`) 
 VALUES 
 ('Test Notification 3', 'This is the sample dummy text for the notification 3');

INSERT INTO `notification` 
 (`title`, `content`) 
 VALUES 
 ('Test Notification 4', 'This is the sample dummy text for the notification 4');

INSERT INTO `notification` 
 (`title`, `content`) 
 VALUES 
 ('Test Notification 5', 'This is the sample dummy text for the notification 5');



INSERT INTO `product_status` (`title`) VALUES ('Active');
INSERT INTO `product_status` (`title`) VALUES ('Sold');
INSERT INTO `product_status` (`title`) VALUES ('Rejected');
INSERT INTO `product_status` (`title`) VALUES ('Expired');
INSERT INTO `product_status` (`title`) VALUES ('Transferred');


INSERT INTO `stock` (`title`) VALUES ('Kandy City Center');
INSERT INTO `stock` (`title`) VALUES ('Kandy Main Branch');
INSERT INTO `stock` (`title`) VALUES ('Hapugala - Galle');
INSERT INTO `stock` (`title`) VALUES ('Galle Main Branch');
INSERT INTO `stock` (`title`) VALUES ('Colombo Main Branch');
INSERT INTO `stock` (`title`) VALUES ('Matara Main Branch');



INSERT INTO `supplier`
 (`stock_id`, `first_name`, `last_name`, `email`, `phone_number`)
  VALUES
  ('1', 'Supplier 1 F_Name', 'Supplier 1 L_Name', 'supplier1@gmail.com', '0775447294');

INSERT INTO `supplier`
 (`stock_id`, `first_name`, `last_name`, `email`, `phone_number`)
  VALUES
  ('2', 'Supplier 2 F_Name', 'Supplier 2 L_Name', 'supplier2@gmail.com', '0775447294');

INSERT INTO `supplier`
 (`stock_id`, `first_name`, `last_name`, `email`, `phone_number`)
  VALUES
  ('3', 'Supplier 3 F_Name', 'Supplier 3 L_Name', 'supplier3@gmail.com', '0775447294');

INSERT INTO `supplier`
 (`stock_id`, `first_name`, `last_name`, `email`, `phone_number`)
  VALUES
  ('4', 'Supplier 4 F_Name', 'Supplier 4 L_Name', 'supplier4@gmail.com', '0775447294');

INSERT INTO `supplier`
 (`stock_id`, `first_name`, `last_name`, `email`, `phone_number`)
  VALUES
  ('3', 'Supplier 5 F_Name', 'Supplier 5 L_Name', 'supplier5@gmail.com', '0775447294');

INSERT INTO `supplier`
 (`stock_id`, `first_name`, `last_name`, `email`, `phone_number`)
 VALUES
 ('2', 'Supplier 6 F_Name', 'Supplier 6 L_Name', 'supplier6@gmail.com', '0775447294');



INSERT INTO `order` 
 (`cashier_id`, `customer_id`, `total`, `payment`, `balance`, `added_date`) 
 VALUES 
 ('1', '4', '1200', '1500', '300', current_timestamp());

INSERT INTO `order` 
 (`cashier_id`, `customer_id`, `total`, `payment`, `balance`, `added_date`) 
 VALUES 
 ('1', '4', '1200', '1500', '300', current_timestamp());

INSERT INTO `order` 
 (`cashier_id`, `customer_id`, `total`, `payment`, `balance`, `added_date`) 
 VALUES 
('1', '4', '1200', '1500', '300', current_timestamp());

INSERT INTO `order` 
 (`cashier_id`, `customer_id`, `total`, `payment`, `balance`, `added_date`) 
 VALUES 
 ('1', '4', '1200', '1500', '300', current_timestamp());

INSERT INTO `order` 
(`cashier_id`, `customer_id`, `total`, `payment`, `balance`, `added_date`) 
VALUES 
('1', '4', '1200', '1500', '300', current_timestamp());

INSERT INTO `order` 
(`cashier_id`, `customer_id`, `total`, `payment`, `balance`, `added_date`) 
VALUES 
('1', '4', '1200', '1500', '300', current_timestamp());


INSERT INTO `product` 
(
  `category_id`, `title`, `price`, `stock_id`, `current_quantity`, 
  `added_quantity`,`status`, `added_date`
 ) 
VALUES 
('4', 'Redmi 9C', '25000', '1', '5', '5', '1', current_timestamp());

INSERT INTO `product` 
(
  `category_id`, `title`, `price`, `stock_id`, `current_quantity`, 
  `added_quantity`,`status`, `added_date`
 ) 
VALUES 
('5', 'Macbook air M1', '250000', '1', '5', '5', '1', current_timestamp());

INSERT INTO `product` 
(
  `category_id`, `title`, `price`, `stock_id`, `current_quantity`, 
  `added_quantity`,`status`, `added_date`
 ) 
VALUES 
('2', 'Red Apple', '150', '1', '5', '5', '1', current_timestamp());

INSERT INTO `product` 
(
  `category_id`, `title`, `price`, `stock_id`, `current_quantity`, 
  `added_quantity`,`status`, `added_date`
 ) 
VALUES 
('4', 'Samsung Galaxy Tab A', '45000', '1', '5', '5', '1', current_timestamp());

INSERT INTO `product` 
(
  `category_id`, `title`, `price`, `stock_id`, `current_quantity`, 
  `added_quantity`,`status`, `added_date`
 ) 
VALUES 
('5', 'Macbook pro M1', '300000', '1', '5', '5', '1', current_timestamp());

INSERT INTO `product` 
(
  `category_id`, `title`, `price`, `stock_id`, `current_quantity`, 
  `added_quantity`,`status`, `added_date`
 ) 
VALUES 
('2', 'Birthday Cake', '2500', '1', '5', '5', '1', current_timestamp());


INSERT INTO `product_transaction` 
(`product_id`, `quantity`, `source_stock`, `destination_stock`, `added_date`) 
VALUES 
('2', '1', '5', '3', current_timestamp());

INSERT INTO `product_transaction` 
(`product_id`, `quantity`, `source_stock`, `destination_stock`, `added_date`) 
VALUES 
('2', '2', '1', '3', current_timestamp());
INSERT INTO `product_transaction` 
(`product_id`, `quantity`, `source_stock`, `destination_stock`, `added_date`) 
VALUES 
('1', '1', '5', '1', current_timestamp());

INSERT INTO `product_transaction` 
(`product_id`, `quantity`, `source_stock`, `destination_stock`, `added_date`) 
VALUES 
('3', '2', '5', '4', current_timestamp());

INSERT INTO `product_transaction` 
(`product_id`, `quantity`, `source_stock`, `destination_stock`, `added_date`) 
VALUES 
('2', '3', '5', '3', current_timestamp());

INSERT INTO `product_transaction` 
(`product_id`, `quantity`, `source_stock`, `destination_stock`, `added_date`) 
VALUES 
('1', '1', '1', '3', current_timestamp());


INSERT INTO `returned_product` 
(`product_id`, `quantity`, `prev_order_id`, `new_order_id`, `added_date`) 
VALUES 
('1', '1', '1', '2', current_timestamp());

INSERT INTO `returned_product` 
(`product_id`, `quantity`, `prev_order_id`, `new_order_id`, `added_date`) 
VALUES 
('2', '1', '1', '2', current_timestamp());

INSERT INTO `returned_product` 
(`product_id`, `quantity`, `prev_order_id`, `new_order_id`, `added_date`) 
VALUES 
('3', '1', '1', '2', current_timestamp());

INSERT INTO `returned_product` 
(`product_id`, `quantity`, `prev_order_id`, `new_order_id`, `added_date`) 
VALUES 
('2', '1', '1', '2', current_timestamp());

INSERT INTO `returned_product` 
(`product_id`, `quantity`, `prev_order_id`, `new_order_id`, `added_date`) 
VALUES 
('1', '1', '1', '2', current_timestamp());

INSERT INTO `returned_product` 
(`product_id`, `quantity`, `prev_order_id`, `new_order_id`, `added_date`) 
VALUES 
('2', '1', '1', '2', current_timestamp());



INSERT INTO `discount` 
(`product_id`, `discount_amount`, `start_date`, `end_date`) 
VALUES 
('1', '10', '2022-10-01', '2022-10-31');

INSERT INTO `discount` 
(`product_id`, `discount_amount`, `start_date`, `end_date`) 
VALUES 
('2', '10', '2022-10-01', '2022-10-31');

INSERT INTO `discount` 
(`product_id`, `discount_amount`, `start_date`, `end_date`) 
VALUES 
('1', '10', '2022-10-01', '2022-10-31');

INSERT INTO `discount` 
(`product_id`, `discount_amount`, `start_date`, `end_date`) 
VALUES 
('1', '10', '2022-10-01', '2022-10-31');

INSERT INTO `discount` 
(`product_id`, `discount_amount`, `start_date`, `end_date`) 
VALUES 
('3', '10', '2022-10-01', '2022-10-31');

INSERT INTO `discount` 
(`product_id`, `discount_amount`, `start_date`, `end_date`) 
VALUES 
('1', '10', '2022-10-01', '2022-10-31');




INSERT INTO `luggage` 
(`rack_number`, `weight`, `customer_id`) 
VALUES 
('10', '100', '2');


-------------------------------------
--           UPDATING ITEMS        --
-------------------------------------

UPDATE `category` SET `title` = 'Electronic Items' WHERE id = 1;
UPDATE `category` SET `title` = 'Food Items' WHERE id = 2;

UPDATE `cashier` SET `password` = MD5('p455w07d') WHERE id = 1;
UPDATE `cashier` SET `password` = MD5('p455w07d') WHERE id = 2;

UPDATE `coupen_code` SET `applicable_count` =  '2' WHERE id = 1;
UPDATE `coupen_code` SET `applicable_count` =  '3' WHERE id = 2;

UPDATE `customer` SET `email` = 'thil4n@hacksland.net' WHERE id = 1;
UPDATE `customer` SET `email` = 'admin@hacksland.net' WHERE id = 2;

UPDATE `notification` SET `title` = 'Test Notification Edited' WHERE id = 1;
UPDATE `notification` SET `title` = 'Test Notification Edited' WHERE id = 2;

UPDATE `product_status` SET `title` = 'Active' WHERE id = 1;
UPDATE `product_status` SET `title` = 'Active' WHERE id = 1;

UPDATE `stock` SET `title` = 'Kandy Branch' WHERE id = 2;
UPDATE `stock` SET `title` = 'Kandy Branch' WHERE id = 2;

UPDATE `supplier` SET `stock_id` = 2 WHERE id = 1;
UPDATE `supplier` SET `stock_id` = 3 WHERE id = 2;

UPDATE `order` SET `cashier_id` = 2 WHERE id = 1;
UPDATE `order` SET `cashier_id` = 2 WHERE id = 1;

UPDATE `product` SET `current_quantity` = 5 WHERE id = 1;
UPDATE `product` SET `current_quantity` = 5 WHERE id = 1;

UPDATE `product_transaction` SET `quantity` = 2 WHERE id = 1;
UPDATE `product_transaction` SET `quantity` = 2 WHERE id = 1;

UPDATE `returned_product` SET `quantity` = 3 WHERE id = 1;
UPDATE `returned_product` SET `quantity` = 2 WHERE id = 2;

UPDATE `discount` SET `discount_amount` = 15 WHERE id = 1;
UPDATE `discount` SET `discount_amount` = 10 WHERE id = 1;



--------------------------------------
--          DELETING ITEMS          --
--------------------------------------

DELETE FROM `category` WHERE id = 1;

DELETE FROM `cashier` WHERE id = 1;

DELETE FROM `coupen_code`  WHERE id = 1;

DELETE FROM `customer`  WHERE id = 1;

DELETE FROM `notification`  WHERE id = 1;

DELETE FROM `product_status` WHERE id = 1;

DELETE FROM `stock` WHERE id = 2;

DELETE FROM `supplier` WHERE id = 1;

DELETE FROM `order` WHERE id = 1;

DELETE FROM `product` WHERE id = 1;

DELETE FROM `product_transaction` WHERE id = 1;

DELETE FROM `returned_product` WHERE id = 1;

DELETE FROM `discount` WHERE id = 1;



--------------------------------------
--         SELECTING ITEMS          --
--------------------------------------

SELECT * FROM `customer`;

SELECT `first_name`,`email` FROM `customer`;

SELECT * FROM `customer` CROSS JOIN `order`;

CREATE VIEW `temp_view` AS SELECT * FROM `order` WHERE total > 1000;
SELECT `customer_id` FROM  `temp_view`;
DROP VIEW `temp_view`;

SELECT concat(`first_name`, ' ', `last_name`) AS `name` FROM customer;

SELECT MAX(`total`) AS `maximum_total` FROM `order`;

SELECT * FROM `stock` WHERE `title` LIKE '%Branch%';


SELECT * FROM `stock` WHERE `title` LIKE '%Branch%' 
UNION 
SELECT * FROM `stock` WHERE `title` LIKE '%Galle%';


SELECT * FROM `stock` t1  INNER JOIN `stock` t2 ON t1.id = t2.id WHERE t1.title LIKE '%Branch%' AND t2.title LIKE '%Galle%';

SELECT id FROM `stock` WHERE title LIKE '%Branch%' AND id NOT IN  (SELECT id FROM `stock` WHERE title LIKE '%Galle%');

