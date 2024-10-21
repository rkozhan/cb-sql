START TRANSACTION;

CREATE TABLE IF NOT EXISTS AIRLINE (
    AL_CODE CHAR(3) NOT NULL,
    AL_NAME VARCHAR(50) NOT NULL,
    AL_HQ VARCHAR(50) NOT NULL,
    PRIMARY KEY(AL_CODE)
);

CREATE TABLE IF NOT EXISTS ACTYPE(
    T_ID VARCHAR(30) NOT NULL,
    T_MANUFACT VARCHAR(30),
    T_RANGE INTEGER,
    PRIMARY KEY(T_ID)
);

CREATE TABLE IF NOT EXISTS AIRCRAFT(
    AC_IRN INTEGER NOT NULL,
    AC_Nr SMALLINT,
    AC_NAME VARCHAR(30),
    AC_SERVICE_DATE DATE,
    AC_TYPE VARCHAR(30) NOT NULL,
    PRIMARY KEY(AC_IRN),
    FOREIGN KEY(AC_TYPE) REFERENCES actype (T_ID));

ALTER TABLE AIRCRAFT ADD (AC_AIRLANE VARCHAR(30));
ALTER TABLE AIRCRAFT ADD FOREIGN KEY(AC_AIRLANE) REFERENCES airline (AL_CODE);
ALTER TABLE AIRCRAFT CHANGE AC_AIRLANE AC_AIRLINE VARCHAR(30);

CREATE TABLE IF NOT EXISTS ROW (
    R_Nr INTEGER NOT NULL,
    R_CLASS VARCHAR(10),
    AC_IRN INTEGER NOT NULL,  -- Foreign key referencing AIRCRAFT
    PRIMARY KEY (AC_IRN, R_Nr),  -- Composite primary key
    FOREIGN KEY (AC_IRN) REFERENCES AIRCRAFT (AC_IRN)
);

CREATE TABLE IF NOT EXISTS SEAT (
    S_Nr ENUM('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H') NOT NULL,
    R_Nr INTEGER NOT NULL,
    AC_IRN INTEGER NOT NULL,
    PRIMARY KEY (AC_IRN, R_Nr, S_Nr),
    FOREIGN KEY (AC_IRN, R_Nr) REFERENCES ROW (AC_IRN, R_Nr),
    FOREIGN KEY (AC_IRN) REFERENCES AIRCRAFT (AC_IRN)
);

CREATE TABLE IF NOT EXISTS PASSENGER (
    P_Nr INTEGER NOT NULL,
    P_FNAME VARCHAR(30) NOT NULL,
    P_LNAME VARCHAR(30) NOT NULL,
    P_GENDER ENUM('male', 'female') NOT NULL,
    P_TITLE VARCHAR(4),
    PRIMARY KEY (P_Nr)
);

CREATE TABLE IF NOT EXISTS AIRPORT (
    A_KEY CHAR(3) NOT NULL,
    A_NAME VARCHAR(50) NOT NULL,
    A_CITY VARCHAR(30) NOT NULL,
    A_COUNTRY VARCHAR(20) NOT NULL,
    A_CAPACITY INT,
    PRIMARY KEY (A_KEY)
);

CREATE TABLE IF NOT EXISTS scheduled_flight (
    AL_CODE CHAR(3) NOT NULL,
    FL_NR VARCHAR(6) NOT NULL,
    SCH_D_TIME TIME NOT NULL,
    SCH_AR_TIME TIME NOT NULL,
    DAYS TINYINT NOT NULL,
    F_FROM CHAR(3) NOT NULL,
    F_TO CHAR(3) NOT NULL,
    PRIMARY KEY (AL_CODE, FL_NR),
    FOREIGN KEY (AL_CODE) REFERENCES AIRLINE (AL_CODE),
    FOREIGN KEY (F_FROM) REFERENCES airport (A_KEY),
    FOREIGN KEY (F_TO) REFERENCES airport (A_KEY)
);

CREATE TABLE IF NOT EXISTS actual_flight (
    FL_NR VARCHAR(10) NOT NULL,
    AL_CODE CHAR(3) NOT NULL,
    ACTUAL_T_TIME TIME,
    ACTUAL_L_TIME TIME,
    F_DATE DATE,
    AC_IRN INTEGER,
    PRIMARY KEY (AL_CODE, FL_NR, F_DATE),
    FOREIGN KEY (AL_CODE, FL_NR) REFERENCES scheduled_flight (AL_CODE, FL_NR),
    FOREIGN KEY (AC_IRN) REFERENCES AIRCRAFT (AC_IRN)
);

