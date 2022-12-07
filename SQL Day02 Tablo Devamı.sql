--Constraint
--Unique
--Not null
create table ogrenciler2
(
ogrenci_no char (7) unique,
isim varchar (20) not null,
soyisim varchar (25),
not_ort real,
kayit_tarihi date);

select * from ogrenciler2;

insert into ogrenciler2 values ('1234567', 'Resid', 'Ercan', 99.00, '2022-12-02')
insert into ogrenciler2 values ('1234569', '', 'Sahin', 99.00, '2022-12-02')
--Not Null kısıtlaması olduğu için aşağıdaki veri eklenemez.
insert into ogrenciler2 (ogrenci_no, soyisim, not_ort, kayit_tarihi) values ('1234565', 'Ercan', 99.00, '2022-11-01');

--PRIMARY KEY ataması

create table ogrenciler3
(
ogrenci_no char (7) primary key,
isim varchar (20),
soyisim varchar (25),
not_ort real,
kayit_tarihi date);

--PRIMARY KEY ataması II. Yol

create table ogrenciler4
(
ogrenci_no char (7),
isim varchar (20),
soyisim varchar (25),
not_ort real,
kayit_tarihi date,
constraint ogr primary key (ogrenci_no)
);


--FOREİGN KEY 

create table tedarikciler3 (
tedarikci_id char(5) primary key,
tedarikci_ismi varchar (20),
iletisim_isim varchar (20)
);

--foreign key primary keyin childıdır
--iki tablo arasında foreign key ile primary key ile birlikte bağlantı kuruyoruz
--primary key olmadan ilişki kurulamaz
--primary parent -- foreign child class gibi düşünebiliriz.
create table urunler (
tedarikci_id char(5),
urun_id varchar (20),
foreign key(tedarikci_id) references tedarikciler3(tedarikci_id));
select * from urunler;

-------------------------------------

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama”
field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve
“sehir” fieldlari olsun.  “adres_id” field‘i ile Foreign Key oluşturun.
*/

create table calisanlar (
id char(5) primary key,
isim varchar(20) unique,
maas real not null,
ise_baslama date
);

create table adresler (
adres_id char(7),
sokak varchar(30),
cadde varchar(30),
sehir varchar(20),
foreign key (adres_id) references calisanlar(id));


INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');--Unique constraite  olduğu için kabul etmedi
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');--Not null constraite olduğu için kabul etmedi
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');--Unique constraite olduğu için kabul etmez
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');--Primary key hatası
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--Primary key hatası


INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');
select*from calisanlar;
select*from adresler;

--CHECK CONSTRAINT
--CHECK constraint nümeric olan yani sayısal olan değerlerde
--negatif değer girilmesini önlemek için kullanılan veya pozitif bir şart girebilmek için kullanılan bir constraitdir.
create table calisanlar1 (
id char(5) primary key,
isim varchar(20) unique,
maas real check(maas>10000),
ise_baslama date
);
--calisanlar1 tablosunda maaş kısmına CHECK ile 10000 ve üzeri değer girilmesi şartı koyduğumuz için
--aşağıdaki kod hata verecek.
INSERT INTO calisanlar1 VALUES('10001','Resid Ercan', 9000,'2018-03-28');--Check hatası
INSERT INTO calisanlar1 VALUES('10002','Resid Ercan', 11000,'2018-03-28');

---DQL--- Data Query Language
--WHERE kullanımı---
select * from calisanlar;--calisanlar tablosunun tamamını getirdi.
select isim, maas from calisanlar;--calisanlar tablosundaki isim ve maas bölümünü getirdi.

--Calisanlar tablosundan maası 5000'den büyük olan isimleri listeleyiniz
--WHERE ile maasi 5000'den büyük olanları sorgulayabiliyoruz
select isim, maas from calisanlar where maas>5000;

--Calisanlar tablosundan ismi Veli Han olan tüm verileri listeleyiniz.

select * from calisanlar where isim='Veli Han';

--Calisanlar tablosundan maasi 5000 olan tüm verileri listeleyiniz
select * from calisanlar where maas=5000;

--DML--
--DELETE KOMUTU
delete from calisanlar; -- Eğer parent table(primary key olan table) başka bir
--child table (foreign key olan) ile ilişkili ise önce child table silinmelidir
--diğer türlü hata alınır.
select*from adresler;

--Adresler tablosundan sehri Antep olan verileri silelim
delete from adresler where sehir='Antep';
--Daha önce 5 veri bulunurken şehri antep olanları sil diyerek
--3 veriye düşürdük


-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.

create table ogrenciler5(
id int,
isim varchar(50),
veli_isim varchar(50),
yazili_notu int
);

INSERT INTO ogrenciler5 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler5 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler5 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler5 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler5 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler5 VALUES(127, 'Mustafa Bak', 'Ali', 99);

select*from ogrenciler5;

delete from ogrenciler5 where isim='Nesibe Yilmaz' or isim='Mustafa Bak';