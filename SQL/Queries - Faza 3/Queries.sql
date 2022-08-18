/*
1. Të krijoni min. 8 query të thjeshta (4 për student), të realizohen vetëm me një relacion
(tabelë)
*/

--Artan Salihaj
--Sekelto te gjithe klientet premium qe perfitojn zbritje me shume se 9% ne rend zbrites
SELECT * 
FROM Klienti_premium
WHERE Zbritja > 9
ORDER BY Zbritja DESC;

--Selekto te gjithe punetoret(pa perfshire menaxheret)
SELECT *
FROM Punetori
WHERE MenaxheriID IS NOT NULL;

--Selekto klientet me shume totale te pagesave e cila eshte mes 1000 dhe 1500
SELECT KlientiID, SUM(Shuma) AS Totali
FROM Pagesa
GROUP BY KlientiID
HAVING SUM(Shuma) BETWEEN 1000 AND 1500;

--Selekto makinat qe kan vitin e prodhimit mbi 2012, çmimin e qirase mbi 100 dhe te jene te kategorise Sedan ose Hatchback
SELECT *
FROM Vetura
WHERE Viti_prodhimit > 2012
AND Cmimi_qirase > 100
AND Kategoria IN ('Sedan', 'Hatchback');

--Edison Aliu
--Selekto te gjithe klientet e gjinise mashkullore
SELECT Emri, Mbiemri, Email 
FROM Klienti
WHERE Gjinia = 'M';

--Selekto shumen totale te pagesave nga klienti me ID = 1
SELECT KlientiID, SUM(Shuma) AS Totali
FROM Pagesa
WHERE KlientiID = 1
GROUP BY KlientiID;

--Selekto lokalet qe kan ID e telefonit 1, 12, 15 ose 17
SELECT * 
FROM Lokali
WHERE NrTelefoniID IN (1, 12, 15, 17);

--Selekto te gjithe punetoret qe punojne ne lokalet me ID 19, 22, 25 dhe kan orarin e punes nga ora 08:00
SELECT *
FROM LokaliPunetori
WHERE LokaliID IN (19, 22, 25)
AND Orari LIKE '08:00%';

/*
2. Të krijoni min. 8 query të thjeshta (4 për student), të realizohen në minimum dy relacione
(tabela) e më tepër. 
*/
--Artan Salihaj
--Selekto veturat me sigurim te pjesshem
SELECT Prodhuesi, Modeli, Viti_prodhimit, Ngjyra, Kategoria, Lloji
FROM Vetura
JOIN Sigurimi ON Sigurimi.VeturaID = Vetura.VeturaID
WHERE Lloji = 'Pjesshem';

--Merr email adresat e punetoreve qe punojne ne lokalin me ID = 25
SELECT Emri, Mbiemri, Email
FROM Punetori
JOIN LokaliPunetori ON LokaliPunetori.PunetoriID = Punetori.PunetoriID
WHERE LokaliPunetori.LokaliID = 25;

--Selekto klientet te cilet jetojne ne rrugen 21 Dhjetori
SELECT Emri, Mbiemri, Datelindja, Email, Rruga
FROM Klienti
JOIN Adresa ON Adresa.AdresaID = Klienti.AdresaID
WHERE Rruga LIKE '21 Dhjetori%';

--Shfaq shumen totale te pagesave te bere nga dy gjinite
SELECT Gjinia, SUM(Shuma) AS Totali
FROM Klienti
JOIN Pagesa ON Pagesa.KlientiID = Klienti.KlientiID
GROUP BY Gjinia;

--Edison Aliu
--Selekto te gjitha pagesat e kryera nga punetori me ID = 9;
SELECT KlientiID, Pagesa.LokaliPunetoriID, PunetoriID, Shuma
FROM Pagesa
INNER JOIN LokaliPunetori ON LokaliPunetori.LokaliPunetoriID = Pagesa.LokaliPunetoriID
WHERE PunetoriID = 9;

--Selekto punetorin qe ka kryer me se shumti pagesa
SELECT PunetoriID, SUM(Shuma) AS Totali
FROM Pagesa
INNER JOIN LokaliPunetori ON LokaliPunetori.LokaliPunetoriID = Pagesa.LokaliPunetoriID
GROUP BY PunetoriID;

