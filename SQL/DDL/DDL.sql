CREATE DATABASE Car_Rental;

USE Car_Rental;

/* Ne modelin relacionar te lidhja Sigurimi-Vetura(1-1), 
	FK ndodhet te tabela Vetura, kurse ketu eshte paraqitur
	ne tabelen Sigurimi(Pasi qe lidhja eshte 1-1 nuk ka ndikim ne rezultat).*/
CREATE TABLE Vetura(
	VeturaID INT IDENTITY(1,1) PRIMARY KEY,
	Prodhuesi VARCHAR(30) NOT NULL,
	Modeli VARCHAR(25) NOT NULL,
	Viti_prodhimit INT CHECK(Viti_prodhimit <= YEAR(GETDATE())) NOT NULL,
	Ngjyra VARCHAR(15) NOT NULL,
	Cmimi_qirase INT NOT NULL CHECK(Cmimi_qirase > 0),
	Kategoria VARCHAR(15) NOT NULL,
);

CREATE TABLE Sigurimi(
	SigurimiID INT IDENTITY(1,1) PRIMARY KEY,
	VeturaID INT UNIQUE NOT NULL,
	Kompania VARCHAR(50) NOT NULL,
	Lloji VARCHAR(10) NOT NULL,

	CONSTRAINT fk_Vetura_Sigurimi FOREIGN KEY (VeturaID)
		REFERENCES Vetura(VeturaID)
);


CREATE TABLE Llogaria(
	LlogariaID INT IDENTITY(1,1) PRIMARY KEY,
	Username VARCHAR(50) UNIQUE NOT NULL,
	Password VARCHAR(50) NOT NULL
);

