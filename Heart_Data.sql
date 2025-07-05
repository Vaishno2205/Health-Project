CREATE TABLE Heart_Data (
    age INT,
    sex INT,
    cp INT,
    trestbps INT,
    chol INT,
    fbs INT,
    restecg INT,
    thalach INT,
    exang INT,
    oldpeak FLOAT,
    slope INT,
    ca INT,
    thal INT,
    target INT
);
BULK INSERT Heart_Data
FROM "D:\heart.csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
SELECT *, COUNT(*) AS count
FROM Heart_Data
GROUP BY age, sex, cp, trestbps, chol, fbs, restecg,
         thalach, exang, oldpeak, slope, ca, thal, target
HAVING COUNT(*) > 1;
WITH Ranked AS (
  SELECT *,
         ROW_NUMBER() OVER (
           PARTITION BY age, sex, cp, trestbps, chol, fbs, restecg,
                        thalach, exang, oldpeak, slope, ca, thal, target
           ORDER BY (SELECT NULL)
         ) AS rn
  FROM Heart_Data
)
DELETE FROM Ranked
WHERE rn > 1;
SELECT * FROM Heart_Data;
