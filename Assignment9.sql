-- 1.Buatlah sebuah function untuk mengetahui harga grosir yang disesuaikan dengan jumlah barang yang akan dibeli. Semisal barang akan dapat diskon 10% apabila beli minimal 1 lusin, dan diskon 15% apabila beli minimal 100.

DELIMITER $$
CREATE FUNCTION getTotalPrice(quantity INT, price FLOAT) RETURNS FLOAT
BEGIN
DECLARE discount FLOAT;

IF quantity >= 100 THEN
SET discount = 15;
ELSEIF quantity >= 12 THEN
SET discount = 10;
ELSE
SET discount = 0;
END IF;

RETURN price * quantity * (100 - discount) / 100;
END$$
DELIMITER ;


SELECT * , priceEach * quantityOrdered AS 'Price', getTotalPrice(quantityOrdered, priceEach) AS 'Grosir Price' FROM `orderdetails`;

-- 2.Buatlah sebuah trigger untuk merekam history perubahan product serta buatlah tabel baru untuk menyimpan perubahan tersebut.

DELIMITER $$
CREATE TRIGGER `product_history` BEFORE UPDATE ON `products` FOR EACH ROW
BEGIN
INSERT INTO product_history (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP) VALUES (OLD.productCode, OLD.productName, OLD.productLine, OLD.productScale, OLD.productVendor, OLD.productDescription, OLD.quantityInStock, OLD.buyPrice, OLD.MSRP);
END$$
DELIMITER ;

CREATE TABLE `product_history` (
  `productCode` varchar(15) NOT NULL,
  `productName` varchar(70) NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `productScale` varchar(10) NOT NULL,
  `productVendor` varchar(50) NOT NULL,
  `productDescription` text NOT NULL,
  `quantityInStock` smallint(6) NOT NULL,
  `buyPrice` decimal(10,2) NOT NULL,
  `MSRP` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- update data products
UPDATE products SET buyPrice = 100 WHERE productCode = 'S18_3232';

