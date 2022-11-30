CREATE TABLE `distributor` (
  `distributor_code` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `gender` char(1) NOT NULL,
  PRIMARY KEY (`distributor_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert  into `distributor`(`distributor_code`,`name`,`address`,`city`,`gender`) values 
(1,'Dony Prawita','Jln. Kakak Tua No. 20','Denpasar','L'),
(2,'Agus Surya','Jln. Ahmad Yani No. 12','Singaraja','L'),
(3,'Agustina','Jln. Merak No. 34','Denpasar','P'),
(4,'Agus Sanjaya','Jln. Laksamana No. 1','Singaraja','L'),
(5,'Windhyarmawan','Jln. Durian No. 70','Klungkung','L'),
(6,'Agus Nurmansyah','Jln. Komodo No. 10','Tabanan','L'),
(7,'Dewi Lestina Sari','Jln. Pramuka No. 2','Gianyar','P'),
(8,'Endah Setiana','Jln. Melon No. 1','Gianyar','P'),
(9,'Indah Purnama S. ','Jln. Yudistira No. 54','Karangasem','P'),
(10,'Hendra Tresnadana','Jln. Dewi Sartika No. 5','Singaraja','L');

CREATE TABLE `product` (
  `product_code` varchar(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `distributor_code` int(11) NOT NULL,
  KEY `distributor_code` (`distributor_code`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`distributor_code`) REFERENCES `distributor` (`distributor_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert  into `product`(`product_code`,`product_name`,`distributor_code`) values 
('P001','Dove',1),
('P002','Pepsodent',4),
('P003','Sunlight',2),
('P004','Cusson',4),
('P005','Baygon',5),
('P006','CloseUp',6),
('P007','Rinso',8),
('P008','Molto',9),
('P009','Indomilk',3),
('P010','Sunsilk',10),
('P011','Indomie',2);

-- 1.Tampilkan nama distributor beserta kode barang dan nama barang yang didistribusikan oleh distributor tersebut, urutkan hasilnya berdasarkan nama distributor sesuai urutan alphabet
SELECT distributor.name, product.product_code, product.product_name
FROM distributor
INNER JOIN product ON distributor.distributor_code = product.distributor_code
ORDER BY distributor.name ASC;

-- 2.Tampilkan name, city dan address dari distributor yang belum mendistribusikan barang (kode distributor tidak ada di tabel product) use JOIN
SELECT distributor.name, distributor.city, distributor.address
FROM distributor
LEFT JOIN product ON distributor.distributor_code = product.distributor_code
WHERE product.distributor_code IS NULL;

-- 3.Tampilkan kode distributor dan nama distributor beserta frekuensi barang yang didistribusikan, baik telah mendistribusikan barang maupun yang belum (dapat dilihat dari tabel product). Urutkan mulai dari distributor dengan frekuensi order terbanyak.
SELECT distributor.distributor_code, distributor.name, COUNT(product.product_code) AS frekuensi
FROM distributor
LEFT JOIN product ON distributor.distributor_code = product.distributor_code
GROUP BY distributor.distributor_code
ORDER BY frekuensi DESC;

-- 4.Tampilkan gabungan data yang berisi list kode distributor yang telah mendistribusikan barang list kode distributor (diperbolehkan menampilkan duplicate value)
SELECT distributor_code
FROM product
UNION ALL
SELECT distributor_code
FROM distributor;



