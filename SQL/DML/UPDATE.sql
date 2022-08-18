USE Car_Rental;

UPDATE Numri_telefonit
SET Numri_telefonitID = '44982462'
WHERE PerdoruesiID = 2;

UPDATE Numri_telefonit
SET Numri_telefonitID = '44654213'
WHERE PerdoruesiID = 20;

UPDATE Numri_telefonit
SET Numri_telefonitID = '44984321'
WHERE PerdoruesiID = 10;

UPDATE Vetura
SET Cmimi_qirase = 100
WHERE VeturaID = 2;

UPDATE Vetura
SET Cmimi_qirase = 60
WHERE VeturaID = 7;

UPDATE Vetura
SET Cmimi_qirase = 140
WHERE VeturaID = 10;

UPDATE LokaliPunetori
SET Orari = '16:00:00'
WHERE LokaliPunetoriID = 3;

UPDATE LokaliPunetori
SET Orari = '08:00:00'
WHERE LokaliPunetoriID = 8;

UPDATE LokaliPunetori
SET Orari = '20:00:00'
WHERE LokaliPunetoriID = 13;

UPDATE Kontrata
SET Data_mbarimit = '20210222'
WHERE KontrataID = 9;

UPDATE Kontrata
SET Data_mbarimit = '20210120'
WHERE KontrataID = 14;

UPDATE Kontrata
SET Data_fillimit = '20210126'
WHERE KontrataID = 11;

UPDATE VeturaKontrata
SET VeturaID = 3
WHERE KontrataID = 13
AND VeturaID = 1;

UPDATE VeturaKontrata
SET VeturaID = 8
WHERE KontrataID = 9
AND VeturaID = 4;

UPDATE Punetori
SET Rroga = 350
FROM
Punetori
JOIN LokaliPunetori ON LokaliPunetori.PunetoriID = Punetori.PunetoriID
WHERE LokaliID = 22;

UPDATE Klienti
SET Email = 'law.osc@outlook.com'
WHERE KlientiID = 1;

UPDATE Klienti
SET Email = 'h.cole19@gmail.com'
WHERE KlientiID = 12;

UPDATE Klienti
SET NrTelefoniID = 17
WHERE KlientiID = 2;

UPDATE Klienti
SET NrTelefoniID = 14
WHERE KlientiID = 3;

UPDATE Klienti
SET NrTelefoniID = 13
WHERE KlientiID = 4;