--Selekto te gjitha veturat e leshuara me qira, te cilat jane leshuar ne muajin shkurt(2)
SELECT Vetura.VeturaID, Prodhuesi, Modeli, Ngjyra, Cmimi_qirase, Kategoria, Data_fillimit
FROM Vetura
INNER JOIN VeturaKontrata ON VeturaKontrata.VeturaID = Vetura.VeturaID
INNER JOIN Kontrata ON Kontrata.KontrataID = VeturaKontrata.KontrataID
WHERE MONTH(Data_fillimit) = 2;

--Selekto te gjithe numrat e telefonit te klienteve
SELECT Emri, Mbiemri, Numri_telefonitID
FROM Klienti
JOIN Numri_telefonit ON Numri_telefonit.PerdoruesiID = Klienti.KlientiID;

/*
3. Të krijoni min. 8 query të avancuara (4 për student), të realizuara në minimum dy relacione
(tabela) e më tepër. 
*/
--Artan Salihaj
--Shfaq shumen totale te pagesave te kryera nga punetoret ne lokalin me ID = 20
SELECT Punetori.Emri + ' ' + Punetori.Mbiemri AS Punetori, Lokali.LokaliID, SUM(Shuma) AS Totali
FROM Punetori
JOIN LokaliPunetori ON LokaliPunetori.PunetoriID = Punetori.PunetoriID
JOIN Lokali ON Lokali.LokaliID = LokaliPunetori.LokaliID
JOIN Kontrata ON Kontrata.LokaliID = Lokali.LokaliID
JOIN Pagesa ON Pagesa.KontrataID = Kontrata.KontrataID
WHERE Lokali.LokaliID = 20
GROUP BY Punetori.Emri, Punetori.Mbiemri, Lokali.LokaliID;

--Shfaq veturat me fitimprurese
SELECT Prodhuesi + ' ' + Modeli AS Vetura, SUM(Shuma) AS Totali
FROM Vetura
JOIN VeturaKontrata ON VeturaKontrata.VeturaID = Vetura.VeturaID
JOIN Kontrata ON Kontrata.KontrataID = VeturaKontrata.KontrataID
JOIN Pagesa ON Pagesa.KontrataID = Kontrata.KontrataID
GROUP BY Vetura.VeturaID, Prodhuesi, Modeli
ORDER BY SUM(Shuma) DESC;

--Selekto te gjithe veturat e marra nga klientet premium
SELECT Emri, Mbiemri, Prodhuesi + ' ' + Modeli AS Vetura
FROM Klienti
INNER JOIN Klienti_premium ON Klienti_premium.KlientiID = Klienti.KlientiID
JOIN Pagesa ON Pagesa.KlientiID = Klienti.KlientiID
JOIN Kontrata ON Kontrata.KontrataID = Pagesa.KontrataID
JOIN VeturaKontrata ON VeturaKontrata.KontrataID= Kontrata.KontrataID
JOIN Vetura ON Vetura.VeturaID = VeturaKontrata.VeturaID
GROUP BY Emri, Mbiemri, Prodhuesi, Modeli;

--Shfaq shumen e shpenzuar nga klientet e thjeshte
WITH Shuma_Klienti_thjeshte AS
(
SELECT Klienti.KlientiID, SUM(Shuma) AS Totali
FROM Klienti
INNER JOIN Klienti_thjesht ON Klienti_thjesht.KlientiID = Klienti.KlientiID
INNER JOIN Pagesa ON Pagesa.KlientiID = Klienti.KlientiID
GROUP BY Klienti.KlientiID
)
SELECT Emri, Mbiemri, Totali
FROM Klienti
JOIN Shuma_Klienti_thjeshte ON Shuma_Klienti_thjeshte.KlientiID = Klienti.KlientiID
ORDER BY Totali DESC;

