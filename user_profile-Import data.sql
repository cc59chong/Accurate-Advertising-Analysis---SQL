DROP TABLE IF EXISTS user_profile;
CREATE TABLE user_profile (
   userid INT NOT NULL,
   cms_segid INT NOT NULL,
   cms_group_id INT NOT NULL,
   final_gender_code INT NOT NULL,
   age_level INT NOT NULL,
   pvalue_level INT DEFAULT NULL,
   shopping_level INT NOT NULL,
   occupation INT NOT NULL,
   new_user_class_level INT DEFAULT NULL,
   PRIMARY KEY (userid)
   );
   

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/user_profile.csv' 
INTO TABLE user_profile 
FIELDS TERMINATED BY ',' 
ESCAPED BY '"'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(userid,cms_segid,cms_group_id,final_gender_code,age_level,@pvalue_level,shopping_level,occupation,@new_user_class_level)
SET pvalue_level = NULLIF(@pvalue_level,''), new_user_class_level = NULLIF(@new_user_class_level,'');

SELECT * FROM user_profile;