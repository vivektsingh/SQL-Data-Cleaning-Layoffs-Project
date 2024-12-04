 -- REMOVE DUPLICATE
select *
from layoffs_staging_new2
where row_num > 1;

delete 
from layoffs_staging_new2
where row_num > 1;

select *
from layoffs_staging_new2;

-- Standardizing data

select company,TRIM(company)
from layoffs_staging_new2;

UPDATE layoffs_staging_new2
SET company = TRIM(company);

select distinct industry
from layoffs_staging_new2
ORDER BY 1;

select *
from layoffs_staging_new2
where industry LIKE "Crypto%";

update  layoffs_staging_new2
set industry = 'Crypto'
Where industry LIKE 'Crypto%';

select distinct industry
from layoffs_staging_new2;

select *
from layoffs_staging_new2;

select distinct country
from layoffs_staging_new2
order by 1;

select distinct country, TRIM(TRAILING '.' FROM country)
from layoffs_staging_new2
order by 1;

update layoffs_staging_new2
SET country = TRIM(TRAILING '.' FROM country)
where country like "United States%";

SELECT date,
STR_TO_DATE(date, '%m/%d/%Y')
FROM layoffs_staging_new2;

UPDATE layoffs_staging_new2
SET date = STR_TO_DATE(date, '%m/%d/%Y');

SELECT *
FROM layoffs_staging_new2;

alter table layoffs_staging_new2 -- change date datatype
modify column date DATE;

-- work with NULL values
SELECT *
FROM layoffs_staging_new2
Where total_laid_off IS NULL
 AND percentage_laid_off IS NULL ;
 
 update layoffs_staging_new2
 SET industry = null
 WHERE industry = "";
 
 
select *
From layoffs_staging_new2
where industry IS Null
OR industry = '';

select *
From layoffs_staging_new2
where company like 'Bally%';


select t1.industry , t2.industry
from layoffs_staging_new2 t1
join layoffs_staging_new2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
where (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS not NULL;

update layoffs_staging_new2 t1
JOIN layoffs_staging_new2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
where t1.industry IS NULL
AND t2.industry IS not NULL;

select *
from layoffs_staging_new2;

SELECT *
FROM layoffs_staging_new2
Where total_laid_off IS NULL
 AND percentage_laid_off IS NULL ;
 
select *
from layoffs_staging_new2;
 
 
 
delete
FROM layoffs_staging_new2
Where total_laid_off IS NULL
AND percentage_laid_off IS NULL ;

alter TABLE layoffs_staging_new2
drop column row_num;
 
 
 