--Edison Aliu
--Shfaq klientet qe kane rezervuar nje makine dhe jane nga Shqiperia
SELECT Klienti.Emri, Klienti.Mbiemri, Qyteti.Emri, Shteti.Emri
FROM Klienti
JOIN Adresa ON Adresa.AdresaID = Klienti.AdresaID
JOIN Qyteti ON Qyteti.QytetiID = Adresa.QytetiID
JOIN Shteti ON Shteti.ShtetiID = Qyteti.ShtetiID
WHERE Shteti.ShtetiID = 2;

--Shfaq makinat e marra me qira gjate muajit janar te cilat jan te kategorise SUV, klientin dhe shumen e paguar
SELECT Prodhuesi + ' ' + Modeli AS Vetura, Cmimi_qirase, Kategoria, Klienti.Emri + ' ' + Klienti.Mbiemri AS Klienti, SUM(Shuma) AS Pagesa
FROM Vetura
JOIN VeturaKontrata ON VeturaKontrata.VeturaID = Vetura.VeturaID
JOIN Kontrata ON Kontrata.KontrataID = VeturaKontrata.KontrataID
JOIN Pagesa ON Pagesa.KontrataID = Kontrata.KontrataID
JOIN Klienti ON Klienti.KlientiID = Pagesa.KlientiID
WHERE Kategoria = 'SUV'
AND MONTH(Data_fillimit) = 1
GROUP BY  Prodhuesi, Modeli, Cmimi_qirase, Kategoria, Klienti.Emri, Klienti.Mbiemri;

--Shfaq numrat e telefonit te 4 klienteve me më se shumti para te shpenzuara
WITH TopKlientet
AS
(
SELECT KlientiID, SUM(Shuma) AS Totali
FROM Pagesa
GROUP BY KlientiID
)
SELECT TOP 4 Emri, Mbiemri, Numri_Telefonit.Numri_telefonitID, Totali
FROM Klienti
JOIN TopKlientet ON TopKlientet.KlientiID = Klienti.KlientiID
JOIN Numri_telefonit ON Numri_telefonit.PerdoruesiID = Klienti.KlientiID
ORDER BY Totali DESC;

--Shfaq punetorin e muajit per muajin shkurt(punetori qe ka gjeneruar me se shumti te ardhura)
SELECT TOP 1 Emri, Mbiemri, Email, SUM(Shuma) AS Totali
FROM Punetori
JOIN LokaliPunetori ON LokaliPunetori.PunetoriID = Punetori.PunetoriID
JOIN Pagesa ON Pagesa.LokaliPunetoriID = LokaliPunetori.LokaliPunetoriID
GROUP BY Emri, Mbiemri, Email
ORDER BY SUM(Shuma) DESC;

/*
4. Të krijoni min. 8 subquery të thjeshta (4 për student).
*/
--Artan Salihaj
--Shfaq te gjithe punetoret qe kane pranuar pagesa per veturen me ID = 3 (Mercedes C300 2017)
SELECT PunetoriID, Emri, Mbiemri
FROM Punetori
WHERE PunetoriID IN (SELECT DISTINCT LokaliPunetori.PunetoriID
					 FROM Pagesa
					 JOIN Kontrata ON Kontrata.KontrataID = Pagesa.KontrataID
					 JOIN VeturaKontrata ON VeturaKontrata.KontrataID = Kontrata.KontrataID
					 JOIN LokaliPunetori ON LokaliPunetori.LokaliID = Kontrata.LokaliID
					 WHERE VeturaKontrata.VeturaID = 3
					 );

--Shfaq klientet e punetoreve me ID(1, 8, 10, 11)
SELECT *
FROM Klienti
WHERE KlientiID IN (SELECT Kontrata.KlientiID
					FROM Kontrata
					JOIN Pagesa ON Pagesa.KontrataID = Kontrata.KontrataID
					JOIN LokaliPunetori ON LokaliPunetori.LokaliPunetoriID = Pagesa.LokaliPunetoriID
					WHERE PunetoriID IN (1, 8, 10, 11));

--Shfaq kontratat per te cilat pagesat jane me te medha se 2000 euro
SELECT *
FROM Kontrata
WHERE KontrataID IN (SELECT KontrataID
					 FROM Pagesa
					 GROUP BY KontrataID
					 HAVING SUM(Shuma) > 2000);

