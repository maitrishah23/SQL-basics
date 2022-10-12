--** Week 4 Lesson 2 Exercises*/use PhysicianPractice;
-- 1. Find the age of patients.
-- Using day date differences takes into account the month and day.
-- Year does not.-- See the explanation posted in the lecture materials

select p.FirstName, p.LastName, p.Birthdate, datediff(Year, p.BirthDate, getdate()) as Age_of_pt 
from Phys.patient p;

--2. Calculate the LDL values (from the view, phys.lipidspanel),
--  using HDL,Triglycerides, and calculated total cholesterol.
-- Use the formula to solve for LDL:
--   LDL = CalculatedTotalCholesterol - .2*Triglycerides - HDL 
-- See how you can SELECT a view the same way you can from any table.

select * from Phys.Lipidspanel;
select p.PatientKey, p.Orderdate, p.LDL, CalculatedTotalCholesterol - .2*Triglycerides- HDL as LDLCalculated
from Phys.LipidsPanel p;

-- 3. Find the last three letters of each Physicians last name.
Select ph.LastName, Right(ph.lastname, 3)
From Phys.Physician ph;

---4. Find the age difference between a patient and their PCP.-- note the use of the cast function.
Select ph.Birthdate, p.Birthdate,
datediff (year, p.Birthdate, ph.birthdate) as AgeDiff 
from Phys.Patient p
Join Phys.Physician ph
on p.PCPPhysicianKey= ph.Physiciankey;

--given solutio. above is what i did
SELECT pat.FirstName AS PatientFirstName,pat.LastName AS PatientLastName,pat.BirthDate AS PatientBirtdate,
md.FirstName AS PhysicianFirstName,md.LastName AS PhysicianLastName,md.BirthDate AS PhysicianBirthdate,
FLOOR(DATEDIFF(day,pat.Birthdate,md.Birthdate)/365.25) ASAgeDifference
FROM Phys.Patient pat
JOIN Phys.Physician md on md.PhysicianKey = pat.PCPPhysicianKey

Select * from Phys.Patient;
Select * from Phys.Physician;