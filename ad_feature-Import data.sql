CREATE DATABASE advertising;

DROP TABLE IF EXISTS ad_feature;
CREATE TABLE ad_feature (
   adgroup_id INT NOT NULL,
   cate_id INT NOT NULL,
   campaign_id INT NOT NULL,
   customer INT NOT NULL,
   brand INT,
   price INT NOT NULL,
   PRIMARY KEY (adgroup_id)
   );
   
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ad_feature.csv' 
INTO TABLE ad_feature 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES(adgroup_id, cate_id, campaign_id, customer, brand, price); 

SELECT * FROM ad_feature;
