CREATE TABLE `tb_location` (
  `location_code` varchar(6) NOT NULL,
  `location_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`location_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert  into `tb_location`(`location_code`,`location_name`) values 
('INFO01','Laboratorium 1 M Informatika'),
('INFO02','Laboratorium 2 M Informatika'),
('INFO03','Ruang Dosen M Informatika');

CREATE TABLE `tb_product` (
  `type_code` varchar(6) NOT NULL,
  `location_code` varchar(6) NOT NULL,
  `product_code` varchar(6) NOT NULL,
  `product_name` varbinary(100) DEFAULT NULL,
  `total` int(5) DEFAULT NULL,
  PRIMARY KEY (`type_code`,`location_code`,`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert  into `tb_product`(`type_code`,`location_code`,`product_code`,`product_name`,`total`) values 
('A001','INFO02','AP004','Papan Tulis',11),
('E001','INFO01','EK0014','Komputer',2),
('E001','INFO01','EK0015','Printer',3),
('E001','INFO01','EK0016','LCD Projector',1),
('E001','INFO02','EK0014','Komputer',8),
('E001','INFO02','EK0015','Printer',6),
('E001','INFO02','EK0016','LCD Projector',2),
('M001','INFO01','MM011','Meja Komputer',35),
('M001','INFO01','MM012','Kursi Hidrolik',30),
('M001','INFO02','MM011','Meja Komputer',45),
('M001','INFO03','MM012','Kursi Hidrolik',10);

CREATE TABLE `tb_type` (
  `type_code` varchar(6) NOT NULL,
  `type_name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert  into `tb_type`(`type_code`,`type_name`,`description`) values 
('A001','ATK','alat tulis kantor'),
('E001','Alat-alat elektronik','alat elektronik'),
('M001','Mebeler','alat mebel');


-- Buatlah query SQL menggunakan subquery untuk:
-- 1.Menampilkan kode barang, nama barang beserta jumlahnya yang berada di lokasi "Laboratorium 2 M Informatika"
SELECT product_code, product_name, total
FROM tb_product
WHERE location_code = 
  (SELECT location_code FROM tb_location 
  WHERE location_name = 'Laboratorium 2 M Informatika');

-- 2.Menampilkan kode barang, nama barang yang berjenis "Alat-alat elektronik" dan seluruh barang yang ada di "Ruang Dosen M Informatika"
SELECT product_code, product_name
FROM tb_product
WHERE type_code = 
  (SELECT type_code FROM tb_type 
  WHERE type_name = 'Alat-alat elektronik')
OR location_code = 
  (SELECT location_code FROM tb_location 
  WHERE location_name = 'Ruang Dosen M Informatika');

-- 3.Menampilkan kode barang, nama barang dan jumlah barang yang merupakan jenis "Alat-alat elektronik" dan "Mebeler" yang terletak di "Laboratorium 2 M Informatika"
SELECT product_code, product_name, total
FROM tb_product
WHERE type_code IN 
  (SELECT type_code FROM tb_type 
  WHERE type_name IN ('Alat-alat elektronik', 'Mebeler'))
AND location_code =
  (SELECT location_code FROM tb_location 
  WHERE location_name = 'Laboratorium 2 M Informatika');

-- 4.Menampilkan semua informasi barang selain jenis "Mebeler"yang berada di "Laboratorium 2 M Informatika" 
SELECT * FROM tb_product
WHERE type_code <> 
  (SELECT type_code FROM tb_type 
  WHERE type_name = 'Mebeler')
AND location_code =
  (SELECT location_code FROM tb_location 
  WHERE location_name = 'Laboratorium 2 M Informatika');

-- 5.Menambahkan barang dengan nama "Spidol" dengan kode barang "AP005" dan informasi barang lain sama dengan "Papan Tulis" tetapi jumlah barang 2 kali lipat dari jumlah "Papan Tulis"
INSERT INTO tb_product (type_code, location_code, product_code, product_name, total)
SELECT type_code, location_code, 'AP005', 'Spidol', total * 2
FROM tb_product
WHERE product_name = 'Papan Tulis';

-- 6.Menambahkan "Kabel HDMI" yang akan di tempatkan di "Ruang Dosen M Informatika" dengan kode barang "EK0017", jenis 'E001', dan berjumlah sama dengan seluruh "LCD Projector"
INSERT INTO tb_product (type_code, location_code, product_code, product_name, total)
SELECT 'E001', location_code, 'EK0017', 'Kabel HDMI', total
FROM tb_product
WHERE product_name = 'LCD Projector';

-- 7.Mengubah jumlah "Komputer" yang ada di "Laboratorium 1 M Informatika" sesuai dengan jumlah "Meja Komputer" di ruangan tersebut
UPDATE tb_product
SET total = 
  (SELECT total FROM tb_product 
  WHERE product_name = 'Meja Komputer'
  AND location_code = 
    (SELECT location_code FROM tb_location 
    WHERE location_name = 'Laboratorium 1 M Informatika'))
WHERE product_name = 'Komputer'
AND location_code =
  (SELECT location_code FROM tb_location 
  WHERE location_name = 'Laboratorium 1 M Informatika');

-- 8.Mengubah seluruh jumlah "Kursi Hidrolik" di setiap ruangan dengan jumlah minimum dari "Meja Komputer"
UPDATE tb_product
SET total = 
  (SELECT MIN(total) FROM tb_product 
  WHERE product_name = 'Meja Komputer')
WHERE product_name = 'Kursi Hidrolik';

-- 9.Menghapus seluruh data barang yang ada di lokasi "Ruang Dosen M Informatika"
DELETE FROM tb_product
WHERE location_code =
  (SELECT location_code FROM tb_location 
  WHERE location_name = 'Ruang Dosen M Informatika');

-- 10.Menghapus seluruh data barang di lokasi "Laboratorium 2 M Informatika" yang bukan merupakan jenis "Mebeler"
DELETE FROM tb_product
WHERE location_code =
  (SELECT location_code FROM tb_location 
  WHERE location_name = 'Laboratorium 2 M Informatika')
AND type_code <>
  (SELECT type_code FROM tb_type 
  WHERE type_name = 'Mebeler');