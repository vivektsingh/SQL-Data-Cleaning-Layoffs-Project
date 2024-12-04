-- SQL Data Cleaning: Layoffs Dataset
-- Retrieve rows that have duplicate entries based on the row_num column
SELECT *
FROM layoffs_staging_new2
WHERE row_num > 1;

-- Delete duplicate rows from the table based on the row_num column
DELETE 
FROM layoffs_staging_new2
WHERE row_num > 1;

-- Display the updated table to confirm duplicates are removed
SELECT *
FROM layoffs_staging_new2;

-- Retrieve the company names with any leading or trailing spaces
SELECT company, TRIM(company)
FROM layoffs_staging_new2;

-- Standardize the company names by trimming any leading or trailing spaces
UPDATE layoffs_staging_new2
SET company = TRIM(company);

-- Retrieve a distinct list of industries in alphabetical order
SELECT DISTINCT industry
FROM layoffs_staging_new2
ORDER BY 1;

-- Retrieve rows where the industry name starts with "Crypto"
SELECT *
FROM layoffs_staging_new2
WHERE industry LIKE "Crypto%";

-- Standardize industry names that start with "Crypto" to be 'Crypto'
UPDATE layoffs_staging_new2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Display the distinct industries after standardization
SELECT DISTINCT industry
FROM layoffs_staging_new2;

-- Display all rows to verify changes in the table
SELECT *
FROM layoffs_staging_new2;

-- Retrieve a distinct list of countries in alphabetical order
SELECT DISTINCT country
FROM layoffs_staging_new2
ORDER BY 1;

-- Display distinct countries and their cleaned versions with trailing periods removed
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging_new2
ORDER BY 1;

-- Standardize country names by removing trailing periods
UPDATE layoffs_staging_new2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE "United States%";

-- Display the date column in its original and formatted versions (YYYY-MM-DD)
SELECT date,
STR_TO_DATE(date, '%m/%d/%Y')
FROM layoffs_staging_new2;

-- Update the date column to use the standard YYYY-MM-DD format
UPDATE layoffs_staging_new2
SET date = STR_TO_DATE(date, '%m/%d/%Y');

-- Display all rows to verify changes in the table
SELECT *
FROM layoffs_staging_new2;

-- Change the data type of the date column to DATE
ALTER TABLE layoffs_staging_new2
MODIFY COLUMN date DATE;

-- Retrieve rows where both total_laid_off and percentage_laid_off are NULL
SELECT *
FROM layoffs_staging_new2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Set the industry column to NULL where it is empty
UPDATE layoffs_staging_new2
SET industry = NULL
WHERE industry = "";

-- Retrieve rows where the industry column is NULL or empty
SELECT *
FROM layoffs_staging_new2
WHERE industry IS NULL
  OR industry = '';

-- Retrieve rows where the company name starts with 'Bally'
SELECT *
FROM layoffs_staging_new2
WHERE company LIKE 'Bally%';

-- Find rows where the industry is missing (NULL or empty) and can be filled using related rows
SELECT t1.industry, t2.industry
FROM layoffs_staging_new2 t1
JOIN layoffs_staging_new2 t2
    ON t1.company = t2.company
   AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND t2.industry IS NOT NULL;

-- Fill missing industry values using industry data from related rows
UPDATE layoffs_staging_new2 t1
JOIN layoffs_staging_new2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- Display the updated table after filling missing industries
SELECT *
FROM layoffs_staging_new2;

-- Retrieve rows where both total_laid_off and percentage_laid_off are NULL
SELECT *
FROM layoffs_staging_new2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Display all rows in the table
SELECT *
FROM layoffs_staging_new2;

-- Delete rows where both total_laid_off and percentage_laid_off are NULL
DELETE
FROM layoffs_staging_new2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Drop the row_num column from the table as it is no longer needed
ALTER TABLE layoffs_staging_new2
DROP COLUMN row_num;