--Shfaq lokalin me me se shumti klient
SELECT LokaliID, Emri
FROM Lokali
WHERE LokaliID IN (SELECT TOP 1 LokaliID
				   FROM LokaliKlienti
				   GROUP BY LokaliID
				   ORDER BY COUNT(*) DESC);

--Edison Aliu
--Shfaq punetoret me orare nga ora 20:00 qe kane rrogen me te ulet se
SELECT *
FROM Punetori
WHERE PunetoriID IN (SELECT PunetoriID
					 FROM LokaliPunetori
					 WHERE Orari LIKE '20:00%')
AND Rroga < 300;

--Shfaq klientet e lokaleve me ID(17, 21, 23, 24)
SELECT KlientiID, Emri, Mbiemri, Gjinia
FROM Klienti
WHERE KlientiID IN (SELECT KlientiID
					FROM LokaliKlienti
					WHERE LokaliID IN (17, 21, 23, 24));

--Shfaq punetoret qe punojne no lokalet me ID(18, 22, 23, 24, 26), duke mos perfshire menagjeret
SELECT *
FROM Punetori
WHERE PunetoriID IN (SELECT PunetoriID
					 FROM LokaliPunetori
					 WHERE LokaliID IN (18, 22, 23, 24, 26))
AND MenaxheriID IS NOT NULL;

--Shfaq veturat e marra me qira nga klientet me ID(3, 7, 10)
SELECT *
FROM Vetura
WHERE VeturaID IN (SELECT VeturaID
				   FROM VeturaKontrata
				   JOIN Kontrata ON Kontrata.KontrataID = VeturaKontrata.KontrataID
				   WHERE KlientiID IN (3, 7, 10));

/*
5. Të krijoni min. 8 subquery të avancuara (4 për student). (min. 1 subquery në klauzolën
SELECT, dhe min. 1 subquery ne klauzolën FROM)
*/
--Artan Salihaj
--Shfaq shumen e shpenzuar nga klientet premium
SELECT Klienti_premium.KlientiID, Mbiemri, (SELECT SUM(Shuma)
							  FROM Pagesa
							  WHERE Klienti.KlientiID = Pagesa.KlientiID
							  GROUP BY Pagesa.KlientiID) AS Totali
FROM Klienti
JOIN Klienti_premium ON Klienti_premium.KlientiID = Klienti.KlientiID
ORDER BY Totali DESC;

--Shfaq numrin e veturave te marra me qira nga secili klient
SELECT Klienti.KlientiID, Emri, Mbiemri, Numri_veturave
FROM (SELECT KlientiID, COUNT(*) AS Numri_veturave
			   FROM Kontrata
			   JOIN VeturaKontrata ON VeturaKontrata.KontrataID = Kontrata.KontrataID
			   GROUP BY KlientiID) AS Veturat
JOIN Klienti ON Klienti.KlientiID = Veturat.KlientiID
ORDER BY Numri_veturave DESC;

--Shfaq veturat e leshuara me qira per te cilat kane gjeneruar se paku 2000 euro
SELECT Prodhuesi, Modeli, SUM(Shuma) AS Totali
FROM Vetura
JOIN VeturaKontrata ON VeturaKontrata.VeturaID = Vetura.VeturaID
JOIN Kontrata ON Kontrata.KontrataID = VeturaKontrata.KontrataID 
JOIN Pagesa ON Pagesa.KontrataID = Kontrata.KontrataID
WHERE Vetura.VeturaID IN (SELECT VeturaID
				   FROM VeturaKontrata
				   JOIN Kontrata ON Kontrata.KontrataID = VeturaKontrata.KontrataID
				   JOIN Pagesa ON Pagesa.KontrataID = Kontrata.KontrataID
				   GROUP BY VeturaID
				   HAVING SUM(Shuma) > 2000)
GROUP BY Vetura.VeturaID, Prodhuesi, Modeli
ORDER BY SUM(Shuma) DESC;

