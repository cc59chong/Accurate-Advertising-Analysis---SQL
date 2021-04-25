/* The number of click on eacn AD*/
SELECT adgroup_id, COUNT(*) AS arise_count
FROM raw_sample
GROUP BY adgroup_id
ORDER BY arise_count DESC;

/*Select 118317 ads with the most clicks as the new data set to build a table */
CREATE TABLE IF NOT EXISTS 118317_sample
(
userid  INT NOT NULL, 
time_stamp VARCHAR(100) NOT NULL,
adgroup_id VARCHAR(20) DEFAULT NULL,
pid  VARCHAR(100) DEFAULT NULL,
nonclk  VARCHAR(20) DEFAULT NULL,
clk VARCHAR(20) DEFAULT NULL
);

/* insert data to the new table*/
INSERT INTO 118317_sample
SELECT * FROM raw_sample
WHERE adgroup_id = 118317;

SELECT * FROM 118317_sample;

/*create a viw*/
DROP VIEW IF EXISTS per_group_an;
CREATE VIEW per_group_an AS
SELECT s.userid,
FROM_UNIXTIME(s.time_stamp, '%Y-%m-%d') AS 'clik_date',
FROM_UNIXTIME(s.time_stamp, '%k') AS 'clk_time',
s.pid,
s.nonclk,
s.clk,
u.new_user_class_level,
u.age_level,
u.final_gender_code,
u.pvalue_level,
u.occupation,
u.shopping_level
FROM 118317_sample AS s, user_profile AS u
WHERE u.userid = s.userid;

SELECT * FROM per_group_an;

/*price*/
SELECT price
FROM ad_feature
WHERE adgroup_id = 118317;

/* Analysis of CTR of different channels*/
SELECT pid,
       COUNT(*) AS arise_count,
       SUM(clk) AS clk_count,
       CONCAT(ROUND(SUM(clk)/COUNT(*) * 100, 2), '%') AS clk_ratio
FROM per_group_an 
GROUP BY pid
ORDER BY clk_ratio DESC;

/* CTR analysis of each time per day*/
SELECT clk_time, COUNT(*) AS arise_count,
       SUM(clk) AS clk_count,
	   ROUND(SUM(clk)/COUNT(*),4) AS clk_ratio,
	   CONCAT(ROUND(SUM(clk)/COUNT(*) * 100,2),'%') AS clk_ratio_copy
FROM per_group_an
GROUP BY clk_time
ORDER BY clk_ratio DESC;

/* CTR analysis for each day of the week*/
SELECT DATE_FORMAT(clik_date, '%w') AS week_day,
       COUNT(*) AS arise_count,
       SUM(clk) AS clk_count,
       ROUND(SUM(clk)/COUNT(*),4) AS clk_ratio,
       CONCAT(ROUND(SUM(clk)/COUNT(*) * 100, 2), '%') AS clk_ratio_copy
FROM per_group_an
GROUP BY 1
ORDER BY 4 DESC;

/* CTR analysis for each time of every day*/
SELECT DATE_FORMAT(clik_date,'%w') AS week_day, 
       clk_time,
       COUNT(*) AS arise_count,
       SUM(clk) AS clk_count,
	   ROUND(SUM(clk)/COUNT(*),4) AS clk_ratio,
	   CONCAT(ROUND(SUM(clk)/COUNT(*) * 100,2),'%') AS clk_ratio_copy
FROM per_group_an
GROUP BY DATE_FORMAT(clik_date,'%w'),clk_time 
ORDER BY clk_ratio DESC;

/* CTR analysis of people of different ages*/
SELECT age_level,
       COUNT(*) AS arise_count,
       SUM(clk) AS clk_count,
       ROUND(SUM(clk)/COUNT(*), 4) AS clk_ratio,
       CONCAT(ROUND(SUM(clk)/COUNT(*) * 100, 2), '%') AS clk_ratio_copy
FROM per_group_an
GROUP BY age_level
ORDER BY clk_ratio DESC;

/*CTR analysis of people of various consumption levels*/
SELECT pvalue_level,
       COUNT(*) AS arise_count,
       SUM(clk) AS clk_count,
       ROUND(SUM(clk)/COUNT(*), 4) AS clk_ratio,
       CONCAT(ROUND(SUM(clk)/COUNT(*) * 100, 2), '%') AS clk_ratio_copy
FROM per_group_an
GROUP BY pvalue_level
ORDER BY clk_ratio DESC;

/* CTR analysis among people of different shopping levels*/
SELECT shopping_level,
       COUNT(*) AS arise_count,
       SUM(clk) AS clk_count,
       ROUND(SUM(clk)/COUNT(*), 4) AS clk_ratio,
       CONCAT(ROUND(SUM(clk)/COUNT(*) * 100, 2), '%') AS clk_ratio_copy
FROM per_group_an
GROUP BY shopping_level
ORDER BY clk_ratio DESC;

/*CTR analysis of various occupations (college students or not)*/
SELECT occupation,
       COUNT(*) AS arise_count,
       SUM(clk) AS clk_count,
       ROUND(SUM(clk)/COUNT(*), 4) AS clk_ratio,
       CONCAT(ROUND(SUM(clk)/COUNT(*) * 100, 2), '%') AS clk_ratio_copy
FROM per_group_an
GROUP BY occupation
ORDER BY clk_ratio DESC;

/*CTR analysis of crowd at different city levels*/
SELECT new_user_class_level,
       COUNT(*) AS arise_count,
       SUM(clk) AS clk_count,
       ROUND(SUM(clk)/COUNT(*), 4) AS clk_ratio,
       CONCAT(ROUND(SUM(clk)/COUNT(*) * 100, 2), '%') AS clk_ratio_copy
FROM per_group_an
GROUP BY new_user_class_level
ORDER BY clk_ratio DESC;

