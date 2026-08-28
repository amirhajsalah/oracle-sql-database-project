-- ***************************************************************
-- * File Name:                  eigen_query.sql                 *
-- * File Creator:               <Ihr Name>                      *
-- * CreationDate:               <Datum>                         *
-- ***************************************************************
--
-- ***************************************************************
-- * Bitte verwenden Sie als Zeichenkodierung immer UTF-8
--
-- ***************************************************************
-- * Datenbanksysteme SS 2026
-- * Klausurzulassung Teil III
-- * Datenbankanfragen auf der eigenen Datenbank
--
-- ***************************************************************
-- * SQL*plus Job Control Section
--
-- <sqlplus>

set echo on
set define off;
set linesize 80
set pagesize 50

--
-- Protokolldatei
--

spool ./eigen_query.log

-- Kommentieren Sie den folgenden Befehl ein, wenn Sie möchten, dass der SQL-
-- Developer beim ersten Fehler abbricht.
--
whenever sqlerror exit sql.sqlcode
--
-- </sqlplus>
--
-- ***************************************************************
--
-- 4.1	Auswahl Ihrer Übungstabellen
--
-- Geben Sie die Struktur Ihrer vier ausgewählten Tabellen mit dem „DESCRIBE“-
-- Befehl aus.
--
-- <auswahl>

DESCRIBE OLS_TAB_KUNDEN;
DESCRIBE OLS_TAB_BESTELLUNGEN;
DESCRIBE OLS_TAB_PRODUKTE;
DESCRIBE OLS_TAB_ENTHAELT_VERSIONIERT;


-- </auswahl>

-- Hinweis: Fremdschlüssel-Constraints, die aus der Kette der vier ausgewählten
-- Tabellen herauszeigen, sollten Sie für den Datenimport im folgenden
-- Abschnitt deaktivieren, um keine Datensätze in weitere Tabellen einfügen zu
-- müssen.
--
-- <disable_fk>
ALTER TABLE OLS_TAB_ENTHAELT_VERSIONIERT
DISABLE CONSTRAINT OLS_FK_ENTHAELT_BESTELLUNGEN;

ALTER TABLE OLS_TAB_ENTHAELT_VERSIONIERT
DISABLE CONSTRAINT OLS_FK_ENTHAELT_PRODUKTE;

ALTER TABLE OLS_TAB_PRODUKTE
DISABLE CONSTRAINT OLS_FK_PRODUKTE_KATEGORIEN;

ALTER TABLE OLS_TAB_BESTELLUNGEN
DISABLE CONSTRAINT OLS_FK_BESTELLUNGEN_KUNDEN;

-- </disable_fk>

-- 4.2	Import von Beispieldatensätzen
--
-- Fügen Sie insgesamt mindestens 20 Datensätze in die von Ihnen ausgewählten
-- vier Tabellen ein. Um bei den Übungsanfragen den „outer join“ sinnvoll
-- anwenden zu können, muss es in der „linken“ und der „rechten“ Tabelle der
-- N:M-Beziehung Datensätze geben, die keinen „Partner“ haben, also nicht von
-- der N:M-Beziehungstabelle aus referenziert werden.
--
-- <import>

-- Wichtig: Verwenden Sie hier bitte nur die einfache INSERT-Syntax, bei der
--          die Spaltennamen nicht explizit angegeben werden, sondern die Werte
--          (ggf. NULL) für alle Spalten angegeben werden. Nur diese Form wird
--          z.Zt. vom SQL-Parser des Praktomaten unterstützt:

-- INSERT INTO <tabelle> VALUES (<Wert1>, <Wert2>, ...);
-- INSERT INTO <tabelle> VALUES (<Wert1>, <Wert2>, ...);
-- INSERT INTO <tabelle> VALUES (<Wert1>, <Wert2>, ...);

INSERT INTO OLS_TAB_KUNDEN
VALUES (1,1001);

INSERT INTO OLS_TAB_KUNDEN
VALUES (2,1002);

INSERT INTO OLS_TAB_KUNDEN
VALUES (3,1003);

INSERT INTO OLS_TAB_KUNDEN
VALUES (4,1004);

INSERT INTO OLS_TAB_KUNDEN
VALUES (5,1005);



INSERT INTO OLS_TAB_PRODUKTE
VALUES (101,19.99,1,'Laptop');

INSERT INTO OLS_TAB_PRODUKTE
VALUES (102,9.99,2,'Mouse');

INSERT INTO OLS_TAB_PRODUKTE
VALUES (103,49.99,3,'Keyboard');

INSERT INTO OLS_TAB_PRODUKTE
VALUES (104,29.99,4,'Monitor');

INSERT INTO OLS_TAB_PRODUKTE
VALUES (105,14.99,5,'Headset');

INSERT INTO OLS_TAB_PRODUKTE  
VALUES (106,49.99,6,'Tablet');


INSERT INTO OLS_TAB_BESTELLUNGEN
VALUES (TO_DATE('10.01.2025','DD.MM.YYYY'),100,'Kunde1',1);

INSERT INTO OLS_TAB_BESTELLUNGEN
VALUES (TO_DATE('11.01.2025','DD.MM.YYYY'),101,'Kunde2',2);

INSERT INTO OLS_TAB_BESTELLUNGEN
VALUES (TO_DATE('12.01.2025','DD.MM.YYYY'),102,'Kunde3',3);

INSERT INTO OLS_TAB_BESTELLUNGEN
VALUES (TO_DATE('13.01.2025','DD.MM.YYYY'),103,'Kunde4',4);

INSERT INTO OLS_TAB_BESTELLUNGEN
VALUES (TO_DATE('14.01.2025','DD.MM.YYYY'),104,'Kunde5',5);

