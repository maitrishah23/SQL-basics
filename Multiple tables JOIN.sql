USE PhysicianPractice;

--TO LOOK AT ALL THE TABLES
SELECT * FROM Phys.Patient;
SELECT * FROM Phys.PhysicianPractice;
SELECT * FROM Phys.PhysicianASsignedToPractice;
SELECT * FROM Phys.PatientCONditiON;
SELECT * FROM Phys.LaboratoryTests;
SELECT * FROM Phys.OfficeVisit;


--Q1 Find the practices with patients named CarlsON with Diabetes and a Hemoglobin A1c value greater than 5 and less than 9.
--How many practices are there in the results?
--(Each patient hAS a PCP, each PCP is ASsigned to zero or more practices.)

-- NO. OF PRACTICES WITHOUT DISTINCT
SELECT pp.* FROM Phys.PhysicianPractice pp 
JOIN Phys.PhysicianASsignedToPractice pap ON pp.PhysicianPracticeKey = pap.PhysicianPracticeKey
JOIN Phys.Patient p ON p.PCPPhysicianKey = pap.PhysicianKey
JOIN Phys.PatientCONditiON pc ON p.PatientKey = pc.PatientKey
JOIN Phys.LaboratoryTests lt ON p.PatientKey = lt.PatientKey
WHERE p.LAStName = 'CarlsON' and pc.PCONditiON= 'Diabetes' and lt.DescriptiON = 'Hemoglobin A1c' and lt.Value between '5' and '9';
--RETURNS 11 ROWS

-- NO. OF PRACTICES WITH DISTINCT

SELECT distinct pp.* FROM Phys.PhysicianPractice pp 
JOIN Phys.PhysicianASsignedToPractice pap ON pp.PhysicianPracticeKey = pap.PhysicianPracticeKey
JOIN Phys.Patient p ON p.PCPPhysicianKey = pap.PhysicianKey
JOIN Phys.PatientCONditiON pc ON p.PatientKey = pc.PatientKey
JOIN Phys.LaboratoryTests lt ON p.PatientKey = lt.PatientKey
WHERE p.LAStName = 'CarlsON' and pc.PCONditiON= 'Diabetes' and lt.DescriptiON = 'Hemoglobin A1c' and lt.Value between '5' and '9';

--RETURNS 2 ROWS


-- TO GET NUMBER OF PRACTICES USING COUNT
SELECT COUNT (distinct pp.PhysicianPracticeKey) AS 'Number of Practices' 
FROM Phys.PhysicianPractice pp 
JOIN Phys.PhysicianASsignedToPractice pap ON pp.PhysicianPracticeKey = pap.PhysicianPracticeKey
JOIN Phys.Patient p ON p.PCPPhysicianKey = pap.PhysicianKey
JOIN Phys.PatientCONditiON pc ON p.PatientKey = pc.PatientKey
JOIN Phys.LaboratoryTests lt ON p.PatientKey = lt.PatientKey
WHERE p.LAStName = 'CarlsON' and pc.PCONditiON= 'Diabetes' and lt.DescriptiON = 'Hemoglobin A1c' and lt.Value between '5' and '9';

--2 SUCH PRACTICES ARE THERE


--2. Find the office visits for those patients (the patients FROM questiON 1).  
--How many office visits are there in the results

SELECT * FROM Phys.OfficeVisit;

-- ALL VISITS
SELECT p.PatientKey, ov.DateofVisit FROM Phys.Patient p 
JOIN Phys.PatientCONditiON pc ON p.PatientKey = pc.PatientKey
JOIN Phys.LaboratoryTests lt ON p.PatientKey = lt.PatientKey
JOIN Phys.OfficeVisit ov ON p.PatientKey = ov.PatientKey
WHERE p.LAStName = 'CarlsON' and pc.PCONditiON = 'Diabetes' and lt.DescriptiON = 'Hemoglobin A1c' and lt.Value between '5' and '9';

--RETURNS 60 ROWS

--NO. OF OFFICE VISITS USING COUNT
SELECT COUNT (ov.DateofVisit) AS "Number of Visits" FROM Phys.Patient p 
JOIN Phys.PatientCONditiON pc ON p.PatientKey = pc.PatientKey
JOIN Phys.LaboratoryTests lt ON p.PatientKey = lt.PatientKey
JOIN Phys.OfficeVisit ov ON p.PatientKey = ov.PatientKey
WHERE p.LAStName = 'CarlsON' and pc.PCONditiON = 'Diabetes' and lt.DescriptiON = 'Hemoglobin A1c' and lt.Value between '5' and '9';;;
--THERE ARE 60 OFFICE VISITS

 --3 Find all of the lab results (not just A1c) for those patients
 --(the patients FROM questiON 1: CarlsONs with Diabetes and an A1c >5 and  <9).
 --How many lab results are there in the results?  (Hint:  self-join)
 
SELECT distinct * FROM Phys.Patient p 
JOIN Phys.PatientCONditiON pc1 ON pc1.PatientKey = p.PatientKey
JOIN Phys.PatientCONditiON pc2 ON pc2.PatientKey = p.PatientKey
JOIN Phys.LaboratoryTests lt ON lt.PatientKey= pc1.PatientKey
WHERE p.LAStName = 'CarlsON' and pc1.PCONditiON = 'Diabetes' and pc2.PCONditiON != 'Diabetes' and lt.DescriptiON = 'Hemoglobin A1c' and lt.Value between '5' and '9'; 

--THERE ARE 7 LAB RESULTS 

--4. Find the patients who are older than their PCP.  How many patients are there in the results?
--(We're not looking at just CarlsONs with certain A1c values for this questiON.)

-- PATIENTS OLDER THAN THEIR PCP
SELECT distinct p.FirstName AS 'Patient FName', 
p.LAStName AS 'Patient LName', 
p.BirthDate AS 'PatientBirthdate', 
ph.FirstName AS 'Physician FName', 
ph.LAStName AS 'Physician LName', 
ph.BirthDate AS PhysicianBD FROM Phys.Patient p 
JOIN Phys.Physician ph ON p.PCPPhysicianKey = ph.PhysicianKey
WHERE p.BirthDate < ph.Birthdate;

--NO. OF PATIENTS OLDER THAN THEIR PCP
SELECT COUNT (*) FROM Phys.Patient p 
JOIN Phys.Physician ph 
ON p.PCPPhysicianKey = ph.PhysicianKey
WHERE p.BirthDate < ph.Birthdate;

--THERE ARE 9069 PATIENTS OLDER THAN THEIR PCP


