use PhysicianPractice;

Select * from dbo.AdministrativeGender;
Select * from dbo.MaritalStatus;

Select p.FirstNAme, p.MiddleName, p.LastName, p.BirthDate,
ms. MaritalStatus, p.suffix, 
ag. Gender
From Phys.Patient p
Join dbo.AdministrativeGender ag on p.Gender= ag.Gender
Join dbo. MaritalStatus ms on p.MaritalStatus = ms.MaritalStatusCode;

Select md.PhysicianKey,md.Title,md.FirstName as PhysicianFirstName,
md.LastName as PhysiicanLastName,
p.PatientKey,p.FirstName as PatientFirstName,p.LastName as PatientLastName,
p.Gender,p.BirthDate,pc.PCondition,pc.FirstDiagnosed,pc.Active
from Phys.Physician md
join Phys.Patient p on p.PCPPhysicianKey = md.PhysicianKey
join Phys.PatientCondition pc on pc.PatientKey = p.PatientKey order by md.LastName, p.LastName, pc.FirstDiagnosed desc;

Select pp.*, md.*
from Phys.PhysicianPractice pp 
join Phys.PhysicianAssignedToPractice pap on pp.PhysicianPracticeKey = pap.PhysicianPracticeKey
join Phys.Physician md on pap.PhysicianKey = md.PhysicianKey
order by PracticeName;

--w3 ex 3
Select * from Phys.PhysicianPractice;
Select * from Phys.PhysicianAssignedToPractice;
Select * from Phys.PatientCondition;
Select * from Phys.LaboratoryTests;
Select * from Phys.Patient;



--Find the physician practices with patients who have LDL values greater than 200

SELECT distinct pp.*
FROM Phys.PhysicianPractice pp
JOIN Phys.PhysicianAssignedToPractice pap ON pap.PhysicianPracticeKey = pp.PhysicianPracticeKey
JOIN Phys.Patient p ON p.PCPPhysicianKey = pap.PhysicianKey
JOIN Phys.LaboratoryTests lt ON lt.PatientKey = p.PatientKey
WHERE lt.Description = 'LDL' AND lt.Value > 200;