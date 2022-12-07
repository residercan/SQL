CREATE TABLE personel (
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20));

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

delete from personel

select * from personel;

--1)Isme gore toplam maaslari bulun

select sum(maas) from personel--tüm personelin maaslarının toplamını tek bir sonuc olarak verdi

select isim, sum(maas) from personel group by isim;--isim isim personellerin aldığı toplam maasları gösterdi

--personel tablosundaki isimleri gruplayınız

select isim from personel group by isim;

select sirket, count (*) as calisan_sayisi from personel where maas>5000 group by sirket;

--HAVİNG KULLANIMI
/*
Having komutu yanlızca group by ile komutu ile kullanılır.
Eğer gruplamadan sonra bir şart varsa having komutu kullanılır.
Where kullanımı ile aynı mantıkla çalışır
*/
--Her sirketin min maaslarini eger 4000'den büyükse yazdırınız
select min(maas) from personel--personel tablosundaki minumum maası bu şekilde buluruz

select sirket, min(maas) as en_az_maas from personel 
group by sirket --group by ile sirketlere göre sıraladık
having min(maas)>4000;--having ile 4000'den büyük olma şartını yerine getirdik 

--Aynı isimdeki kisilerin aldığı toplam gelir 10000 liradan fazla ise ismi ve toplam maasi göstereniz

select isim, sum(maas) as toplam_maas from personel group by isim having sum(maas)>10000;

-- Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz

select sehir, count(isim) as toplam_personel from personel group by sehir having count(isim)>1;

-- 4) Eger bir sehirde alinan MAX maas 5000’den dusukse
-- sehir ismini ve MAX maasi veren sorgu yaziniz

select sehir, max(maas) as maximum_maas from personel group by sehir having max(maas)<5000;


--UNION kullanımı--
--iki farklı sorgulamanın sonucunu birleştiren islemlerdir
--iki ayrı işlemi herhangi bi değişiklik yapmadan tek bi tabloda birleştirme işleminde union kullanılır.

-- 1) Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan
-- sehirleri gosteren sorguyu yaziniz

select sehir as isci_veya_sehir_ismi, maas from personel where maas>5000
union
select isim as isci_veya_sehir_ismi, maas from personel where maas>4000;

-- 2) Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
-- bir tabloda gosteren sorgu yaziniz

select isim, maas from personel where isim='Mehmet Ozturk'
union
select sehir, maas from personel where sehir='Istanbul'
order by maas;--order by maasları küçükten büyüğe sıralıyor
--order by maas desc-- yazarsak da büyükten küçüğe sıralıyor


--UNION iki ayrı tabloda işlem yapma--
drop table if exists personel
CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id));

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel(id)
);

INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

select * from personel;
select * from personel_bilgi;

-- id’si 123456789 olan personelin    Personel tablosundan sehir ve maasini, 
-- personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin

select sehir as sehir_ve_tel, maas from personel where id=123456789
union
select tel, cocuk_sayisi from personel_bilgi where id=123456789;

--UNION ALL--

/*
UNION islemi 2 veya daha cok SELECT isleminin sonuc KUMELERINI birlestirmek icin kullanilir,
Ayni kayit birden fazla olursa, sadece bir tanesini alir.
UNION ALL ise tekrarli elemanlari, tekrar sayisinca yazar.
*/

--Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz

select isim, maas from personel where maas<5000 
union all--normalde sadece union kullansak aynı ismi tek yazacaktı ancak union all ile yapınca her islemi tek tek yapıyor.
select isim, maas from personel where maas<5000;

select sehir, maas from personel where maas>4000
union all
select isim, maas from personel where maas<5000;


--INTERSECT kullanımı--
--intersect == kesişim kümesi

-- Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
--Iki sorguyu INTERSECT ile birlestirin

select id from personel where sehir in ('Istanbul','Ankara')
intersect--intersect komutu ile iki ayrı verideki id'lerin aynı olduğu yani kesişimlerini birlikte yazdırdık.
select id from personel_bilgi where cocuk_sayisi in (2,3);

-- 1) Maasi 4800’den az olanlar veya 5000’den cok olanlarin id’lerini listeleyin
-- 2) Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
-- 3) Iki sorguyu INTERSECT ile birlestirin

select id from personel where maas not between 4800 and 5500
intersect
select id from personel_bilgi where cocuk_sayisi in (2,3);

-- Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin

select isim from personel where sirket='Honda'
intersect
select isim from personel where sirket='Ford'
intersect
select isim from personel where sirket='Tofas';

--EXCEPT(minus) kullanımı--

/*
iki sorgulamada harici bir sorgulama istenirse except komutu kullanılır.
kümelerdeki a/b gibi
*/

--5000'den az maas alıp hondada çalışmayanları yazdırın

select isim,sirket from personel where maas<5000
except
select isim,sirket from personel where sirket='Honda';
