use PhysicianPractice;

--Q1. Find the Physicians born in 1964. How many are there?
Select * from Phys.Physician
where BirthDate between '1964-01-01' and '1964-12-31';
--There are 3 Physicians born in 1964

--Q2 Find the first names and last names of patients born in 1964 who are single. How many are there?

Select FirstName, LastName
From Phys.Patient where BirthDate between '1964-01-01' and '1964-12-31'
And MaritalStatus= 'S';
--Returns 339 rows, there are thus 339 such patients

--Q3 . Find the diagnosis dates for patients with Diabetes. How many patients are there?  
--(Hint: these are two separate questions.  To do the second half, you will need a slightly different SELECT.  For the second half, don’t just count the diagnoses; Count patients.)

Select FirstDiagnosed from Phys.PatientCondition
Where PCondition= 'Diabetes';
--Returns 4190 patients with diagnosis of Diabetes

Select Distinct FirstDiagnosed from Phys.PatientCondition
Where PCondition= 'Diabetes';
--Returns 2350 patient count

--Q4 Find the diagnosis dates for patients with Diabetes or Hypertension. How many patients are there?  (Hint: these are also two separate questions.)

Select FirstDiagnosed from Phys.PatientCondition
Where PCondition= 'Diabetes' or PCondition= 'Hypertension';
--Returns 10014 rows

Select Distinct FirstDiagnosed from Phys.PatientCondition
Where PCondition= 'Diabetes' or PCondition= 'Hypertension';
--Returns 3115 rows

--Q5 . Find the first names of patients with a last name of Brown? How could you determine if any of them have the same first name as each other? (For example, two people named John Brown.  We’re not looking for people named Brown Brown.)

Select FirstName from Phys.Patient
Where LastName= 'Brown'
and FirstName != 'Brown';
--Returns 82 rows

--Q6
Select * from Phys.Physician  where LastName Like 'Sa%'
and (MiddleName= Null or BirthDate >= '1960-01-01' );
-- Returns 8 rows

--Q7
select distinct FirstName, LastName from Phys.Patient

select distinct FirstName, LastName, MiddleName from Phys.Patient