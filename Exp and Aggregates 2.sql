select PatientKey,
OrderDate,
HDL,
LDL,
Triglycerides,
HDL+ LDL+ 2*Triglycerides as TotalCholesterol 
from Phys.LipidPanel;


--Concantention
Select ph.FirstName + '' + ph.Middlename + '' + ph. LastName + '' as Fullname
From Phys.Physician ph;


--example 2 to see what a null middle name does
Select ph.Firstname, ph.MiddleName, ph.Lastname, ph.FirstName + '' + ph.Middlename + '' + ph. LastName + '' as Fullname
From Phys.Physician ph;

--string functions- length
Select ph.FirstName, Len(ph.FirstName) as FNLength, ph.MiddleName, Len(ph.MiddleName)as MNLength
from Phys.Physician ph 
where substring (ph.LastName,1,3)= 'Rob';

--Date time examples
SELECT * FROM temp.DateTimeExamples;
SELECT dt.datetype,
dt.Datetimetype,
dt.datetime2type,
dt.datetimeoffsettype
FROM temp.DateTimeExamples dt;

Select getdate(),
Datediff(day, '1/1/2000', Getdate()) as date_from_Jan120, p.FirstName, p.LastName, p.BirthDate, 
Datename (Month, p.BirthDate) + ''
+ Datename (Day, p.Birthdate) + ','
+ Datename(Year, p.Birthdate)
as Bdays_in_text
From Phys.Patient p;

--SELECTgetdate(), -- this gets the current date right now.DATEDIFF(DAY,'1/1/2010',GETDATE()) as days_from_Jan_1_2010, 
-- see separate item inthe lecture regardin DATEDIFF.  
--This gives the number of days since 1/1/2010.p.
--FirstName,p.LastName,p.BirthDate,DATENAME(month,p.birthdate)+ '  ' 
-- this gets the month from the birthdate+ 
--DATENAME(Day,p.birthdate) +', ' -- this gets the day from the birthdate
--+ DATENAME(YEAR,p.BirthDate) -- this gets the year from the birthdate.
--Then the month day and year are concatenated into one string with spaces and commas in the right places.as birthdate_in_text_format
--from Phys.Patient p

Select p.Firstname, p.Lastname, p.BirthDate,
case when p.Gender = 'M' then 'Male'
else 'Female'
end as gendername,
case when p.MaritalStatus = 'S' then 'Single'
when p.MaritalStatus = 'M' then 'Married'
else 'Unknown'
end as MaritalStatus
from Phys.Patient p;


Select ph.Title, ph.FirstName, ph.LastName, ph.Title+ '' +
ph.FirstName + '' 
+ case when ph.MiddleName is Null then ''
else ph.MiddleName + '' end + ph.LastName+ '' as PhysicianName 
from Phys.Physician ph;

--select ph.Title,ph.FirstName,ph.MiddleName,ph.LastName,ph.Title + ' ' +ph.FirstName + ' ' 
--+case when ph.MiddleName is null
--then ''elseph.MiddleName + ' 'end +ph.LastName as FullNamefrom Phys.Physician ph

Select lt.PatientKey, lt.Description, lt.OrderDate,
round (lt.Value, 
case when lt.Description = 'Hemoglobin A1c'
then 2
else 0
end) as value from Phys.Laboratorytests lt; 

SELECT lt.Description,ROUND(lt.value,0) AS 'round(lt.value,0)',
ROUND(lt.value,2) AS 'round(lt.value,2)',
CASE WHEN lt.Description = 'Hemoglobin A1c' 
THEN 2 ELSE 0 END AS 'Case', 
-- This CASE will be 2 when description is Hemoglobin A1c, and it will be zero otherwise.
ROUND(lt.value,  CASE WHEN lt.Description = 'Hemoglobin A1c'  
THEN 2  ELSE 0  END) AS 'value rounded'  
-- This rounds to 2 or 0 decimal places, depending on the result of the CASE. 
 -- instead of putting 0 or 2 as the second parameter for ROUND, we put the CASE, which becomes 0 or 2 depending on whether decription is Hemoglobin A1c.
 FROM Phys.LaboratoryTests lt;



