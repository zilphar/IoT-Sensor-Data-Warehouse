# IoT-Sensor-Data-Warehouse

### Project Overview

This project showcases a simplified yet powerful IoT-based data warehouse design for monitoring sensor data from a single building floor. The goal was to simulate a real-world data flow involving time-series sensor data, analyze it for abnormal behavior, and enable reporting through Power BI or SQL queries.

### Data Warehouse Design
#### 1. Schema Creation

A dedicated schema dataschema was created to organize the project-specific tables.

#### 2. Dimension Tables

Three dimension tables created to store descriptive attributes:

DimProject: Holds metadata about each monitored project (building zones/floors).

DimSensor: Stores info about installed sensors (e.g., temperature, humidity, motion).

DimTime: A time dimension table capturing different time granularities for time-series analysis.

#### 3. Fact Table
FactSensorReadings: Central fact table storing actual sensor readings, timestamped and linked to the dimension tables. 

The whole structure supports a star schema model, optimized for efficient analytical querying.

### ETL Simulation
Manual inserts were used to simulate the ETL process:

17 records were inserted into each dimension table.

The fact table was populated with realistic sample readings across different sensors and times, each associated with a project and timestamp.

### Views and Stored Procedures
#### 1. View: sensorreadings
This view joins all relevant dimension tables with the fact table, providing a easily readable dataset.

#### 2. Stored Procedure: sp_sensorreadings
A procedure was created to:

a. Compare live sensor readings with dynamic thresholds stored in a ThresholdLookup table (I created a threshold table sensorthreshold to hold the threshold values for several sensors)

b. Label each reading as Normal, Abnormal Low, or Abnormal High depending on each values position from the min and max threshold.

c. Automate anomaly detection logic to be used in alerting systems or monitoring dashboards.

### Analysis Features
This project demonstrates:

1. Time-series data storage and dimension modeling using star schema.

2. Threshold-based anomaly detection via SQL logic.

3. Use of CASE, and JOIN functions for analytics.

4. Use of IDENTITY keys and FOREIGN KEY constraints to enforce relational integrity.

### Key Learning & Skills Demonstrated
1. Data Warehouse Design (Star Schema)

2. Dimension/Fact Table Structuring

3. Manual ETL Simulation with SQL Scripts

4. View and Stored Procedure Creation

5. Abnormality Detection Logic

6. SQL Best Practices for Analytical Modeling

7. GitHub Documentation for Technical Projects

### Next Steps
For future improvements, this project can be extended by:

Automating ETL using tools like SSIS.

Connecting Power BI for live dashboards.

Scheduling stored procedures via SQL Agent.

Scaling the model to multi-building or real-time IoT streaming data with Azure SQL or BigQuery.

### Below are important screenshots from the project: 

Table names, view and stored procedure in the data warehouse 

![image](https://github.com/user-attachments/assets/ab594998-533c-4aa4-9f1f-be74c0f534b4)


Star Schema (table interconnection)

![Screenshot (1827)4](https://github.com/user-attachments/assets/6e0bebac-8513-441f-84ee-2fb41b466455)


The stored procedure output 

![image](https://github.com/user-attachments/assets/b4ca4bd5-e26d-420b-aa7b-1a8a4878a796)
