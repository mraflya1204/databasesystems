--1--
CREATE TABLE Customer(
	ID_customer char(6) PRIMARY KEY NOT NULL,
	Nama_customer varchar(100) NOT NULL
);

CREATE TABLE Pegawai(
	NIK char(16) PRIMARY KEY NOT NULL,
	Nama_pegawai varchar(100) NOT NULL,
	Jenis_kelamin char(1),
	Email varchar(50),
	Umur int NOT NULL
);

CREATE TABLE Transaksi (
	ID_transaksi char(10) PRIMARY KEY NOT NULL,
	Tanggal_transaksi DATE NOT NULL,
	Metode_pembayaran varchar(15) NOT NULL,
	Customer_ID_customer char(16) NOT NULL,
	Pegawai_NIK char(16) NOT NULL,
	FOREIGN KEY (Customer_ID_customer) REFERENCES Customer(ID_customer),
	FOREIGN KEY (Pegawai_NIK) REFERENCES Pegawai(NIK)
);

CREATE TABLE Telepon(
	No_telp_pegawai varchar(15) PRIMARY KEY NOT NULL,
	Pegawai_NIK char(16) NOT NULL,
	FOREIGN KEY (Pegawai_NIK) REFERENCES Pegawai(NIK)
);

CREATE TABLE Menu_minuman(
	ID_minuman char(6) PRIMARY KEY NOT NULL,
	Nama_minuman varchar(50) NOT NULL,
	Harga_minuman float(2)
);

CREATE TABLE Transaksi_minuman(
	TM_Menu_Minuman_ID char(6) NOT NULL,
	TM_transaksi_ID char(10) NOT NULL,
	Jumlah_cup int NOT NULL,
	CONSTRAINT PK_Transaksi_minuman
		PRIMARY KEY(TM_Menu_Minuman_ID, TM_transaksi_ID),
	FOREIGN KEY (TM_Menu_Minuman_ID) REFERENCES Menu_minuman(ID_minuman),
	FOREIGN KEY (TM_transaksi_ID) REFERENCES Transaksi(ID_transaksi)
);


--2--
CREATE TABLE Membership(
	ID_membership CHAR(6) NOT NULL,
	No_telepon_customer varchar(15) NOT NULL,
	alamat_customer VARCHAR(100) NOT NULL,
	Tanggal_pembuatan_kartu_membership DATE NOT NULL,
	Tanggal_kedaluwarsa_kartu_membership DATE,
	Total_point int NOT NULL,
	Customer_ID_customer CHAR(6)
);

--2A--
ALTER TABLE Membership
ADD CONSTRAINT p_key PRIMARY KEY  (ID_membership);

--2B & 2C--
ALTER TABLE Membership
ADD CONSTRAINT f_key FOREIGN KEY (Customer_ID_customer) REFERENCES Customer(ID_customer) 
ON DELETE CASCADE  
ON UPDATE CASCADE;

--2D--
ALTER TABLE Membership
ALTER COLUMN Tanggal_pembuatan_kartu_membership SET DEFAULT CURRENT_DATE;

--2E--
ALTER TABLE Membership
ADD CHECK (membership.total_point>=0);

--2F--
ALTER TABLE Membership
ALTER COLUMN alamat_customer TYPE varchar(150);


--3--
DROP TABLE telepon;

ALTER TABLE pegawai
ADD COLUMN no_telepon_pegawai varchar(15);


--4--
INSERT INTO customer(id_customer, nama_customer)
VALUES
('CTR001', 'Budi Santoso'),
('CTR002', 'Sisil Triana'),
('CTR003', 'Davi Liam'),
('CTRo04', 'Sutris Ten An'),
('CTR005', 'Hendra Asto');

INSERT INTO membership(id_membership, no_telepon_customer, alamat_customer, tanggal_pembuatan_kartu_membership, tanggal_kedaluwarsa_kartu_membership, total_point, customer_id_customer)
VALUES
('MBR001', '08123456789', 'Jl. Imam Bonjol', '24-10-2023', '30-11-2023', 0, 'CTR001'),
('MBR002', '0812345678', 'Jl. Kelinci', '24-10-2023', '30-11-2023', 3, 'CTR002'),
('MBR003', '081234567890', 'Jl. Abah Ojak', '25-10-2023', '1-10-2023', 2, 'CTR003'),
('MBR004', '08987654321', 'Jl. Kenangan', '26-10-2023', '2-12-2023', 6, 'CTR005');

