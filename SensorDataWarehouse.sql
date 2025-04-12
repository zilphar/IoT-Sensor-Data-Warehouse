	--- create a data warehouse for IoT sensor data
CREATE DATABASE SensorDataWarehouse;
GO
	--- use the datawarehouse created 
USE SensorDataWarehouse;
GO

	--- create a custome schema to keep the warehouse organized and scalable 
CREATE SCHEMA dataschema;
GO

--- creating dimensions and fact tables within the schema
---1. project dimension table 
CREATE TABLE dataschema.DimProject (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName NVARCHAR(100),
    Location NVARCHAR(100),
    StartDate DATE
);
GO

---2. sensor dimension table 
CREATE TABLE dataschema.DimSensor (
    SensorID INT PRIMARY KEY IDENTITY(1,1),
    SensorName NVARCHAR(100),
    SensorType NVARCHAR(50),
    Unit NVARCHAR(20),
    InstallationDate DATE
);
GO

---3. time dimension table 
CREATE TABLE dataschema.DimTime (
    TimeID INT PRIMARY KEY IDENTITY(1,1),
    Date DATE,
    Year INT,
    Month INT,
    Day INT,
    Hour INT
);
GO 

---4. fact table for sensor readings 
CREATE TABLE dataschema.FactSensorReadings (
    ReadingID INT PRIMARY KEY IDENTITY(1,1),
    ProjectID INT,
    SensorID INT,
    TimeID INT,
    ReadingValue DECIMAL(10,2),
    ReadingTimestamp DATETIME,
    FOREIGN KEY (ProjectID) REFERENCES dataschema.DimProject(ProjectID),
    FOREIGN KEY (SensorID) REFERENCES dataschema.DimSensor(SensorID),
    FOREIGN KEY (TimeID) REFERENCES dataschema.DimTime(TimeID)
);
GO 


--- insert data in the dimensions and fact table
	--- project dimension
INSERT INTO dataschema.DimProject (ProjectName, Location, StartDate) VALUES
('HVAC Monitoring System', 'Floor 1 - North Wing', '2023-01-05'),
('Lighting Automation', 'Floor 1 - South Wing', '2023-01-12'),
('Security Surveillance', 'Floor 1 - East Wing', '2023-02-01'),
('Water Leak Detection', 'Floor 1 - Utility Room', '2023-02-15'),
('Smart Metering', 'Floor 1 - Electrical Closet', '2023-03-01'),
('Air Quality Monitoring', 'Floor 1 - Conference Room', '2023-03-20'),
('Energy Consumption Tracking', 'Floor 1 - Main Corridor', '2023-04-01'),
('Elevator Usage Monitoring', 'Floor 1 - Elevator Shaft', '2023-04-15'),
('Fire Safety System Monitoring', 'Floor 1 - Server Room', '2023-05-01'),
('Occupancy Monitoring', 'Floor 1 - Lounge Area', '2023-05-10'),
('Temperature Regulation', 'Floor 1 - Reception', '2023-06-01'),
('CO2 Level Monitoring', 'Floor 1 - Meeting Room A', '2023-06-15'),
('Noise Level Detection', 'Floor 1 - Rest Area', '2023-07-01'),
('Humidity Monitoring', 'Floor 1 - Storage Room', '2023-07-15'),
('Light Intensity Monitoring', 'Floor 1 - Open Workspace', '2023-08-01'),
('Smoke Detection', 'Floor 1 - Kitchenette', '2023-08-15'),
('Vibration Detection', 'Floor 1 - Generator Room', '2023-09-01');

	--- sensor dimension 
INSERT INTO dataschema.DimSensor (SensorName, SensorType, Unit, InstallationDate) VALUES
('TempSensor-01', 'Temperature', '°C', '2023-01-06'),
('HumiditySensor-01', 'Humidity', '%', '2023-01-07'),
('LightSensor-01', 'Light Intensity', 'Lux', '2023-01-10'),
('CO2Sensor-01', 'CO2 Level', 'ppm', '2023-01-12'),
('MotionSensor-01', 'Occupancy', 'Boolean', '2023-01-15'),
('NoiseSensor-01', 'Noise Level', 'dB', '2023-01-18'),
('SmokeSensor-01', 'Smoke', 'Boolean', '2023-01-20'),
('VibrationSensor-01', 'Vibration', 'Hz', '2023-01-22'),
('FlowSensor-01', 'Water Flow', 'L/min', '2023-01-25'),
('LeakSensor-01', 'Water Leak', 'Boolean', '2023-01-27'),
('EnergyMeter-01', 'Energy Consumption', 'kWh', '2023-02-01'),
('AirQualitySensor-01', 'Air Quality Index', 'AQI', '2023-02-03'),
('ElevatorCounter-01', 'Usage Counter', 'Counts', '2023-02-05'),
('SecurityCamSensor-01', 'Motion Detection', 'Boolean', '2023-02-08'),
('LightSensor-02', 'Light Intensity', 'Lux', '2023-02-10'),
('TempSensor-02', 'Temperature', '°C', '2023-02-12'),
('HumiditySensor-02', 'Humidity', '%', '2023-02-15');

	--- date dimension 
