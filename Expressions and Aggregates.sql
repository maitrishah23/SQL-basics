--ExpressiONs

USE PhysicianPractice;
--1. List the names and ages of all patients (not just CarlsONs).
--Interpret "names" however you wish, but use the string expressiONs that we have learned to make the names look good.


SELECT p.FirstName + ' '  
+ CASE WHEN p.MiddleName is Null THEN ' '
ELSE p.MiddleName + ' ' END 
+ p.LAStName+ ' ' AS Patient_Full_Name, 
DATEDIFF(YEAR, p.Birthdate, GETDATE())AS Age_of_patient
FROM Phys.Patient p;
--RETURNS 18383 ROWS



--2. List all of the physicians with  the names of the physicians in ONe column formatted AS: LAStName, FirstName

--That's:

--Feinberg, Daniel

--NOT:

--Feinberg,Daniel

--DON't forget the comma or the space.

SELECT ph.LAStName+ ', ' + ph. FirstName + '' AS Physician_Name 
FROM Phys.Physician ph;
--RETURNS 101 ROWS

--Aggregates

--1.  Find the MINimum and MAXimum Hemoglobin A1c result in the entire table of results.  (Not just for CarlsONs).  
--That's ONe MINimum and ONe MAXimum for the entire table.

SELECT * FROM Phys.LaboratoryTests;
SELECT MIN (lt.Value) AS Minimum_Hba1c,
MAX(lt.Value) AS Maximum_Hba1c
FROM Phys.LaboratoryTests lt
WHERE lt.DescriptiON = 'Hemoglobin A1c';
--RETURNS MIN VALUE AS 3.101 ANS MAX VALUE AS 12.074

--2. Find the MINimum and MAXimum Hemoglobin A1c result for each patient.  (Not just CarlsONs.)  
--That's ONe MINimum and ONe MAXimum for each patient.  Show the patient key, first name, lASt name, MIN A1c, and MAX A1c.

SELECT p.PatientKey, p.Firstname, p.LAStName, 
MIN (lt.Value) AS MIN_HA1c,
MAX(lt.Value) AS MAX_A1c
FROM Phys.Laboratorytests lt 
JOIN Phys.Patient p ON lt.PatientKey= p.PatientKey
WHERE lt.DescriptiON = 'Hemoglobin A1c'
GROUP BY p.PatientKey, p.Firstname, p.LAStName;
--RETURNS 2650 ROWS

--3. Find the average of all Hemoglobin A1c results for each condition.
--We should get one average for each condition, and each condition should be listed once.  (Not just the Carlsons.)

SELECT pc.PCONditiON, AVG (lt.Value) AS AVG_HBA1c
FROM Phys.LaboratoryTests lt
JOIN Phys.PatientCONditiON pc ON pc.PatientKey= lt.PatientKey
WHERE lt.DescriptiON= 'Hemoglobin A1c'
GROUP BY pc.PCONditiON;
--RETURNS 6 ROWS

--4 We are now going to clean up the query FROM questiON #2.  In query #2, you were listing MINimum and MAXimum and PatientKey.  
--For #4, copy the query FROM #2 and modify the query to add a title in each result column that doesn't have a title (use aliASes).  
--SELECT columns AS needed so that you display PatientKey, LAStName, and FirstName columns in the SELECTed results alONg with the MIN,MAX,average, and COUNT of A1c tests (the COUNT for each patient).  
--Order the results alphabetically.  ONly include patients with at leASt two A1c tests.

SELECT p.PatientKey, p.LAStName, p.Firstname, 
MIN (lt.Value) AS MIN_Hba1c, 
MAX(lt.Value) AS MAX_Hba1c,
AVG (lt.Value) AS Average_Hemoglobin_A1c, 
COUNT(lt.value) AS COUNT_Of_HbA1c_Tests
FROM Phys.Laboratorytests lt 
JOIN Phys.Patient p ON lt.PatientKey= p.PatientKey
WHERE lt.DescriptiON = 'Hemoglobin A1c'
GROUP BY p.PatientKey, p.LAStName, p.Firstname
HAVING COUNT(lt.Value) >= 2
ORDER BY p.LAStName;
--RETURNS 2650 ROWS

