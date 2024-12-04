# SQL-Data-Cleaning-Layoffs-Project

## Overview
This project focuses on cleaning and standardizing a dataset related to layoffs using SQL. The goal is to ensure the data is accurate, consistent, and ready for analysis.

---

## Key Features
1. **Remove Duplicates**:
   - Used `ROW_NUMBER()` to identify and delete duplicate rows.

2. **Standardize Data**:
   - Trimmed company names and standardized industry and country values.

3. **Handle Missing Values**:
   - Filled null industry values using data from related rows.
   - Removed rows with unrecoverable missing data.

4. **Reformat Dates**:
   - Converted date strings to a standard `DATE` format.

5. **Clean Fields**:
   - Removed unnecessary columns like `row_num` after processing.


---

---

-- Steps and SQL Queries
-- 1. Remove Duplicates

SELECT *
FROM layoffs_staging_new2
WHERE row_num > 1;

DELETE 
FROM layoffs_staging_new2
WHERE row_num > 1;

-- 2.Trim Company Names

UPDATE layoffs_staging_new2
SET company = TRIM(company);

-- 3. Standardize Industry Names

UPDATE layoffs_staging_new2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- 4. Format Dates
UPDATE layoffs_staging_new2
SET date = STR_TO_DATE(date, '%m/%d/%Y');

-- 5. Handle Missing Values
 
UPDATE layoffs_staging_new2
SET industry = t2.industry
FROM layoffs_staging_new2 t1
JOIN layoffs_staging_new2 t2
    ON t1.company = t2.company
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;


Feel free to reach out for any queries or collaborations:

LinkedIn: https://www.linkedin.com/in/vivek-singh-631213216/