--Shfaq klientet qe kane shpenzuar me shume se 1500 euro ne veturat e kategorise Sedan
SELECT KlientiID, Emri + ' ' + Mbiemri AS Emri
FROM Klienti
WHERE KlientiID IN (SELECT Pagesa.KlientiID
					FROM Pagesa
					JOIN Kontrata ON Kontrata.KontrataID = Pagesa.KontrataID
					JOIN VeturaKontrata ON VeturaKontrata.KontrataID = Kontrata.KontrataID
					JOIN Vetura ON Vetura.VeturaID = VeturaKontrata.VeturaID
					WHERE Kategoria = 'Sedan'
					GROUP BY Pagesa.KlientiID
					HAVING SUM(Shuma) > 1500)

--Edison Aliu
--Shfaq te gjithe klientet qe kane pasur makinat e kategorise Sedan
SELECT KlientiID, Emri + ' ' + Mbiemri AS Emri_plote, Gjinia, Datelindja, Email
FROM Klienti
WHERE KlientiID IN (SELECT DISTINCT Pagesa.KlientiID
					FROM Pagesa
					JOIN Kontrata ON Kontrata.KontrataID = Pagesa.KontrataID
					JOIN VeturaKontrata ON VeturaKontrata.KontrataID = Kontrata.KontrataID
					JOIN Vetura ON Vetura.VeturaID = VeturaKontrata.VeturaID
					WHERE Kategoria = 'Sedan'); 

--Shfaq kontratat e bera ne secilin lokal dhe shumen totale te gjeneruar
CREATE VIEW Kontratat 
AS 
SELECT Kontrata.LokaliID, COUNT(*) AS Totali_kontratave, SUM(Shuma) AS Shuma
FROM Kontrata
JOIN Pagesa ON Pagesa.KontrataID = Kontrata.KontrataID
GROUP BY LokaliID;

SELECT Kontratat.LokaliID, Kontratat.Totali_kontratave, Kontratat.Shuma
FROM Kontratat
ORDER BY Kontratat.Shuma DESC;

--Shfaq makinat qe kane gjeneruar te ardhura mesatare me shume se 400
SELECT *
FROM Vetura
WHERE VeturaID IN (SELECT VeturaID
				   FROM VeturaKontrata
				   JOIN Kontrata ON Kontrata.KontrataID = VeturaKontrata.KontrataID
				   JOIN Pagesa ON Pagesa.KontrataID = Kontrata.KontrataID
				   GROUP BY VeturaID
				   HAVING AVG(Shuma) > 400);

--Shfaq mesataren e shpenzuar nga klientet e thjeshte
SELECT Klienti.KlientiID, (SELECT AVG(Shuma)
								  FROM Pagesa
								  WHERE Klienti.KlientiID = Pagesa.KlientiID
								  GROUP BY Pagesa.KlientiID) AS Mesatarja
FROM Klienti
JOIN Klienti_thjesht ON Klienti_thjesht.KlientiID = Klienti.KlientiID;

/*
6. Të krijoni min. 8 query/subquery (4 për student). Duke përdorur operacionet e algjebrës
relacionale (Union, Prerja, diferenca, etj.) 
*/
--Artan Salihaj
--Shfaq te dhenat e punetoreve dhe klienteve ne nje vend
SELECT 'Punetore' AS Tipi, Emri, Mbiemri, Gjinia
FROM Punetori
UNION
SELECT 'Klient', Emri, Mbiemri, Gjinia
FROM Klienti;

--Shfaq klientet e thjeshte dhe premium dhe shumen qe kane shpenzuar
CREATE VIEW Premium 
AS 
SELECT Klienti.KlientiID, Klienti_premiumID, Emri, Mbiemri, Gjinia, Datelindja, Email
FROM Klienti_premium
INNER JOIN Klienti ON Klienti.KlientiID = Klienti_premium.KlientiID;

SELECT 'Premium' AS Lloji_klientit, Emri, Mbiemri, SUM(Shuma) AS Totali_shpenzuar
FROM Premium
JOIN Pagesa ON Pagesa.KlientiID = Premium.KlientiID
GROUP BY Premium.KlientiID, Emri, Mbiemri
UNION
SELECT 'I thjeshte', Emri, Mbiemri, SUM(Shuma)
FROM Klienti_thjesht
INNER JOIN Klienti ON Klienti.KlientiID = Klienti_thjesht.KlientiID
JOIN Pagesa ON Pagesa.KlientiID = Klienti.KlientiID
GROUP BY Klienti_thjesht.KlientiID, Emri, Mbiemri
ORDER BY SUM(Shuma) DESC;

