-- DDL - DATA DEFINATION LANG.
-- CREATE - TABLO OLUSTURMA
create table ogrenciler (
ogrenci_no char(7),--Uzunluğunu bildiğimiz stringler için CHAR kullanılır
isim varchar(20),--Uzunluğunu bilmediğimiz stringler için VARCHAR kullanılır
soyisim varchar(25),
not_ort real,--ondalıklı sayılar için kullanılır-Double gibi-
kayit_tarih date
);

--Benzer tablodaki başlıklarla ve data tipleriyle yeni bir tablo oluşturmak
--için normal tablo oluştururkenki parantezler yerine AS kullanıp SELECT
--komutuyla almak istediğimiz verileri alırız
create table ogrenci_not_ortalamaları
as select isim, soyisim, not_ort from ogrenciler

--DML-- Data manipulation language
--INSERT--Database veri ekleme
insert into ogrenciler values ('1234567', 'Resid', 'Ercan', 99.99, '1994-03-28');
insert into ogrenciler values ('1234321', 'Damla', 'Sahin', 100.00, '1993-11-23'); 

--Tabloya parçalı veri ekleme

insert into ogrenciler (isim, soyisim) values ('Damla', 'Resid');

--DQL-- Data Query Language
--SELECT 
select*from ogrenciler;