CREATE TABLE IF NOT EXISTS AIRPORT_DISTANCE (
    A_KEY1 CHAR(3) NOT NULL,
    A_KEY2 CHAR(3) NOT NULL,
    DISTANCE FLOAT NOT NULL,
    PRIMARY KEY (A_KEY1, A_KEY2),
    FOREIGN KEY (A_KEY1) REFERENCES AIRPORT (A_KEY),
    FOREIGN KEY (A_KEY2) REFERENCES AIRPORT (A_KEY)
);

CREATE TABLE IF NOT EXISTS ticket (
    T_Nr INTEGER NOT NULL AUTO_INCREMENT,
    ISSUE_DATE DATE NOT NULL,
    PRICE DECIMAL(10, 2) NOT NULL,
    CURRENCY VARCHAR(3) NOT NULL,
    SALES_OFFICE VARCHAR(50),
    T_CLASS ENUM('first', 'business', 'economy') NOT NULL,
    P_Nr INTEGER NOT NULL,
    FL_DATE DATE NOT NULL,
    BC_Nr INTEGER DEFAULT NULL,
    AL_CODE CHAR(3) NOT NULL,
    FL_NR CHAR(3) NOT NULL,    
    PRIMARY KEY (T_Nr),
    FOREIGN KEY (P_Nr) REFERENCES passenger (P_Nr),
    FOREIGN KEY (AL_CODE, FL_NR) REFERENCES scheduled_flight (AL_CODE, FL_NR)
);

CREATE TABLE IF NOT EXISTS boarding_card (
    T_Nr INTEGER NOT NULL,
    
    AL_CODE CHAR(3) NOT NULL,
    FL_NR VARCHAR(10) NOT NULL,
    FL_DATE DATE NOT NULL,
    
    AC_IRN INTEGER NOT NULL,
    SEAT ENUM('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H') NOT NULL,
    ROW_NR INTEGER NOT NULL,
    
    PRIMARY KEY (T_Nr),
    FOREIGN KEY (T_Nr) REFERENCES ticket (T_Nr),
    FOREIGN KEY (AC_IRN, ROW_NR, SEAT) REFERENCES seat (AC_IRN, R_Nr, S_Nr)
);

COMMIT;

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////INSERT_DATA


INSERT INTO AIRLINE (AL_CODE, AL_NAME, AL_HQ) VALUES
('AUA', 'Austrian Airlines', 'Vienna'),
('LH', 'Lufthansa', 'Berlin'),
('FD', 'Flydubai', 'Dubai');

UPDATE AIRLINE SET AL_HQ = 'Frankfurt' WHERE AL_CODE = 'LH';

INSERT INTO ACTYPE (T_ID, T_MANUFACT ,T_RANGE) VALUES
 ('Airbus A320','Airbus',5700),
('Boeing 737', 'Boeing', 6200),
('Airbus A330', 'Airbus', 13430),
('Boeing 777', 'Boeing', 14200);

INSERT INTO AIRCRAFT (AC_IRN, AC_Nr, AC_NAME, AC_SERVICE_DATE, AC_TYPE, AC_AIRLINE) VALUES
(1, 1, 'A320', '2024-12-20', 'Airbus A320', 'AUA'),
(2, 2, 'A330', '2024-12-20', 'Airbus A330', 'AUA'),
(3, 1, '737', '2024-12-20', 'Boeing 737', 'FD'),
(4, 1, '777', '2024-12-20', 'Boeing 777', 'LH'),
(5, 1, 'A321', '2024-12-20', 'Airbus A320', 'AUA'),
(6, 1, 'A350', '2024-12-20', 'Airbus A330', 'AUA'),
(7, 1, '737 MAX', '2024-12-20', 'Boeing 737', 'FD'),
(8, 1, '787 Dreamliner', '2024-12-20', 'Boeing 777', 'LH'),
(9, 1, 'A320neo', '2024-12-20', 'Airbus A320', 'LH'),
(10, 1, '737 MAX 8', '2024-12-20', 'Boeing 737', 'FD');