--Shfaq shumen totale te shpenzuar nga klientet e thjeshte dhe premium
SELECT 'Te thjeshte' AS Lloji_klientit, SUM(Shuma) AS Shuma_shpenzuar
FROM Klienti_thjesht
JOIN Pagesa ON Pagesa.KlientiID = Klienti_thjesht.KlientiID
UNION
SELECT 'Premium', SUM(Shuma)
FROM Klienti_premium
JOIN Pagesa ON Pagesa.KlientiID = Klienti_premium.KlientiID
ORDER BY Shuma_shpenzuar DESC;

--Shfaq te gjithe klientet perveq atyre qe jetojne ne Zvicer
SELECT Klienti.KlientiID, Klienti.Emri, Klienti.Mbiemri
FROM Klienti
EXCEPT
SELECT Klienti.KlientiID, Klienti.Emri, Klienti.Mbiemri
FROM Klienti
JOIN Adresa ON Adresa.AdresaID = Klienti.AdresaID
JOIN Qyteti ON Qyteti.QytetiID = Adresa.QytetiID
JOIN Shteti ON Shteti.ShtetiID = Qyteti.ShtetiID
WHERE Shteti.Emri = 'Zvicer';

--Shfaq vetem kategorite e veturave qe kane gjeneruar te ardhura me shume se 10,000 euro
SELECT Kategoria
FROM Vetura
INTERSECT
SELECT Kategoria
FROM Vetura
JOIN VeturaKontrata ON VeturaKontrata.VeturaID = Vetura.VeturaID
JOIN Kontrata ON Kontrata.KontrataID = VeturaKontrata.KontrataID
JOIN Pagesa ON Pagesa.KontrataID = Kontrata.KontrataID
GROUP BY Kategoria
HAVING SUM(Shuma) > 10000;

--Edison Aliu
--Shfaq punetoret dhe menaxheret ne baze te titullit
SELECT 'Punetor' AS Stafi, Emri, Mbiemri, Gjinia, Datelindja
FROM Punetori
WHERE MenaxheriID IS NOT NULL
UNION
SELECT 'Menaxher', Emri, Mbiemri, Gjinia, Datelindja
FROM Punetori
WHERE MenaxheriID IS NULL;

--Shfaq klientet dhe qfare klient jane ata(premium/te thjeshte)
SELECT 'Premium' AS Lloji_klientit, Emri, Mbiemri, Gjinia
FROM Klienti
JOIN Klienti_premium ON Klienti_premium.KlientiID = Klienti.KlientiID
UNION
SELECT 'I thjeshte', Emri, Mbiemri, Gjinia
FROM Klienti
JOIN Klienti_thjesht ON Klienti_thjesht.KlientiID = Klienti.KlientiID

--Shfaq klientet premium qe jetojne ne Hollande
SELECT KlientiID, Emri, Mbiemri, 'Hollande' AS Shteti
FROM Klienti
INTERSECT
SELECT Klienti_premium.KlientiID, Klienti.Emri, Mbiemri, Shteti.Emri
FROM Klienti_premium
JOIN Klienti ON Klienti.KlientiID = Klienti_premium.KlientiID
JOIN Adresa ON Adresa.AdresaID = Klienti.AdresaID
JOIN Qyteti ON Qyteti.QytetiID = Adresa.QytetiID
JOIN Shteti ON Shteti.ShtetiID = Qyteti.ShtetiID
WHERE Shteti.ShtetiID = 8;

