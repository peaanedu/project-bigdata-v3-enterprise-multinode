CREATE DATABASE IF NOT EXISTS lab;
CREATE DATABASE IF NOT EXISTS powerbi;

CREATE EXTERNAL TABLE IF NOT EXISTS lab.sales_orders (
  order_id STRING,
  order_date STRING,
  region STRING,
  product STRING,
  quantity INT,
  amount DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/data/raw/sales'
TBLPROPERTIES ('skip.header.line.count'='1');
