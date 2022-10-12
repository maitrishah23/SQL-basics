--1. Find the patients who have a billing charge over $1000 or a billing charge under $10. How many patients are there?

USE physicianpractice;

SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge > 1000
UNION
SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge < 10
ORDER BY Patientkey;
--RETURNS 16044 ROWS

SELECT COUNT(*) FROM (SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge > 1000
UNION
SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge < 10) AS billingData;
--THERE ARE 16044 PATIENTS HAVING BILLING CHARGE OVER $1000 OR CHARGE UNDER $10

--2. Find the patients who have both a billing charge over $1000 and a billing charge under $10. How many patients are there?

SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge > 1000
INTERSECT
SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge < 10
ORDER BY Patientkey;
--RETURNS 3659 ROWS

SELECT COUNT(*) FROM (SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge > 1000
INTERSECT
SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge < 10) AS billingData;
--THERE ARE 3659 PATIENTS HAVING BILLING CHARGE OVER $1000 AND CHARGE UNDER $10

--3. Find the patients who do have a billing charge over $1000 but who do not have a billing charge under $10.  How many patients are there?
SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge > 1000
EXCEPT
SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge < 10
ORDER BY Patientkey;
--RETURNS 3671 ROWS


SELECT COUNT(*) FROM (SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge > 1000
EXCEPT
SELECT DISTINCT b.PatientKey FROM Phys.Billing b
WHERE b.BillingCharge < 10) AS billingData;
----THERE ARE 3671 PATIENTS HAVING BILLING CHARGE OVER $1000 BUT NOT A CILLING CHARGE UNDER $10.

--4.Write a query that lists every patient who has at least ONe A1c result that is higher than the average A1c results for each patient's PCP. 
--Use temp.PhysicianAverageA1c for this.  DON't list patients more than ONce.  
--Note that temp.PhysicianAverageA1c already exists.  You wON't create it.  You'll JOIN it in your query.

SELECT DISTINCT p.PatientKey, p.FirstName, p.LastName FROM Phys.patient p
JOIN temp.PhysicianAverageA1c tp ON p.PCPPhysicianKey = tp.PCPPhysicianKey
JOIN Phys.LaboratoryTests lt ON lt.PatientKey = p.PatientKey AND lt.Description = 'Hemoglobin A1c'
WHERE lt.value > tp.AverageA1cByPCP
ORDER BY p.Patientkey;
--RETURNS 1330 ROWS

--5 Write a query that lists the average A1c value for all patients assigned to each PCP. That's ONe average for each PCP.
--(Hint:  you should get 20 rows, and your results should look a lot like the temp.PhysicianAverageA1c table.)  DON't use temp.PhysicianAverageA1c or any other temp or view tables in your query for #5.

SELECT DISTINCT p.PCPPhysicianKey, AVG(lt.value) AS Average_A1c FROM Phys.Patient P
INNER JOIN Phys.IgnoreMe PCP ON P.PatientKey = PCP.PatientKey
INNER JOIN Phys.Laboratorytests lt ON P.PatientKey = lt.PatientKey
WHERE lt.Description = 'Hemoglobin A1c'
GROUP BY p.PCPPhysicianKey
ORDER BY p.PCPPhysicianKey;
--RETURNS 20 ROWS

--6. Take your answer to #4, and instead of using temp.PhysicianAverageA1c, use your query FROM #5 as a subquery.  
--DON't use any temp tables or views.  DON't list patients more than ONce. 
--Hint:  Make a copy of your query FROM #5, and replace temp.PhysicianAverageA1c with your subquery, which is the query query you wrote for #4.  
--You will literally copy and paste your subquery to replace temp.PhysicianAverageA1c).


SELECT DISTINCT p.PatientKey, p.FirstName, p.LastName FROM Phys.patient p
JOIN (SELECT DISTINCT p.PCPPhysicianKey, AVG(lt.value) AS Average_A1c FROM Phys.Patient P
INNER JOIN Phys.IgnoreMe PCP ON P.PatientKey = PCP.PatientKey
INNER JOIN Phys.Laboratorytests lt ON P.PatientKey = lt.PatientKey
WHERE lt.Description = 'Hemoglobin A1c'
GROUP BY p.PCPPhysicianKey) AS physicianAverageA1c ON p.PCPPhysicianKey= physicianAverageA1c.PCPPhysicianKey
JOIN Phys.LaboratoryTests lt ON lt.PatientKey = p.PatientKey AND lt.Description = 'Hemoglobin A1c'
WHERE lt.value > physicianAverageA1c.Average_A1c
ORDER BY p.Patientkey;
--RETURNS 1330 ROWS