--Shfaq te gjithe veturat perveq atyre qe jane leshuar me qira me pak se 3 here
SELECT Vetura.VeturaID, Vetura.Prodhuesi, Vetura.Modeli, Vetura.Kategoria, Vetura.Cmimi_qirase
FROM Vetura
EXCEPT
SELECT Vetura.VeturaID, Vetura.Prodhuesi, Vetura.Modeli, Vetura.Kategoria, Vetura.Cmimi_qirase
FROM VeturaKontrata
JOIN Vetura ON Vetura.VeturaID = VeturaKontrata.VeturaID
GROUP BY Vetura.VeturaID, Vetura.Prodhuesi, Vetura.Modeli, Vetura.Kategoria, Vetura.Cmimi_qirase
HAVING COUNT(*) < 3;

/*
Të krijoni min. 8 Proceduara të ruajtura (Stored Procedure) 
*/
--Artan Salihaj
--Shfaq shumen e gjeneruar ne baze te lokalit
CREATE PROCEDURE spLokaliShuma
	(
	@id INT,
	@emri VARCHAR(50) OUT,
	@shuma INT OUT
	)
AS
	BEGIN
		SELECT @emri = Emri, @shuma = SUM(Shuma)
		FROM Lokali
		JOIN Kontrata ON Kontrata.LokaliID= Lokali.LokaliID
		JOIN Pagesa ON Pagesa.KontrataID = Kontrata.KontrataID
		WHERE Lokali.LokaliID = @id
		GROUP BY Lokali.LokaliID, Emri
	END

DECLARE @emriL VARCHAR(50), @shumaL INT
EXEC spLokaliShuma 22, @emriL OUT, @shumaL OUT
PRINT 'Lokali "' + @emriL +'" ne total ka te ardhura €' + CONVERT(VARCHAR, @shumaL);

--Shfaq shumen e gjeneruar nga nje punetor i caktuar
CREATE PROCEDURE spPunetoriShuma
	(
	@id INT,
	@emri VARCHAR(50) OUT,
	@mbiemri VARCHAR(50) OUT,
	@gjinia VARCHAR(50) OUT,
	@shuma INT OUT
	)
AS
	BEGIN
		SELECT @emri = Emri, @mbiemri = Mbiemri, @gjinia = Gjinia, @shuma = SUM(Shuma)
		FROM Punetori
		JOIN LokaliPunetori ON LokaliPunetori.PunetoriID = Punetori.PunetoriID
		JOIN Pagesa ON Pagesa.LokaliPunetoriID = LokaliPunetori.LokaliPunetoriID
		WHERE Punetori.PunetoriID = @id
		GROUP BY Punetori.PunetoriID, Emri, Mbiemri, Gjinia
	END

DECLARE @emriP VARCHAR(50), @mbiemriP VARCHAR(50), @gjiniaP VARCHAR(1), @shumaP INT
EXEC spPunetoriShuma 14, @emriP OUT, @mbiemriP OUT, @gjiniaP OUT, @shumaP OUT
PRINT 'Punetori ' + @emriP + ' ' + @mbiemriP + '('+ @gjiniaP +') ka kryer pagesa ne total prej €' + CONVERT(VARCHAR, @shumaP);

--Shfaq numrin e punetoreve ne baze te gjinise
CREATE PROCEDURE spPunetoriGjinia
	(
	@gjinia VARCHAR(1),
	@totali INT = NULL
	)
AS
	IF(@gjinia = 'M' OR @gjinia = 'm')
		BEGIN
			SET @totali = (SELECT COUNT(*)
						   FROM Punetori
						   WHERE Gjinia = 'M'
						   GROUP BY Gjinia)
			PRINT 'Jane gjithesej ' + CONVERT(VARCHAR, @totali) + ' puntore meshkuj' 
		END
	ELSE IF(@gjinia = 'F' OR @gjinia = 'f')
		BEGIN
			SET @totali = (SELECT COUNT(*)
						   FROM Punetori
						   WHERE Gjinia = 'M'
						   GROUP BY Gjinia)
			PRINT 'Jane gjithesej ' + CONVERT(VARCHAR, @totali) + ' puntore femra' 
		END
	ELSE
		BEGIN
			PRINT 'Gjinia duhet te jete M(m) ose F(f)'
		END

EXEC spPunetoriGjinia 'm';

