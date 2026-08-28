-- ***************************************************************
-- * File Name:                  eigen_concept.sql               *
-- * File Creator:               <Ihr Name>                      *
-- * CreationDate:               <Datum>                         *
-- ***************************************************************
--
-- ***************************************************************
-- * Bitte verwenden Sie als Zeichenkodierung immer UTF-8
--
-- ***************************************************************
-- * Datenbanksysteme SS 2026
-- * Übung 6
--
-- ***************************************************************
-- * SQL*plus Job Control Section
--
-- <sqlplus>

set echo on
set linesize 80
set pagesize 50
spool ./eigen_concept.log

-- Entkommentieren Sie die folgende Zeile, falls Sie möchten,
-- dass der SQL-Developer beim ersten Fehler abbricht:
--
-- whenever sqlerror exit sql.sqlcode

-- Systemdatum Start (bitte nicht aendern)
--

SELECT user,
        TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss')
FROM   dual
;

-- </sqlplus>

-- ***************************************************************
-- * Clear Database Section
--
-- <clear>
DROP TABLE ols_tab_bestellpositionen CASCADE CONSTRAINTS;
DROP TABLE ols_tab_enthaelt_versioniert CASCADE CONSTRAINTS;
DROP TABLE ols_tab_zahlungen CASCADE CONSTRAINTS;
DROP TABLE ols_tab_bestellungen CASCADE CONSTRAINTS;
DROP TABLE ols_tab_kunden CASCADE CONSTRAINTS;
DROP TABLE ols_tab_produkte CASCADE CONSTRAINTS;
DROP TABLE ols_tab_kategorien CASCADE CONSTRAINTS;
-- </clear>

-- ***************************************************************
-- * Table Section
--
-- <table>
CREATE TABLE ols_tab_kategorien (
    KategorieID NUMERIC(5),
    Kategorie_name VARCHAR(32)
);

CREATE TABLE ols_tab_produkte (
    ProduktID NUMERIC(5),
    Preis NUMERIC(8,2),
    KategorieID NUMERIC(5),
    Produkt_name VARCHAR(32)
);

CREATE TABLE ols_tab_bestellungen (
    Datum DATE,
    Bestell_nr NUMERIC(4),
    Kunde VARCHAR(32),
    PersonID NUMERIC(5)
);

CREATE TABLE ols_tab_kunden (
    PersonID NUMERIC(5),
    Kundennummer NUMERIC(5)
);

CREATE TABLE ols_tab_zahlungen (
    Betrag NUMERIC(8,2),
    ZahlungID NUMERIC(9),
    Bestell_nr NUMERIC(4)
);

CREATE TABLE ols_tab_enthaelt_versioniert (
    ProduktID NUMERIC(5),
    Bestell_nr NUMERIC(4),
    Datum DATE
);

CREATE TABLE ols_tab_bestellpositionen (
    Menge NUMERIC(4),
    Positionsdatum DATE,
    Bestell_nr NUMERIC(4),
    ProduktID NUMERIC(5),
    Produkt VARCHAR(32),
    Rabatt NUMERIC(3,1)
);
-- </table>

-- ***************************************************************
-- * NOT NULL Constraint Section
--
-- <notnull>
ALTER TABLE ols_tab_kategorien
ADD CONSTRAINT ols_nn_kategorien_name
CHECK (Kategorie_name IS NOT NULL);

ALTER TABLE ols_tab_produkte
ADD CONSTRAINT ols_nn_produkte_preis
CHECK (Preis IS NOT NULL);

ALTER TABLE ols_tab_produkte 
ADD CONSTRAINT ols_nn_produkte_kategorieid
CHECK(KategorieID IS NOT NULL);

ALTER TABLE ols_tab_produkte
ADD CONSTRAINT ols_nn_produkte_name
CHECK (Produkt_name IS NOT NULL);

ALTER TABLE ols_tab_bestellungen
ADD CONSTRAINT ols_nn_bestellungen_datum
CHECK (Datum IS NOT NULL);

ALTER TABLE ols_tab_bestellungen
ADD CONSTRAINT ols_nn_bestellungen_kunde
CHECK (Kunde IS NOT NULL);

ALTER TABLE ols_tab_bestellungen
ADD CONSTRAINT ols_nn_bestellungen_personid
CHECK (PersonID IS NOT NULL);

ALTER TABLE ols_tab_kunden
ADD CONSTRAINT ols_nn_kunden_kundennummer
CHECK (Kundennummer IS NOT NULL);

