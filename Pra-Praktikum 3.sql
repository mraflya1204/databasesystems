CREATE TABLE customer(
	id_customer CHAR(6) PRIMARY KEY NOT NULL,
	nama_customer VARCHAR(100) NOT NULL
);

CREATE TABLE membership(
	id_membership CHAR(6) PRIMARY KEY NOT NULL,
	no_telp_customer VARCHAR(15) NOT NULL,
	alamat_customer VARCHAR(150) NOT NULL,
	tanggal_pembuatan DATE NOT NULL,
	tanggal_kadaluwarsa DATE NOT NULL,
	total_point INT,
	m_id_customer CHAR(6) NOT NULL,
	FOREIGN KEY (m_id_customer) REFERENCES customer(id_customer) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE pegawai(
	nik CHAR(16) PRIMARY KEY NOT NULL,
	nama_pegawai VARCHAR(100) NOT NULL,
	jenis_kelamin CHAR(1),
	email VARCHAR(50),
	umur INT NOT NULL,
	telepon VARCHAR(15)
);


CREATE TABLE transaksi(
	id_transaksi CHAR(10) PRIMARY KEY NOT NULL,
	tanggal_transaksi DATE NOT NULL,
	metode_pembayaran VARCHAR(15) NOT NULL,
	t_id_customer CHAR(6) NOT NULL,
	t_pegawai_nik CHAR(16) NOT NULL,
	FOREIGN KEY (t_id_customer) REFERENCES customer(id_customer),
	FOREIGN KEY (t_pegawai_nik) REFERENCES pegawai(nik)
);

CREATE TABLE menu_minuman(
	id_minuman CHAR(6) PRIMARY KEY NOT NULL,
	nama_minuman VARCHAR(50) NOT NULL,
	harga_minuman FLOAT(2) NOT NULL
);

CREATE TABLE transaksi_minuman(
	tm_menu_minuman_id CHAR(6) NOT NULL,
	tm_transaksi_id CHAR(10) NOT NULL,
	jumlah_minuman INT NOT NULL,
	CONSTRAINT transaksi_minuman_pk PRIMARY KEY (tm_menu_minuman_id, tm_transaksi_id),
	FOREIGN KEY (tm_menu_minuman_id) REFERENCES menu_minuman(id_minuman),
	FOREIGN KEY (tm_transaksi_id) REFERENCES transaksi(id_transaksi)
);

INSERT INTO customer (id_customer, nama_customer) 
VALUES
('CTR001', 'Budi Santoso'),
('CTR002', 'Sisil Triana'),
('CTR003', 'Davi Liam'),
('CTR004', 'Sutris Ten An'),
('CTR005', 'Hendra Asto');

INSERT INTO membership (id_membership, no_telp_customer, alamat_customer, tanggal_pembuatan, tanggal_kadaluwarsa, total_point, m_id_customer) 
VALUES
('MBR001', '08123456789', 'Jl. Imam Bonjol', '2023-10-24', '2023-11-30', 0, 'CTR001'),
('MBR002', '0812345678', 'Jl. Kelinci', '2023-10-24', '2023-11-30', 0, 'CTR002'),
('MBR003', '081234567890', 'Jl. Abah Ojak', '2023-10-25', '2023-12-01', 2, 'CTR003'),
('MBR004', '08987654321', 'Jl. Kenangan', '2023-10-26', '2023-12-02', 6, 'CTR005');

INSERT INTO menu_minuman (id_minuman, nama_minuman, harga_minuman) 
VALUES
('MNM001', 'Expresso', 18000),
('MNM002', 'Cappucino', 20000),
('MNM003', 'Latte', 21000),
('MNM004', 'Americano', 19000),
('MNM005', 'Mocha', 22000),
('MNM006', 'Macchiato', 23000),
('MNM007', 'Cold Brew', 21000),
('MNM008', 'Iced Coffe', 18000),
('MNM009', 'Affogato', 23000),
('MNM010', 'Coffe Frappe', 22000);

INSERT INTO pegawai (nik, nama_pegawai, jenis_kelamin, email, umur, telepon) 
VALUES
('1111222233334444', 'Maimunah', 'P', 'maimunah@gmail.com', 25, '621234567'),
('1234567890123456', 'Naufal Raf', 'L', 'naufal@gmail.com', 19, '62123456789'),
('2345678901234561', 'Surinala', 'P', 'surinala@gmail.com', 24, '621234567890'),
('3456789012345612', 'Ben John', 'L', 'benjohn@gmail.com', 22, '6212345678');

INSERT INTO transaksi (id_transaksi, tanggal_transaksi, metode_pembayaran, t_id_customer, t_pegawai_nik) 
VALUES
('TRX0000001', '2023-10-01', 'Kartu kredit', 'CTR002', '2345678901234561'),
('TRX0000002', '2023-10-03', 'Transfer bank', 'CTR004', '3456789012345612'),
('TRX0000003', '2023-10-05', 'Tunai', 'CTR001', '3456789012345612'),
('TRX0000004', '2023-10-15', 'Kartu debit', 'CTR003', '1234567890123456'),
('TRX0000005', '2023-10-15', 'E-wallet', 'CTR004', '1234567890123456'),
('TRX0000006', '2023-10-21', 'Tunai', 'CTR001', '2345678901234561'),
('TRX0000007', '2023-10-03', 'Transfer bank', 'CTR004', '2345678901234561');

INSERT INTO transaksi_minuman (tm_menu_minuman_id, tm_transaksi_id, jumlah_minuman) 
VALUES
('MNM001', 'TRX0000003', 3),
('MNM001', 'TRX0000005', 1),
('MNM003', 'TRX0000002', 2),
('MNM003', 'TRX0000003', 1),
('MNM003', 'TRX0000006', 2),
('MNM004', 'TRX0000004', 2),
('MNM005', 'TRX0000002', 1),
('MNM005', 'TRX0000007', 1),
('MNM006', 'TRX0000005', 2),
('MNM007', 'TRX0000001', 1),
('MNM009', 'TRX0000005', 1),
('MNM010', 'TRX0000001', 1),
('MNM010', 'TRX0000004', 1);

--1--
SELECT * FROM transaksi
WHERE tanggal_transaksi >= '10-10-2023' AND tanggal_transaksi <='20-10-2023';

--2--
SELECT 
	id_transaksi, 
	SUM(jumlah_minuman * harga_minuman) AS total_harga
FROM transaksi 
	JOIN transaksi_minuman ON id_transaksi = tm_transaksi_id
	JOIN menu_minuman ON tm_menu_minuman_id = id_minuman
GROUP BY id_transaksi
ORDER BY id_transaksi;

--3--
SELECT 
	id_customer, 
	nama_customer, 
	SUM(jumlah_minuman*harga_minuman) AS total_belanja 
FROM CUSTOMER
	JOIN transaksi ON id_customer = t_id_customer
	JOIN transaksi_minuman ON id_transaksi = tm_transaksi_id
	JOIN menu_minuman ON tm_menu_minuman_id = id_minuman
WHERE tanggal_transaksi >= '3-10-2023' AND tanggal_transaksi <= '22-10-2023'
GROUP BY id_customer
ORDER BY nama_customer;

--4--
SELECT
	nik,
	nama_pegawai,
	jenis_kelamin,
	umur,
	telepon,
	email
FROM PEGAWAI
	JOIN transaksi ON nik = t_pegawai_nik
	JOIN customer ON t_id_customer = id_customer
WHERE nama_customer IN ('Davi Liam', 'Sisil Triana', 'Hendra Asto')
GROUP BY nik;

--5--
SELECT
	EXTRACT(MONTH FROM tanggal_transaksi) AS BULAN,
	EXTRACT(YEAR FROM tanggal_transaksi) AS TAHUN,
	SUM (jumlah_minuman) AS jumlah_cup
FROM transaksi
JOIN transaksi_minuman ON id_transaksi = tm_transaksi_id
GROUP BY 
	EXTRACT(MONTH FROM tanggal_transaksi),
	EXTRACT(YEAR FROM tanggal_transaksi)
ORDER BY 
	TAHUN DESC, BULAN ASC;


--6--
SELECT 
	ROUND(SUM(harga_minuman*jumlah_minuman)/COUNT(DISTINCT id_customer)) AS rata_rata
FROM CUSTOMER
	JOIN transaksi ON id_customer = t_id_customer
	JOIN transaksi_minuman ON id_transaksi = tm_transaksi_id
	JOIN menu_minuman ON tm_menu_minuman_id = id_minuman;

--7--
SELECT 
	id_customer,
	nama_customer,
	SUM(harga_minuman*jumlah_minuman) AS total_belanja
FROM CUSTOMER
	JOIN transaksi ON id_customer = t_id_customer
	JOIN transaksi_minuman ON id_transaksi = tm_transaksi_id
	JOIN menu_minuman ON tm_menu_minuman_id = id_minuman
GROUP BY id_customer
HAVING SUM(harga_minuman*jumlah_minuman) >= 
	(
		SELECT 
			ROUND(SUM(harga_minuman*jumlah_minuman)/COUNT(DISTINCT id_customer)) AS rata_rata
		FROM CUSTOMER
			JOIN transaksi ON id_customer = t_id_customer
			JOIN transaksi_minuman ON id_transaksi = tm_transaksi_id
			JOIN menu_minuman ON tm_menu_minuman_id = id_minuman
	);
 
--8--
SELECT 
	id_customer,
	nama_customer
FROM customer
	LEFT JOIN membership ON id_customer = m_id_customer
WHERE id_membership IS NULL;

--9--
SELECT
	COUNT (id_customer) AS jumlah_customer
FROM customer
	JOIN transaksi ON id_customer = t_id_customer
	JOIN transaksi_minuman ON id_transaksi = tm_transaksi_id
	JOIN menu_minuman ON id_minuman = tm_menu_minuman_id
WHERE nama_minuman = 'Latte';

--10--
SELECT 
	nama_customer,
	id_minuman,
	nama_minuman,
	harga_minuman,
	jumlah_minuman
FROM customer
	JOIN transaksi ON id_customer = t_id_customer
	JOIN transaksi_minuman ON id_transaksi = tm_transaksi_id
	JOIN menu_minuman ON id_minuman = tm_menu_minuman_id
WHERE nama_customer LIKE 'S%'
ORDER BY nama_customer;