--Shfaq veturat dhe rangun e qmimit te tyre(<=100 - i ulet, <=150 - mesatar, <150 - i larte)
CREATE PROCEDURE spRanguCmimeve
AS
	BEGIN
		SELECT Prodhuesi, Modeli,
			CASE 
				WHEN Cmimi_qirase <= 100 THEN 'I ulet'
				WHEN CMIMI_qirase <= 150 THEN 'Mesatar'
				ELSE 'I larte'
			END AS Rangu_cmimit
		FROM Vetura
		ORDER BY Cmimi_qirase
	END

EXEC spRanguCmimeve;

--Edison Aliu
--Shfaq shumen e shpenzuar nga nje klient i caktuar
CREATE PROCEDURE spKlientiShuma
	(
	@id INT,
	@emri VARCHAR(50) OUT,
	@mbiemri VARCHAR(50) OUT,
	@shuma INT OUT
	)
AS
	BEGIN
		SELECT @emri = Emri, @mbiemri = Mbiemri, @shuma = SUM(Shuma)
		FROM Klienti
		JOIN Pagesa ON Pagesa.KlientiID = Klienti.KlientiID
		WHERE Klienti.KlientiID = @id
		GROUP BY Klienti.KlientiID, Emri, Mbiemri
	END

DECLARE @emriK VARCHAR(50), @mbiemriK VARCHAR(50), @shumaK INT
EXEC spKlientiShuma 2, @emriK OUT, @mbiemriK OUT, @shumaK OUT
PRINT 'Klienti ' + @emriK + ' ' + @mbiemriK + ' ka shpenzuar ne total nje shume prej €' + CONVERT(VARCHAR, @shumaK);

--Shfaq shumen e gjeneruar nga nje veture e caktuar
CREATE PROCEDURE spVeturaShuma
	(
	@id INT,
	@prodhuesi VARCHAR(50) OUT,
	@modeli VARCHAR(50) OUT,
	@kategoria VARCHAR(50) OUT,
	@shuma INT OUT
	)
AS
	BEGIN
		SELECT @prodhuesi = Prodhuesi, @modeli = Modeli, @kategoria = Kategoria, @shuma = SUM(Shuma)
		FROM Vetura
		JOIN VeturaKontrata ON VeturaKontrata.VeturaID = Vetura.VeturaID
		JOIN Kontrata ON Kontrata.KontrataID = VeturaKontrata.KontrataID
		JOIN Pagesa ON Pagesa.KontrataID = Kontrata.KontrataID
		WHERE Vetura.VeturaID = @id
		GROUP BY Vetura.VeturaID, Prodhuesi, Modeli, Kategoria
	END

DECLARE @prodhuesiV VARCHAR(50), @modeliV VARCHAR(50), @kategoriaV VARCHAR(50), @shumaV INT
EXEC spVeturaShuma 2, @prodhuesiV OUT, @modeliV OUT, @kategoriaV OUT, @shumaV OUT
PRINT 'Vetura ' + @prodhuesiV + ' ' + @modeliV + '(' + @kategoriaV + ') ka gjeneruar ne total nje shume prej €' + CONVERT(VARCHAR, @shumaV);

--Perditeso rrogen e nje punetorit
CREATE PROCEDURE spPunetoriRroga
	(
	@id INT,
	@rroga INT
	)
AS
	IF(@rroga >= 130)
		BEGIN
			UPDATE Punetori
			SET Rroga = @rroga
			WHERE PunetoriID = @id
			PRINT 'Rroga u perditesua me sukses'
		END
	ELSE
		BEGIN
			PRINT 'Rroga nuk mund te jete me e vogel se 130€'
		END

EXEC spPunetoriRroga 5, 400

--Shfaq punetoret ne baze te rroges(<=250 - e ulet, <= 400 - mesatare, >400 - e larte)
ALTER PROCEDURE spPunetoriStatusi
AS
	BEGIN
		SELECT Punetori.PunetoriID, Emri, Mbiemri,
			CASE
				WHEN Rroga <= 250 THEN 'E ulet'
				WHEN Rroga <= 400 THEN 'Mesatare'
				ELSE 'E larte'
			END AS Statusi
		FROM Punetori
		ORDER BY Rroga
	END

EXEC spPunetoriStatusi;