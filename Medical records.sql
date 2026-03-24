DROP TABLE IF EXISTS Hospital;

CREATE TABLE Hospital (
    "Patient ID" INT,
    "Age" INT,
    "Gender" VARCHAR(50),
    "Ethnicity" VARCHAR(50),
    "Marital Status" VARCHAR(50),
    "Education Level" VARCHAR(50),
    "OCD Diagnosis Date" DATE,
    "Duration of Symptoms (months)" INT,
    "Previous Diagnoses" VARCHAR(100),
    "Family History of OCD" VARCHAR(50),
    "Obsession Type" VARCHAR(100),
    "Compulsion Type" VARCHAR(100),
    "Y-BOCS Score (Obsessions)" INT,
    "Y-BOCS Score (Compulsions)" INT,
    "Depression Diagnosis" VARCHAR(50),
    "Anxiety Diagnosis" VARCHAR(50),
    "Medications" VARCHAR(100)
);
COPY Hospital
FROM 'C:\Users\Samad\Downloads\ocd_patient_dataset.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

select * from Hospital;
-- 1. Count & Pct of F vs M that have OCD & -- Average Obsession Score by Gender
select
   "Gender",
   count(*) as patient_count,
   round(count(*) * 100/sum(count(*)) over(),2) as  pct_patients ,
   round(avg("Y-BOCS Score (Obsessions)"),2) as avg_obession_score
from Hospital
group by "Gender";

-- 2. Count of Patients by Ethnicity and their respective Average Obsession Score

select 
"Ethnicity",
count(*) as Patients_count,
round(avg("Y-BOCS Score (Obsessions)"),2) as avg_obession_score
from Hospital
group by "Ethnicity";

-- 3. Number of people diagnosed with OCD MoM


select
    date_trunc('month', "OCD Diagnosis Date") as month,
    count("Patient ID") as patient_count
from Hospital
group by month
order by month;

-- 4. What is the most common Obsession Type (Count) & it's respective Average Obsession Score
select "Obsession Type",
count(*) as Obession_Type_count,
avg( "Y-BOCS Score (Obsessions)") as Avg_Y_Bocs_Score
from Hospital
group by "Obsession Type"
order by Obession_Type_count desc
;

-- 5. What is the most common Compulsion type (Count) & it's respective Average Obsession Score

select "Compulsion Type",
count(*) as Compulsion_Type_count,
avg("Y-BOCS Score (Obsessions)") as Avg_Y_Compul_Type
from Hospital
group by "Compulsion Type"
order by Avg_Y_Compul_Type desc
;