CREATE TABLE Shteti(
	ShtetiID INT IDENTITY(1,1) PRIMARY KEY,
	Emri VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Qyteti(
	QytetiID INT IDENTITY(1,1) PRIMARY KEY,
	ShtetiID INT NOT NULL,
	Emri VARCHAR(70) NOT NULL,

	CONSTRAINT fk_Shteti_Qyteti FOREIGN KEY (ShtetiID)
		REFERENCES Shteti(ShtetiID)
);

CREATE TABLE Adresa(
	AdresaID INT IDENTITY(1,1) PRIMARY KEY,
	QytetiID INT NOT NULL,
	Rruga VARCHAR(70) NOT NULL,
	Kodi_postar INT NOT NULL CHECK(Kodi_postar > 0),

	CONSTRAINT fk_Qyteti_Adresa FOREIGN KEY (QytetiID)
		REFERENCES Qyteti(QytetiID)
);

CREATE TABLE Punetori(
	PunetoriID INT IDENTITY(1, 1) PRIMARY KEY,
	AdresaID INT NOT NULL,
	MenaxheriID INT,
	LlogariaID INT UNIQUE NOT NULL,
	Emri VARCHAR(30) NOT NULL,
	Mbiemri VARCHAR(50) NOT NULL,
	Gjinia CHAR(1) NOT NULL CHECK(Gjinia IN ('M', 'F')),
	Datelindja DATE NOT NULL,
	Email VARCHAR(100) UNIQUE NOT NULL,
	Rroga INT NOT NULL CHECK(Rroga >= 130)

	CONSTRAINT fk_Adresa_Punetori FOREIGN KEY (AdresaID)
		REFERENCES Adresa(AdresaID),
	CONSTRAINT fk_Menaxheri_Punetori FOREIGN KEY (MenaxheriID)
		REFERENCES Punetori(PunetoriID),
	CONSTRAINT fk_Llogaria_Punetori FOREIGN KEY (LlogariaID)
		REFERENCES Llogaria(LlogariaID)
);

CREATE TABLE Numri_telefonit(
	PerdoruesiID INT IDENTITY(1,1) PRIMARY KEY,
	Numri_telefonitID INT UNIQUE NOT NULL
);

CREATE TABLE Lokali(
	LokaliID INT IDENTITY(1,1) PRIMARY KEY,
	NrTelefoniID INT NOT NULL,
	AdresaID INT UNIQUE NOT NULL,
	Emri VARCHAR(30) NOT NULL,

	CONSTRAINT fk_Adresa_Lokali FOREIGN KEY (AdresaID)
		REFERENCES Adresa(AdresaID),
	CONSTRAINT fk_NrTelefoni_Lokali FOREIGN KEY (NrTelefoniID)
		REFERENCES Numri_telefonit(PerdoruesiID)
);

CREATE TABLE Klienti(
	KlientiID INT IDENTITY(1,1) PRIMARY KEY,
	NrTelefoniID INT NOT NULL,
	AdresaID INT NOT NULL,
	Emri VARCHAR(30) NOT NULL,
	Mbiemri VARCHAR(50) NOT NULL,
	Gjinia CHAR(1) NOT NULL CHECK(Gjinia IN ('M', 'F')),
	Datelindja DATE NOT NULL,
	Email VARCHAR(50) UNIQUE,

	CONSTRAINT CK_age CHECK(
		Datelindja < DATEADD(YEAR, -18, GETDATE())
	),
	CONSTRAINT fk_Adresa_Klienti FOREIGN KEY (AdresaID)
		REFERENCES Adresa(AdresaID),
	CONSTRAINT fk_NrTelefoni_Klienti FOREIGN KEY (NrTelefoniID)
		REFERENCES Numri_telefonit(PerdoruesiID)
);

CREATE TABLE Klienti_premium(
	Klienti_premiumID INT IDENTITY(1,1) PRIMARY KEY,
	KlientiID INT UNIQUE NOT NULL,
	Zbritja INT NOT NULL CHECK(Zbritja >= 5 AND Zbritja <= 15)

	CONSTRAINT fk_Klienti_KlientiPremium FOREIGN KEY (KlientiID)
		REFERENCES Klienti(KlientiID)
);

CREATE TABLE Klienti_thjesht(
	Klienti_thjeshtID INT IDENTITY(1,1) PRIMARY KEY,
	KlientiID INT UNIQUE NOT NULL,

	CONSTRAINT fk_Klienti_KlientiThjesht FOREIGN KEY (KlientiID)
		REFERENCES Klienti(KlientiID)
);

/*Te modeli relacionare, FK(Foreign key) VeturaID 
	eshte futur gabimisht ne tabelen 'Kontrata'. 
	Tabela e krijuar me poshte nuk permban FK VeturaID siç
	eshte paraqitur ne modelin relacionare.*/
CREATE TABLE Kontrata(
	KontrataID INT IDENTITY(1,1) PRIMARY KEY,
	KlientiID INT NOT NULL,
	LokaliID INT NOT NULL,
	Data_fillimit DATE NOT NULL,
	Data_mbarimit DATE NOT NULL,

	CONSTRAINT CK_Data_mbarimit CHECK (
		Data_mbarimit >= DATEADD(DAY, 1, Data_fillimit)
	),
	CONSTRAINT fk_Lokali_Kontrata FOREIGN KEY (LokaliID)
		REFERENCES Lokali(LokaliID),
	CONSTRAINT fk_Klienti_Kontrata FOREIGN KEY (KlientiID)
		REFERENCES Klienti(KlientiID)
);

CREATE TABLE VeturaKontrata(
	VeturaID INT,
	KontrataID INT,
	PRIMARY KEY (VeturaID, KontrataID),

	CONSTRAINT fk_VeturaKontrata_VeturaID FOREIGN KEY (VeturaID)
		REFERENCES Vetura(VeturaID),
	CONSTRAINT fk_VeturaKontrata_KontrataID FOREIGN KEY (KontrataID)
		REFERENCES Kontrata(KontrataID)
);

CREATE TABLE LokaliPunetori(
	LokaliPunetoriID INT IDENTITY(1,1) PRIMARY KEY,
	LokaliID INT NOT NULL,
	PunetoriID INT NOT NULL,
	Orari TIME NOT NULL,

	CONSTRAINT fk_LokaliPunetori_Lokali FOREIGN KEY (LokaliID)
		REFERENCES Lokali(LokaliID),
	CONSTRAINT fk_LokaliPunetori_Punetori FOREIGN KEY (PunetoriID)
		REFERENCES Punetori(PunetoriID)
);

CREATE TABLE Pagesa(
	KontrataID INT NOT NULL,
	KlientiID INT NOT NULL,
	LokaliPunetoriID INT NOT NULL,
	Metoda_pageses VARCHAR(20) NOT NULL,
	Shuma INT NOT NULL CHECK(Shuma > 0),
	PRIMARY KEY (KontrataID, KlientiID, LokaliPunetoriID),

	CONSTRAINT fk_Kontrata_Pagesa FOREIGN KEY (KontrataID)
		REFERENCES Kontrata(KontrataID),
	CONSTRAINT fk_Klienti_Pagesa FOREIGN KEY (KlientiID)
		REFERENCES Klienti(KlientiID),
	CONSTRAINT fk_LokaliPunetori_Pagesa FOREIGN KEY (LokaliPunetoriID)
		REFERENCES LokaliPunetori(LokaliPunetoriID)
);

CREATE TABLE LokaliKlienti(
	KlientiID INT NOT NULL,
	LokaliID INT NOT NULL,
	PRIMARY KEY (KlientiID, LokaliID),

	CONSTRAINT fk_Klienti_LokaliKlienti FOREIGN KEY (KlientiID)
		REFERENCES Klienti(KlientiID),
	CONSTRAINT fk_Lokali_LokaliKlienti FOREIGN KEY (LokaliID)
		REFERENCES Lokali(LokaliID)
);