ALTER TABLE ols_tab_zahlungen
ADD CONSTRAINT ols_nn_zahlungen_betrag
CHECK (Betrag IS NOT NULL);

ALTER TABLE ols_tab_zahlungen
ADD CONSTRAINT ols_nn_zahlungen_bestellnr
CHECK (Bestell_nr IS NOT NULL);

ALTER TABLE ols_tab_enthaelt_versioniert
ADD CONSTRAINT ols_nn_enthaelt_datum
CHECK (Datum IS NOT NULL);

ALTER TABLE ols_tab_bestellpositionen
ADD CONSTRAINT ols_nn_bestellpositionen_menge
CHECK (Menge IS NOT NULL);

ALTER TABLE ols_tab_bestellpositionen
ADD CONSTRAINT nn_produkt
CHECK (Produkt IS NOT NULL);

ALTER TABLE ols_tab_bestellpositionen
ADD CONSTRAINT nn_positionsdatum3
CHECK (Positionsdatum IS NOT NULL);

ALTER TABLE ols_tab_bestellpositionen
ADD CONSTRAINT nn_rabatt3
CHECK (Rabatt IS NOT NULL);

-- </notnull>

-- ***************************************************************
-- * Primary Key Constraint Section
--
-- <pk>
ALTER TABLE ols_tab_kategorien
ADD CONSTRAINT ols_pk_kategorien
PRIMARY KEY (KategorieID);

ALTER TABLE ols_tab_produkte
ADD CONSTRAINT ols_pk_produkte
PRIMARY KEY (ProduktID);

ALTER TABLE ols_tab_bestellungen
ADD CONSTRAINT ols_pk_bestellungen
PRIMARY KEY (Bestell_nr);

ALTER TABLE ols_tab_kunden
ADD CONSTRAINT ols_pk_kunden
PRIMARY KEY (PersonID);

ALTER TABLE ols_tab_zahlungen
ADD CONSTRAINT ols_pk_zahlungen
PRIMARY KEY (ZahlungID);

ALTER TABLE ols_tab_enthaelt_versioniert
ADD CONSTRAINT ols_pk_enthaelt
PRIMARY KEY (ProduktID, Bestell_nr);

ALTER TABLE ols_tab_bestellpositionen
ADD CONSTRAINT ols_pk_bestellpositionen
PRIMARY KEY (Bestell_nr, ProduktID);
-- </pk>

-- ***************************************************************
-- * Unique Key Constraint Section
--
-- <unique>
ALTER TABLE ols_tab_kunden
ADD CONSTRAINT ols_uk_kunden_kundennummer
UNIQUE (Kundennummer);
-- </unique>

-- ***************************************************************
-- * Foreign Key Constraint Section
--
-- <fk>
ALTER TABLE ols_tab_produkte
ADD CONSTRAINT ols_fk_produkte_kategorien
FOREIGN KEY (KategorieID)
REFERENCES ols_tab_kategorien;

ALTER TABLE ols_tab_bestellungen
ADD CONSTRAINT ols_fk_bestellungen_kunden
FOREIGN KEY (PersonID)
REFERENCES ols_tab_kunden;

ALTER TABLE ols_tab_zahlungen
ADD CONSTRAINT ols_fk_zahlungen_bestellungen
FOREIGN KEY (Bestell_nr)
REFERENCES ols_tab_bestellungen;

ALTER TABLE ols_tab_enthaelt_versioniert
ADD CONSTRAINT ols_fk_enthaelt_produkte
FOREIGN KEY (ProduktID)
REFERENCES ols_tab_produkte;

ALTER TABLE ols_tab_enthaelt_versioniert
ADD CONSTRAINT ols_fk_enthaelt_bestellungen
FOREIGN KEY (Bestell_nr)
REFERENCES ols_tab_bestellungen;

ALTER TABLE ols_tab_bestellpositionen
ADD CONSTRAINT fk_bestellungen
FOREIGN KEY (Bestell_nr)
REFERENCES ols_tab_bestellungen;

ALTER TABLE ols_tab_bestellpositionen
ADD CONSTRAINT fk_produkte
FOREIGN KEY (ProduktID)
REFERENCES ols_tab_produkte;
-- </fk>

-- ***************************************************************
-- * SQL*plus Job Control Section
--
-- <sqlplus>

-- Systemdatum Ende (bitte nicht aendern)
--

SELECT user,
        TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss')
FROM   dual
;

spool off

-- </sqlplus>