INSERT INTO pegawai(nik, nama_pegawai, jenis_kelamin, email, umur, no_telepon_pegawai)
VALUES
('1234567890123456', 'Naufal Raf', 'L', 'nuafal@gmail.com' , 19, '62123456789'),
('2345678901234561', 'Surinala', 'P', 'surinala@gmail.com', 24, '621234567890'),
('3456789012345612', 'Ben John', 'L', 'benjohn@gmail.com', 22, '6212345678');

INSERT INTO transaksi(id_transaksi, tanggal_transaksi, metode_pembayaran, customer_id_customer, pegawai_nik)
VALUES
('TRX0000001', '2023-10-01', 'Kartu kredit', 'CTR002', '2345678901234561'),
('TRX0000002', '2023-10-03', 'Transfer bank', 'CTRo04', '3456789012345612'),
('TRX0000003', '2023-10-05', 'Tunai', 'CTR001', '3456789012345612'),
('TRX0000004', '2023-10-15', 'Kartu debit', 'CTR003', '1234567890123456'),
('TRX0000005', '2023-10-15', 'E-wallet', 'CTRo04', '1234567890123456'),
('TRX0000006', '2023-10-21', 'Tunai', 'CTR001', '2345678901234561');

INSERT INTO menu_minuman(id_minuman, nama_minuman, harga_minuman)
VALUES
('MNM001', 'Expresso', 18000),
('MNM002', 'Cappuccino', 20000),
('MNM003', 'Latte', 21000),
('MNM004', 'Americano', 19000),
('MNM005', 'Mocha', 22000),
('MNM006', 'Macchiato', 23000),
('MNM007', 'Cold Brew', 21000),
('MNM008', 'Iced Coffee', 18000),
('MNM009', 'Affogato', 23000),
('MNM010', 'Coffee Frappe', 22000);

INSERT INTO transaksi_minuman(TM_transaksi_id, TM_Menu_Minuman_ID, jumlah_cup)
VALUES
('TRX0000005', 'MNM006', 2),
('TRX0000001', 'MNM010', 1),
('TRX0000002', 'MNM005', 1),
('TRX0000005', 'MNM009', 1),
('TRX0000003', 'MNM001', 3),
('TRX0000006', 'MNM003', 2),
('TRX0000004', 'MNM004', 2),
('TRX0000004', 'MNM010', 1),
('TRX0000002', 'MNM003', 2),
('TRX0000001', 'MNM007', 1),
('TRX0000005', 'MNM001', 1),
('TRX0000003', 'MNM003', 1);


--5--
INSERT INTO transaksi(id_transaksi, tanggal_transaksi, metode_pembayaran, customer_id_customer, pegawai_nik)
VALUES
('TRX0000007', '3-10-2023', 'Transfer bank', 'CTRo04', '2345678901234561');

INSERT INTO transaksi_minuman(TM_transaksi_id, TM_Menu_Minuman_ID, jumlah_cup)
VALUES
('TRX0000007', 'MNM005', 1);

--6--
INSERT INTO pegawai(nik, nama_pegawai, umur)
VALUES
('1111222233334444', 'Maimunah', 25);

--7--
ALTER TABLE transaksi_minuman
DROP CONSTRAINT transaksi_minuman_tm_transaksi_id_fkey;

ALTER TABLE transaksi_minuman
ADD CONSTRAINT fkey_id_minuman FOREIGN KEY (TM_Menu_Minuman_ID) REFERENCES Menu_minuman(ID_minuman) ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fkey_id_transaksi FOREIGN KEY (TM_transaksi_id) REFERENCES Transaksi(ID_transaksi) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE transaksi
DROP CONSTRAINT transaksi_customer_id_customer_fkey;

ALTER TABLE transaksi
ADD CONSTRAINT fkey_id_customer FOREIGN KEY (customer_ID_customer) REFERENCES customer(id_customer) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE customer	
SET id_customer = 'CTR004'
WHERE nama_customer = 'Sutris Ten An';

--8--
UPDATE pegawai
SET jenis_kelamin = 'P', no_telepon_pegawai = '621234567', email = 'maimunah@gmail.com'
WHERE nama_pegawai = 'Maimunah';

--9--
UPDATE membership
SET total_point = 0
WHERE tanggal_kedaluwarsa_kartu_membership <'1-12-2023'::date;

--10--
DELETE FROM membership;

--11--
DELETE FROM pegawai
WHERE nama_pegawai = 'Maimunah';