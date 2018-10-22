USE master
GO
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'LabIsi'
)
CREATE DATABASE LabIsi
GO

USE LabIsi

IF OBJECT_ID('dbo.Istehlakci', 'U') IS NOT NULL
DROP TABLE dbo.Istehlakci
GO
CREATE TABLE dbo.Istehlakci
(
    IstehlakciId INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    ad VARCHAR(40),
    soyad VARCHAR(40),
    ata_adi VARCHAR(40),
    hesab_nomresi VARCHAR(40),
    unvan VARCHAR(100),
    telefon_nomresi VARCHAR(20),
    istehlakci_firma VARCHAR(100)
);
GO

IF OBJECT_ID('dbo.Teadrukcu', 'U') IS NOT NULL
DROP TABLE dbo.Teadrukcu
GO
CREATE TABLE dbo.Teadrukcu
(
    TeadrukcuId INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    ad VARCHAR(40),
    soyad VARCHAR(40),
    ata_adi VARCHAR(40),
    hesab_nomresi VARCHAR(40),
    unvan VARCHAR(100),
    telefon_nomresi VARCHAR(20),
    qaime_nomrei VARCHAR(50),
    Teadrukcu_firma VARCHAR(40)
);
GO

IF OBJECT_ID('dbo.Mebel', 'U') IS NOT NULL
DROP TABLE dbo.Mebel
GO
CREATE TABLE dbo.Mebel
(
    MebelId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    ad VARCHAR(40),
    markasi VARCHAR(40),
    teyinati VARCHAR(40),
    tipi VARCHAR(40),
    materiali VARCHAR(40),
    saxlama_seraiti VARCHAR(40),
    istehsal_tarixi DATE
);
GO

IF OBJECT_ID('dbo.Alis', 'U') IS NOT NULL
DROP TABLE dbo.Alis
GO
CREATE TABLE dbo.Alis
(
    AlisId INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    TeadrukcuId INT FOREIGN KEY REFERENCES Teadrukcu(TeadrukcuId),
    alis_qiymeti DECIMAL(10,2),
    alis_tarixi DATE,
    umumi_deyer DECIMAL(10,2),
    mehsulun_miqdari INT,
    odenilen_mebleq DECIMAL(10,2),
    qaliq_mebleq DECIMAL(10,2),
    qaimenin_nomresi VARCHAR(40),
);
GO

IF OBJECT_ID('dbo.Satis', 'U') IS NOT NULL
DROP TABLE dbo.Satis
GO
CREATE TABLE dbo.Satis
(
    SatisId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IstehlakciId INT FOREIGN KEY REFERENCES Istehlakci(IstehlakciId),
    satis_qiymeti DECIMAL(10,2),
    satis_tarixi DATE,
    umumi_deyer DECIMAL(10,2),
    mehsulun_miqdari INT,
    odenilen_mebleq DECIMAL(10,2),
    qaliq_mebleq DECIMAL(10,2),
    qaimenin_nomresi VARCHAR(40)
);
GO