CREATE TABLE Lungs_Cancer (
    Gender VARCHAR(10),
    Age VARCHAR(10),
    Smoking VARCHAR(5),
    Yellow_Fingers VARCHAR(5),
    Anxiety VARCHAR(5),
    Peer_Pressure VARCHAR(5),
    Chronic_Disease VARCHAR(5),
    Fatigue VARCHAR(5),
    Allergy VARCHAR(5),
    Wheezing VARCHAR(5),
    Alcohol_Consuming VARCHAR(5),
    Coughing VARCHAR(5),
    Shortness_of_Breath VARCHAR(5),
    Swallowing_Difficulty VARCHAR(5),
    Chest_Pain VARCHAR(5),
    Lungs_Cancer VARCHAR(5)
);


BULK INSERT Lungs_Cancer
FROM "D:\lung_cancerP.csv"
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

SELECT 
    Gender, Age, Smoking, Yellow_Fingers, Anxiety, Peer_Pressure, Chronic_Disease,
    Fatigue, Allergy, Wheezing, Alcohol_Consuming, Coughing, Shortness_of_Breath,
    Swallowing_Difficulty, Chest_Pain, Lungs_Cancer,
    COUNT(*) AS DuplicateCount
FROM Lungs_Cancer
GROUP BY 
    Gender, Age, Smoking, Yellow_Fingers, Anxiety, Peer_Pressure, Chronic_Disease,
    Fatigue, Allergy, Wheezing, Alcohol_Consuming, Coughing, Shortness_of_Breath,
    Swallowing_Difficulty, Chest_Pain, Lungs_Cancer
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS TotalDuplicateRows
FROM (
    SELECT 
        Gender, Age, Smoking, Yellow_Fingers, Anxiety, Peer_Pressure, Chronic_Disease,
        Fatigue, Allergy, Wheezing, Alcohol_Consuming, Coughing, Shortness_of_Breath,
        Swallowing_Difficulty, Chest_Pain, Lungs_Cancer
    FROM Lungs_Cancer
    GROUP BY 
        Gender, Age, Smoking, Yellow_Fingers, Anxiety, Peer_Pressure, Chronic_Disease,
        Fatigue, Allergy, Wheezing, Alcohol_Consuming, Coughing, Shortness_of_Breath,
        Swallowing_Difficulty, Chest_Pain, Lungs_Cancer
    HAVING COUNT(*) > 1
) dupes;

SELECT * from Lungs_Cancer;

WITH DuplicateCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY 
                   Gender, Age, Smoking, Yellow_Fingers, Anxiety, Peer_Pressure, Chronic_Disease,
                   Fatigue, Allergy, Wheezing, Alcohol_Consuming, Coughing, Shortness_of_Breath,
                   Swallowing_Difficulty, Chest_Pain, Lungs_Cancer
               ORDER BY (SELECT NULL)
           ) AS rn
    FROM Lungs_Cancer
)
DELETE FROM DuplicateCTE
WHERE rn > 1;

SELECT * from Lungs_Cancer;