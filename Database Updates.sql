USE StudentExperimentalDatabase;

--1.	 FeinbergPatient – primary key, first name, last name, date of birth, phone number.  
--Add other columns if you desire, but do not feel the need to replicate the patient table that we have already seen.

DROP TABLE ShahPatient;

CREATE TABLE ShahPatient
(
PatientKey INT NOT NULL,
FirstName varchar(30) NOT NULL,
MiddleName varchar(15),
LastName varchar(30) NOT NULL,
Gender char,
DateofBirth date null,
PhoneNumber VARCHAR(15) NOT NULL,
CONSTRAINT MSPKconstraint_ PRIMARY KEY (PatientKey));

--2.	FeinbergNurse – primary key, first name, last name, state licensed in, license number, phone number

DROP TABLE ShahNurse;

CREATE TABLE ShahNurse
(
NurseKey INT NOT NULL,
FirstName VARCHAR(30) NOT NULL,
LastName VARCHAR(30) NOT NULL,
StateLicencsedIn VARCHAR(20),
LicenceNo INT,
PhoneNumber VARCHAR(15) NOT NULL
CONSTRAINT MSPKcons1 PRIMARY KEY (NurseKey));

--3.	FeinbergVisit – primary key, nursing notes, foreign key referring to nurse, foreign key referring to patient, when the visit started, 
--when the visit ended.  Use foreign key constraINTs for the foreign keys.

DROP TABLE ShahVisit;

CREATE TABLE ShahVisit
(
VisitKey INT NOT NULL,
NursingNotes VARCHAR(30),
NurseKeyMS INT NOT NULL,
PatientKeyMS INT NOT NULL,
FirstDateofVisit date NULL,
LastDateofVisit date NULL,
CONSTRAINT MSvisitconstraint_ PRIMARY KEY (VisitKey),
CONSTRAINT MSvisitFKconstraint_ FOREIGN KEY (PatientKeyMS)
REFERENCES ShahPatient (PatientKey),
CONSTRAINT MSvisitFKCONSTRAINT2 FOREIGN KEY (NurseKeyMS)
REFERENCES ShahNurse (NurseKey));

--Step 2 – Insert Data

--Insert some data INTo each table.  Three rows in each table is enough, but feel free to add more.  This is not a typing test. 

--Insert INTo Patient table
INSERT INTO ShahPatient VALUES ('1', 'Aarti', 'A', 'Adam', 'F', '2001-1-1', '6170001234');
INSERT INTO ShahPatient VALUES ('2', 'Ben', 'B', 'Benny', 'M', '1995-4-5', '6175670012');
INSERT INTO ShahPatient VALUES ('3', 'Charlie', 'C', 'Chuck', 'M', '2000-12-5', '6175670000');
INSERT INTO ShahPatient VALUES ('4', 'Daya', 'D', 'Daniel', 'F', '1992-10-15', '61756715000');

SELECT * from ShahPatient;

----Insert INTo Nurse table
INSERT INTO ShahNurse VALUES ('10', 'Jona', 'Johns', 'Massachusetts', '12345', '6171001234');
INSERT INTO ShahNurse VALUES ('11', 'Pam', 'Potel', 'California', '23456', '4080001234');
INSERT INTO ShahNurse VALUES ('12', 'Sam', 'Son', 'Massachusetts', '34567', '6170001784');

SELECT * from ShahNurse;

--Insert INTo Visit table
INSERT INTO ShahVisit VALUES ('1', 'Diabetic Patient', '10', '2', '2020-1-1', '2021-1-12');
INSERT INTO ShahVisit VALUES ('2', 'Hypertensive Patient', '11', '2', '2018-2-1', '2021-3-12');
INSERT INTO ShahVisit VALUES ('3', 'HDL Patient', '10', '3', '2019-1-25', '2020-5-30');

SELECT * FROM ShahVisit;

--3. Write a query to SELECT informatiJOIN about the visits, including some informatiJOIN about the nurses and the patients.

SELECT * FROM ShahVisit sv
JOIN ShahPatient sp ON sv.PatientKeyMS = sp.PatientKey
JOIN ShahNurse sn ON sv.NurseKeyMS = sn.NurseKey
WHERE sp.Gender = 'M';