INSERT INTO dataschema.DimTime (Date, Year, Month, Day, Hour) VALUES
('2023-03-01', 2023, 3, 1, 0),
('2023-03-01', 2023, 3, 1, 6),
('2023-03-01', 2023, 3, 1, 12),
('2023-03-01', 2023, 3, 1, 18),
('2023-03-02', 2023, 3, 2, 0),
('2023-03-02', 2023, 3, 2, 6),
('2023-03-02', 2023, 3, 2, 12),
('2023-03-02', 2023, 3, 2, 18),
('2023-03-03', 2023, 3, 3, 0),
('2023-03-03', 2023, 3, 3, 6),
('2023-03-03', 2023, 3, 3, 12),
('2023-03-03', 2023, 3, 3, 18),
('2023-03-04', 2023, 3, 4, 6),
('2023-03-04', 2023, 3, 4, 12),
('2023-03-04', 2023, 3, 4, 18),
('2023-03-05', 2023, 3, 5, 6),
('2023-03-05', 2023, 3, 5, 12);

	--- facts table 
INSERT INTO dataschema.FactSensorReadings (ProjectID, SensorID, TimeID, ReadingValue, ReadingTimestamp) VALUES
(1, 1, 1, 22.5, '2023-03-01 00:00:00'),
(2, 2, 2, 55.3, '2023-03-01 06:00:00'),
(3, 3, 3, 345.2, '2023-03-01 12:00:00'),
(4, 4, 4, 78.6, '2023-03-01 18:00:00'),
(5, 5, 5, 23.4, '2023-03-02 00:00:00'),
(6, 6, 6, 52.7, '2023-03-02 06:00:00'),
(7, 7, 7, 342.0, '2023-03-02 12:00:00'),
(8, 8, 8, 76.1, '2023-03-02 18:00:00'),
(9, 9, 9, 24.1, '2023-03-03 00:00:00'),
(10, 10, 10, 53.9, '2023-03-03 06:00:00'),
(11, 11, 11, 351.7, '2023-03-03 12:00:00'),
(12, 12, 12, 77.8, '2023-03-03 18:00:00'),
(13, 13, 13, 23.0, '2023-03-04 06:00:00'),
(14, 14, 14, 51.5, '2023-03-04 12:00:00'),
(15, 15, 15, 339.3, '2023-03-04 18:00:00'),
(16, 16, 16, 75.4, '2023-03-05 06:00:00'),
(17, 17, 17, 22.9, '2023-03-05 12:00:00');


SELECT * 
FROM dataschema.FactSensorReadings;

SELECT * 
FROM dataschema.DimProject;

SELECT * 
FROM dataschema.DimSensor;

SELECT * 
FROM dataschema.DimTime;

--- Create a view to store the data joined as one table 
CREATE VIEW sensorreadings AS 
	SELECT f.ReadingID,
		p.ProjectName,
		p.Location,
		s.SensorName,
		s.SensorType,
		s.Unit,
		t.Date,
		t.Year,
		t.Month,
		t.Day,
		t.Hour,
		f.ReadingValue,
		f.ReadingTimestamp
	FROM dataschema.FactSensorReadings AS f 
		JOIN dataschema.DimProject AS p ON f.ProjectID = p.ProjectID
		JOIN dataschema.DimSensor AS s ON f.SensorID = s.SensorID
		JOIN dataschema.DimTime AS t ON f.TimeID = t.TimeID; 
	GO

---- a record of the recent sensor activity in building (the first 10 sensor readings)
SELECT TOP 10 *
FROM sensorreadings
ORDER BY ReadingTimestamp ASC; 

---- get all the temperature readings from floor 1 in March 2023
SELECT *
FROM sensorreadings
WHERE SensorType = 'Temperature'
	AND Month = 3
ORDER BY ReadingTimestamp; 


---- detecting anormaly values using a lookup table and stored procedures 
	--- create  lookup table (defining what 'abnormal' is)
CREATE TABLE sensorthreshold (
ThresholdID INT PRIMARY KEY IDENTITY(1,1),
SensorType NVARCHAR (20),
Minvalue DECIMAL(10,1),
Maxvalue DECIMAL(10,1)
); 

	--- insert threshold values for temperature, humidity, co2, and light 
INSERT INTO sensorthreshold (SensorType, MinValue, MaxValue)
VALUES 
('Temperature', 18, 30),
('Humidity', 30, 60),
('CO2', 400, 1000),
('Light', 100, 500); 


--- create a stored procedure to check if the a value is outside the threshold and flag the rows 
CREATE PROCEDURE sp_sensorreadings AS 
BEGIN 
	SELECT 
		 s.ProjectName,
        s.SensorName,
        s.SensorType,
        s.ReadingValue,
        s.Unit,
        s.ReadingTimestamp,
        th.MinValue,
        th.MaxValue, 
		CASE 
			WHEN s.ReadingValue < th.Minvalue THEN 'Abnormal low'
			WHEN s.ReadingValue > th.Maxvalue THEN 'Abnormal high'
			ELSE 'Normal'
			END AS Readingstatus
	FROM sensorreadings AS s 
		JOIN sensorthreshold AS th 
		ON s.SensorType = th.SensorType
	WHERE s.ReadingValue < th.Minvalue OR s.ReadingValue >th.Maxvalue
	ORDER BY ReadingTimestamp ASC; 
END; 

	
	---execute the stored procedure 
EXEC sp_sensorreadings; 