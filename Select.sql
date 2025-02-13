Create DATABASE AndreiBaas;

Create Table lapss(
lapsID int primary key identity(1,1),
nimi varchar(10) not null,
pikkus smallint,
synniaasta smallint,
synnilinn varchar(20)
);
SELECT * FROM lapss;

INSERT INTO lapss(nimi,pikkus,synniaasta,synnilinn)
VALUES
('Kati','125','2003','Tallinn'),
('Mati','145','2015','Tartu'),
('sati','170','2017','Tallinn'),
('Tati','190','2005','Tartu'),
('Nuti','130','2013','Tallinn');
-- Сортировка
Select nimi,pikkus
From lapss
ORDER by pikkus DESC;

SELECT nimi,pikkus
From lapss
ORDER by pikkus DESC,nimi;
--lapsed, mis on sündinud peale 2005
SELECT nimi, synniaasta
FROM lapss
WHERE synniaasta >=2005
ORDER by nimi;
--DISTINCT- näitab ainult 1 kords
SELECT synniaasta
FROM lapss
WHERE synniaasta>2000;
--BETWEEN
--lapsed mis on sündinud(2000 kuni 2005)
SELECT nimi,synniaasta
FROM lapss
WHERE synniaasta >=2000 AND synniaasta <=2005

SELECT nimi,synniaasta
FROM lapss
WHERE synniaasta BETWEEN 2000 AND 2005;
--LIKE
-- näita lapsed, kelle nimi algab K
-- % kõikvõimalikud sümboolid
-- sisaldab K täht - '%K%'
SELECT nimi
FROM lapss
WHERE nimi like 'K%';

-- täpsem määratud tähtede arv _
SELECT nimi
FROM lapss
WHERE nimi like '_a__;'--- Выбирает имя где 2 буква а 

-- AND/ OR
SELECT nimi
FROM lapss
WHERE nimi like 'K%'
OR synnilinn like 'Tartu';

SELECT nimi,synnilinn
FROM lapss
WHERE nimi like 'K%'
AND synnilinn like 'Tartu';

--Agreaatfunktioonid
SUM, AVG, MIN, MAX, COUNT
SELECT COUNT(nimi) AS 'laste Arv'
FROM lapss;

--Рост детей сумарный
SELECT AVG(pikkus) AS 'keskmine pikkus'
FROM lapss;
-- Cумарный рост в Tallinn
SELECT AVG(pikkus) AS 'keskmine pikkus'
FROM lapss
WHERE synnilinn='Tallinn';

--näita keskmine pikkus linnade järgi
-- GROUP by
SELECT AVG(pikkus) AS 'keskmine pikkus', synnilinn
FROM lapss
GROUP by synnilinn

--показать количесво детей разждёный в конкретном году
SELECT synniaasta, count(*) AS lasteARV
FROM lapss
GROUP by synniaasta;

--HAVING --piirang juba grupeeritud andmete 
-- keskmine pikkusiga synniaasta järgi
SELECT synniaasta, AVG(pikkus) AS lasteARV
FROM lapss
GROUP by synniaasta
HAVING AVG(pikkus)>150;

SELECT synniaasta, AVG(pikkus) AS lasteARV
FROM lapss
WHERE synniaasta=2001
GROUP by synniaasta

SELECT synniaasta, AVG(pikkus) AS lasteARV
FROM lapss
WHERE NOT synniaasta=2003
GROUP by synniaasta
-------------------------TABEL---------------------------------------------
-- seotud tabel
CREATE TABLE loom(
loomID int PRIMARY KEY identity(1,1),
loomNimi varchar(50),
lapsID int,
FOREIGN KEY (lapsID) REFERENCES lapss(lapsID)
);
INSERT INTO loom(loomNimi, lapsID)
VALUES('kass Kott',1),
('koer Bobik',1),
('koer Tuzik',2),
('kass Tuzik',3),
('kass Mura',3),
('kilpkonn', 3);

SELECT * FROM loom;
--select seotud tabelite põhjal
SELECT * FROM loom, lapss;-- ei näita õiged arvud

SELECT * FROm loom
INNER JOIN lapss
On loom.lapsID=lapss.lapsID;
-- lihtne vaade 
SELECT * FROM loom,lapss
WHERE loom.lapsID=lapss.lapsID;
----
SELECT l.loomNimi, la.nimi, la.synniaasta
FROM loom l,lapss la
WHERE l.lapsID=la.lapsID;