INSERT INTO PASSENGER (P_Nr, P_FNAME, P_LNAME, P_GENDER, P_TITLE) VALUES
(1, 'John', 'Doe', 'male', 'Mr.'),
(2, 'Jane', 'Smith', 'female', 'Ms.'),
(3, 'Michael', 'Johnson', 'male', 'Mr.'),
(4, 'Emily', 'Williams', 'female', 'Miss'),
(5, 'David', 'Brown', 'male', 'Mr.'),
(6, 'Sarah', 'Taylor', 'female', 'Mrs.'),
(7, 'Robert', 'Anderson', 'male', 'Dr.'),
(8, 'Emma', 'Martinez', 'female', 'Miss'),
(9, 'William', 'Garcia', 'male', 'Mr.'),
(10, 'Olivia', 'Miller', 'female', 'Miss');



INSERT INTO AIRPORT (A_KEY, A_NAME, A_CITY, A_COUNTRY, A_CAPACITY) VALUES
('LHR', 'London Heathrow Airport', 'London', 'United Kingdom', 80000000),
('CDG', 'Paris Charles de Gaulle Airport', 'Paris', 'France', 72000000),
('FRA', 'Frankfurt Airport', 'Frankfurt', 'Germany', 70000000),
('AMS', 'Amsterdam Airport Schiphol', 'Amsterdam', 'Netherlands', 72000000),
('MAD', 'Adolfo Suárez Madrid–Barajas Airport', 'Madrid', 'Spain', 61000000),
('FCO', 'Leonardo da Vinci–Fiumicino Airport', 'Rome', 'Italy', 43000000),
('MUC', 'Munich Airport', 'Munich', 'Germany', 48000000),
('ATH', 'Athens International Airport', 'Athens', 'Greece', 25600000),
('CPH', 'Copenhagen Airport', 'Copenhagen', 'Denmark', 30000000),
('ARN', 'Stockholm Arlanda Airport', 'Stockholm', 'Sweden', 26000000);

INSERT INTO AIRPORT_DISTANCE (A_KEY1, A_KEY2, DISTANCE) VALUES
('LHR', 'CDG', 344.0),
('LHR', 'FRA', 648.0),
('LHR', 'AMS', 322.0),
('LHR', 'MAD', 1267.0),
('LHR', 'FCO', 1402.0),
('LHR', 'MUC', 1005.0),
('LHR', 'ATH', 2461.0),
('LHR', 'CPH', 954.0),
('LHR', 'ARN', 1463.0),
('CDG', 'FRA', 492.0),
('CDG', 'AMS', 399.0),
('CDG', 'MAD', 1053.0),
('CDG', 'FCO', 1105.0),
('CDG', 'MUC', 839.0),
('CDG', 'ATH', 2341.0),
('CDG', 'CPH', 1069.0),
('CDG', 'ARN', 1685.0),
('FRA', 'AMS', 368.0),
('FRA', 'MAD', 1616.0),
('FRA', 'FCO', 1153.0),
('FRA', 'MUC', 303.0),
('FRA', 'ATH', 1839.0),
('FRA', 'CPH', 717.0),
('FRA', 'ARN', 1362.0),
('AMS', 'MAD', 1629.0),
('AMS', 'FCO', 1315.0),
('AMS', 'MUC', 785.0),
('AMS', 'ATH', 2751.0),
('AMS', 'CPH', 535.0),
('AMS', 'ARN', 1315.0),
('MAD', 'FCO', 1104.0),
('MAD', 'MUC', 1527.0),
('MAD', 'ATH', 2276.0),
('MAD', 'CPH', 2826.0),
('MAD', 'ARN', 3187.0),
('FCO', 'MUC', 738.0),
('FCO', 'ATH', 1484.0),
('FCO', 'CPH', 1881.0),
('FCO', 'ARN', 2107.0),
('MUC', 'ATH', 1461.0),
('MUC', 'CPH', 1063.0),
('MUC', 'ARN', 1620.0),
('ATH', 'CPH', 2081.0),
('ATH', 'ARN', 2685.0),
('CPH', 'ARN', 530.0);

