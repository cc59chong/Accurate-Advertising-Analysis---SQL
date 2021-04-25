DROP TABLE IF EXISTS raw_sample;
CREATE TABLE raw_sample (
   user INT NOT NULL,
   time_stamp INT NOT NULL,
   adgroup_id INT NOT NULL,
   pid VARCHAR(15) NOT NULL,
   noclk INT NOT NULL,
   clk INT NOT NULL,
   PRIMARY KEY (user,time_stamp,adgroup_id)
   );
   
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/raw_sample.csv' 
INTO TABLE raw_sample 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES; 

SELECT * from raw_sample;