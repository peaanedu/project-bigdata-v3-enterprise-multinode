from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("etl_sales").getOrCreate()
df = spark.read.csv("/home/jovyan/datasets/raw/sales_orders.csv", header=True, inferSchema=True)
df.write.mode("overwrite").parquet("/tmp/curated_sales")
print("ETL completed")
spark.stop()
