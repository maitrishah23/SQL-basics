use PhysicianPractice;;

SELECT DISTINCT p.FirstName, p.LAstName, p.Birthdate, lt.Description, lt.Value
from Phys.Patient p
join Phys.laboratorytests lt on lt.Patientkey= p.Patientkey 
where not exists
(select null
from Phys.Patient p1
join Phys.LaboratoryTests lt on p1.PatientKey= lt.Patientkey
where (Lastname = 'Carlson' and lt.Description= 'Hemoglobin A1c')
and (lt.Value > '5' and lt.value< '9')
and p1.Patientkey= p.Patientkey);

--1. Find the patients with a condition of hypertension using a sub query



SELECT p.PatientKey
from Phys.Patient p
where EXISTS
(select null
from Phys.PatientCondition pc 
where pc.PCondition = 'Hypertension'
and 
pc.patientkey= p.patientkey)

select *
from Phys.Patient
where PatientKey in 
(select PatientKey
from Phys.laboratorytests
where (Description= 'Systolic Blood Pressure' and Value >180)
and (Description= 'Diastolic Blood Pressure' and value > 90));

-- 2. Find the patients with an LDL value greater than 200 using a sub query

select *
from Phys.Patient
where PatientKey in 
(select PatientKey
from Phys.laboratorytests
where (Description= 'LDL' and value >200)) ;

-- 3. Find the patients with a condition of hypertension and an LDL value greater than 200 using two sub queries

select * 
from Phys.Patient p
join Phys.PatientCondition pc on p.Patientkey= pc.patientkey
where pc. PCondition= 'Hypertension'
intersect
select * 
from Phys.Patient p
join Phys.Laboratorytests lt on p.Patientkey= lt.patientkey
where (lt.Description= 'LDL' and lt.value >200) ;
--this is wrong
-- 4.Find the patients with a condition of hypertension OR an LDL value greater than 200 using two sub queries.

Select count (p.Patientkey) 
from Phys.Patient p
join Phys.Laboratorytests lt on p.Patientkey= lt.patientkey
where (lt.Description= 'Systolic Blood Pressure' and Value >180)
and (Description= 'Diastolic Blood Pressure' and value > 90)
union
select count(p.Patientkey)
from Phys.Patient p
join Phys.Laboratorytests lt on p.Patientkey= lt.patientkey
where (Description= 'LDL' and value >200) ;

SELECT p.patientkey
FROM Phys.Patient p
WHERE EXISTS (SELECT null FROM Phys.LaboratoryTests lt WHERE lt.Description = 'LDL'AND lt.Value > 200 AND lt.PatientKey = p.PatientKey)
or EXISTS (SELECT null FROM Phys.PatientCondition pc WHERE pc.PCondition = 'Hypertension' AND pc.PatientKey = p.PatientKey);
--0 wrong answer
-- To keep things simple, you can just list the patients by PatientKey, not by name.


select * from Phys.Billing;

select * from Phys.Laboratorytests;

select PatientKey, count(*) as billcount
from Phys.Billing
group by PatientKey;

select PatientKey, count(*) as labcount
from Phys.LaboratoryTests
group by PatientKey;

select * 
from (select PatientKey, count(*) as billcount
from Phys.Billing
group by PatientKey) as billtable,
(select PatientKey, count(*) as labcount
from Phys.LaboratoryTests
group by PatientKey) as labtable
where labtable.Patientkey= billtable.Patientkey;

select * 
from (select PatientKey, count(*) as billcount
from Phys.Billing
group by PatientKey) as billtable,
(select PatientKey, count(*) as labcount
from Phys.LaboratoryTests
group by PatientKey) as labtable
where (labtable.Patientkey= billtable.Patientkey)
and labcount> billcount;