INSERT INTO OLS_TAB_BESTELLUNGEN VALUES ( TO_DATE('15.01.2025','DD.MM.YYYY'),
105,
'Kunde6',
1
);


INSERT INTO OLS_TAB_ENTHAELT_VERSIONIERT
VALUES (101,100,TO_DATE('10.01.2025','DD.MM.YYYY'));

INSERT INTO OLS_TAB_ENTHAELT_VERSIONIERT
VALUES (102,101,TO_DATE('11.01.2025','DD.MM.YYYY'));

INSERT INTO OLS_TAB_ENTHAELT_VERSIONIERT
VALUES (103,102,TO_DATE('12.01.2025','DD.MM.YYYY'));

INSERT INTO OLS_TAB_ENTHAELT_VERSIONIERT
VALUES (104,103,TO_DATE('13.01.2025','DD.MM.YYYY'));

INSERT INTO OLS_TAB_ENTHAELT_VERSIONIERT
VALUES (105,104,TO_DATE('14.01.2025','DD.MM.YYYY')); 


-- Wichtig: Schließen Sie die Folge der INSERTs mit einem einzelnen COMMIT ab,
--          damit die Daten persistiert und von anderen Anwendungen (Praktomat)
--          gefunden werden können.
COMMIT;

-- </import>

--
-- 4.4 Anfragen auf Ihren Datensätzen
--
-- Testen Sie Ihre Datenbank, indem Sie die folgenden Anforderungen als SQL-
-- SELECT umsetzen.
--
-- 4.4 a) Jeweils Anzeige aller Datensätze Ihrer vier Tabellen
--        (vier einzelne SELECTs).
--
-- <44a>
SELECT * FROM OLS_TAB_KUNDEN;

SELECT * FROM OLS_TAB_BESTELLUNGEN;

SELECT * FROM OLS_TAB_PRODUKTE;

SELECT * FROM OLS_TAB_ENTHAELT_VERSIONIERT;

-- </44a>

--
-- 4.4 b) Ein kanonischer Verbund, der die Datensätze der vier Tabellen
--        semantisch sinnvoll verbunden ausgibt, dabei aber nur solche
--        Datensätze berücksichtigt, die in Beziehung stehen
--        („inner join“). Lassen Sie in der Ausgabe bitte die Primär-
--        und Fremdschlüsselwerte weg.
--
-- <44b>
SELECT
    K.KUNDENNUMMER,
    B.KUNDE,
    B.DATUM,
    P.PRODUKT_NAME
FROM OLS_TAB_KUNDEN K
INNER JOIN OLS_TAB_BESTELLUNGEN B
    ON K.PERSONID = B.PERSONID
INNER JOIN OLS_TAB_ENTHAELT_VERSIONIERT EV
    ON B.BESTELL_NR = EV.BESTELL_NR
INNER JOIN OLS_TAB_PRODUKTE P
    ON EV.PRODUKTID = P.PRODUKTID;
-- </44b>

--
-- 4.4 c)  Ein „vollständiger“ Verbund, der alle Datensätze der an der „N:M“-
--         Beziehung direkt beteiligten drei Tabellen semantisch sinnvoll
--         verbunden ausgibt. Geben Sie auch solche Datensätze der „linken“
--         und „rechten“ Tabelle aus, die nicht an der Beziehung teilnehmen
--         („outer join“). Lassen Sie in der Ausgabe wieder die Primär- und
--         Fremdschlüsselwerte weg.
--
-- <44c>


SELECT
    B.KUNDE,
    P.PRODUKT_NAME,
    EV.DATUM
FROM OLS_TAB_ENTHAELT_VERSIONIERT EV
FULL OUTER JOIN OLS_TAB_BESTELLUNGEN B
    ON EV.BESTELL_NR = B.BESTELL_NR
FULL OUTER JOIN OLS_TAB_PRODUKTE P
    ON EV.PRODUKTID = P.PRODUKTID;

-- </44c>

--
-- 4.4 d) Eine semantisch sinnvoll aggregierte Ausgabe, die über eine
--        „GROUP BY“- und eine „HAVING“-Klausel verfügt.
--
-- <44d>

SELECT
    P.PRODUKT_NAME,
    COUNT(*) AS ANZAHL_BESTELLUNGEN
FROM OLS_TAB_PRODUKTE P
INNER JOIN OLS_TAB_ENTHAELT_VERSIONIERT EV
    ON P.PRODUKTID = EV.PRODUKTID
GROUP BY P.PRODUKT_NAME
HAVING COUNT(*) >= 1;

-- </44d>

--
-- 4.4 e) Lassen Sie den nächsten freien Primärschlüsselwert für die „linke“
--        (oder „rechte“) an der „N:M“-Beziehung beteiligte Tabelle mit Hilfe
--        von SQL berechnen. Die nächste freie Schlüsselnummer erhält man mit
--        einem Statement der Form:
--
--        "SELECT MAX(<spalte>)+1 FROM <tabelle>".
--
-- <44e>
SELECT MAX(PRODUKTID) + 1
FROM OLS_TAB_PRODUKTE;

-- </44e>

--
-- 4.4 f) Zeigen Sie ausschließlich solche Datensätze der „linken“ (oder
--        „rechten“) „N:M“-Tabelle an, die nicht von der „N:M“-Beziehungs-
--        tabelle referenziert werden. Stellen Sie sicher das Ihr Ergebnis
--        alle Spalten dieser Tabelle (und keine weiteren) enthält.
--
-- <44f>

SELECT *
FROM OLS_TAB_PRODUKTE P
WHERE NOT EXISTS (
    SELECT 1
    FROM OLS_TAB_ENTHAELT_VERSIONIERT EV
    WHERE EV.PRODUKTID = P.PRODUKTID
);

-- </44f>

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
