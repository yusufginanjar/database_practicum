create table mahasiswa ( id int auto_increment primary key, nim int, name varchar(255), city_address varchar(255), age int, ipk float, department varchar(255) );

insert into mahasiswa (nim, name, city_address, age, ipk, department) values 
    (12345, 'Adi', 'Jakarta', 17, 2.5, 'Math'),
    (12346, 'Ani', 'Yogyakarta', 18, 2.1, 'Math'), 
    (12347, 'Ari', 'Surabaya', 20, 2.5, 'Computer'), 
    (12348, 'Ali', 'Banjarmasin', 20, 3.5, 'Computer'), 
    (12349, 'Abi', 'Medan', 17, 3.7, 'Computer'), 
    (12350, 'Budi', 'Jakarta', 19, 3.8, 'Computer'), 
    (12351, 'Boni', 'Yogyakarta', 20, 3.2, 'Computer'), 
    (12352, 'Bobi', 'Surabaya', 17, 2.7, 'Computer'), 
    (12353, 'Beni', 'Banjarmasin', 18, 2.3, 'Computer'), 
    (12354, 'Cepi', 'Jakarta', 20, 2.2, null), 
    (12355, 'Coni', 'Yogyakarta', 22, 2.6, null), 
    (12356, 'Ceki', 'Surabaya', 21, 2.5, 'Math'), 
    (12357, 'Dodi', 'Jakarta', 20, 3.1, 'Math'), 
    (12358, 'Didi', 'Yogyakarta', 19, 3.2, 'Physics'), 
    (12359, 'Deri', 'Surabaya', 19, 3.3, 'Physics'), 
    (12360, 'Eli', 'Jakarta', 20, 2.9, 'Physics'), 
    (12361, 'Endah', 'Yogyakarta', 18, 2.8, 'Physics'), 
    (12362, 'Feni', 'Jakarta', 17, 2.7, null), 
    (12363, 'Farah', 'Yogyakarta', 18, 3.5, null), 
    (12364, 'Fandi', 'Surabaya', 19, 3.4, null);


-- Language: sql
-- 1.Tampilkan kolom city address tanpa duplikat pakai group by
select city_address from mahasiswa group by city_address;

--2.Tampilkan ipk maksimum mahasiswa dari Jakarta
select max(ipk) from mahasiswa group by city_address having city_address = 'Jakarta';

-- 3.Tampilkan ipk minimum dari mahasiswa jurusan Komputer
select min(ipk) from mahasiswa group by department having department = 'Computer';

-- 4.Tampilkan jumlah mahasiswa di departemen Komputer
select count(*) from mahasiswa group by department having department = 'Computer';

-- 5.Tampilkan IPK rata-rata dari mahasiswa jurusan matematika
select format(avg(ipk), 2) from mahasiswa group by department having department = 'Math';

-- 6.Tampilkan jumlah data mahasiswa di setiap jurusan
select department, count(*) from mahasiswa group by department;

-- 7.Tampilkan jumlah data mahasiswa dari city yang berbeda
select city_address, count(*) from mahasiswa group by city_address;

-- 8.Tampilkan data jumlah kelompok mahasiswa berdasarkan alamat kota dengan usia dibawah 20 tahun
select city_address, count(city_address) from mahasiswa where age < 20 group by city_address;