INSERT INTO scheduled_flight (AL_CODE, FL_NR, SCH_D_TIME, SCH_AR_TIME, DAYS, F_FROM, F_TO) VALUES
('LH', 'LH123', '08:00:00', '10:30:00', 0b01111111, 'LHR', 'CDG'),
('FD', 'FD456', '12:30:00', '15:00:00', 0b00101100, 'FRA', 'AMS'),
('AUA', 'AUA789', '09:45:00', '11:15:00', 0b01100000, 'AMS', 'MAD'),
('LH', 'LH234', '14:00:00', '16:45:00', 0b01111001, 'MUC', 'ATH'),
('FD', 'FD789', '16:30:00', '19:15:00', 0b01001010, 'ATH', 'CPH'),
('AUA', 'AUA456', '18:45:00', '20:30:00', 0b00000100, 'ARN', 'LHR'),
('LH', 'LH345', '20:00:00', '23:30:00', 0b01010100, 'CDG', 'FRA'),
('FD', 'FD123', '10:15:00', '12:45:00', 0b01010000, 'MAD', 'FCO'),
('AUA', 'AUA987', '13:00:00', '15:30:00', 0b00011000, 'AMS', 'CPH'),
('LH', 'LH567', '17:30:00', '20:15:00', 0b01010101, 'LHR', 'ARN'),
('AUA', '123', '08:30:00', '10:00:00', 0b01111111, 'MUC', 'ATH'),
('FD', '789', '11:00:00', '13:30:00', 0b01111111, 'MUC', 'ATH'),
('LH', '456', '10:00:00', '12:30:00', 0b011111111, 'ATH', 'MUC'),
('AUA', '234', '12:30:00', '15:00:00', 0b01111111, 'ATH', 'MUC'),
('FD', '987', '15:00:00', '17:30:00', 0b01111111, 'ATH', 'MUC');



INSERT INTO row (AC_IRN, R_CLASS, R_NR) VALUES
(1, 'economy', 1),
(1, 'economy', 2);

INSERT INTO seat (AC_IRN, R_Nr, S_Nr) VALUES
(1, 1, 'A'),
(1, 1, 'B'),
(1, 1, 'C'),
(1, 1, 'D'),
(1, 1, 'E'),
(1, 1, 'F'),
(1, 1, 'G'),
(1, 2, 'A'),
(1, 2, 'B'),
(1, 2, 'C'),
(1, 2, 'D'),
(1, 2, 'E'),
(1, 2, 'F'),
(1, 2, 'G');


// ================== FLIGHT SEARCH

SET @date_input = '2024-05-25';
SET @start_time = '05:00:00';
SET @end_time = '18:00:00';

SELECT CONCAT(DAYNAME(@date_input), ', ', @date_input) AS 'DATE',
       airline.AL_NAME AS 'AIRLINE',
       CONCAT(sf.AL_CODE, sf.FL_NR) AS 'FLIGHT Nr',
       from_airport.A_NAME AS 'FROM',
       sf.SCH_D_TIME AS 'DEP.',
       to_airport.A_NAME AS 'TO',
       sf.SCH_AR_TIME AS 'ARR.'
FROM scheduled_flight sf
JOIN AIRPORT from_airport ON sf.F_FROM = from_airport.A_KEY
JOIN AIRPORT to_airport ON sf.F_TO = to_airport.A_KEY
JOIN AIRLINE airline ON sf.AL_CODE = airline.AL_CODE
WHERE sf.F_FROM = 'MUC' 
AND sf.F_TO = 'ATH'
AND (sf.DAYS & POW(2, DAYOFWEEK(@date_input) - 1)) > 0
AND sf.SCH_D_TIME BETWEEN @start_time AND @end_time;

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// TICKET 

INSERT INTO ticket (ISSUE_DATE, PRICE, CURRENCY, T_CLASS, P_Nr, FL_DATE, BC_Nr, AL_CODE, FL_NR, SALES_OFFICE)
VALUES (CURDATE(), 150.00, 'EUR', 'economy', 1, @date_input, null, 'AUA', '123', 'office011');


SELECT T_NR, ISSUE_DATE, PRICE, CURRENCY, SALES_OFFICE FROM ticket WHERE P_Nr = 1;

INSERT INTO boarding_card (AC_IRN, AL_CODE, FL_DATE, FL_NR, ROW_NR, SEAT, T_Nr)
VALUES (1, 'AUA', @date_input, '123', 2, 'E', 2);

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////BOARDING CARD 
SELECT CONCAT(AL_CODE, FL_NR) AS FLIGHT, CONCAT(ROW_NR, SEAT) AS SEAT FROM boarding_card WHERE T_Nr = 2;

SELECT CONCAT(b.AL_CODE, b.FL_NR) AS FLIGHT,
       CONCAT(b.ROW_NR, b.SEAT) AS SEAT,
       sf.SCH_D_TIME AS DEPARTURE,
       CONCAT(p.P_FNAME, ' ', p.P_LNAME) AS PASSENGER
FROM boarding_card b
JOIN scheduled_flight sf ON b.AL_CODE = sf.AL_CODE AND b.FL_NR = sf.FL_NR
JOIN ticket t ON b.T_Nr = t.T_Nr
JOIN passenger p ON t.P_Nr = p.P_Nr
WHERE b.T_Nr = 2;
