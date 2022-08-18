DELETE FROM Klienti_premium
WHERE KlientiID = 4;

DELETE FROM Klienti_thjesht
WHERE KlientiID = 8;

DELETE FROM Pagesa
WHERE LokaliPunetoriID = 3;

DELETE FROM Pagesa
WHERE LokaliPunetoriID = 7;

DELETE FROM LokaliPunetori
WHERE LokaliPunetoriID = 7;

DELETE FROM VeturaKontrata
WHERE VeturaID = 1
AND KontrataID = 8;

DELETE FROM VeturaKontrata
WHERE VeturaID = 3
AND KontrataID = 8;

DELETE FROM VeturaKontrata
WHERE VeturaID = 3
AND KontrataID = 16;

DELETE FROM LokaliKlienti
WHERE KlientiID = 1
AND LokaliID = 22;

DELETE FROM LokaliKlienti
WHERE KlientiID = 13
AND LokaliID = 26;