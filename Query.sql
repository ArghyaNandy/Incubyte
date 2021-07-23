USE [CCDW_STG]
GO
ALTER PROCEDURE [dbo].[CUST_STG_TO_RW_2] @STG_LOAD_DATA VARCHAR(30)='CUSTOMERS'
AS

BEGIN

		DECLARE @SQL_QUERY NVARCHAR(MAX)
		---------------------------------------------------------------------
		-- CREATE #CUSTOMER TABLE TO STORE ALL CUSTOMER DATA LINKED WITH RW_TABLE

		SELECT CUSTOMER.*,TABLE_MAPPER.TABLE_NAME AS RW_TABLE
		INTO #CUSTOMERS FROM [CCDW_STG].[dbo].[CUSTOMERS] CUSTOMER
		LEFT JOIN [CCDW_STG].[dbo].[CUST_MAPPING] TABLE_MAPPER
		ON CUSTOMER.COUNTRY=TABLE_MAPPER.COUNTRY

		----------------------------------------------------------------------

		--CREATE CURSOR TABLE_NAME_CURSOR TO LOAD THE DATA IN MARKET TABLE

		DECLARE @TABLE_NAME NVARCHAR(50);
 
		DECLARE TABLE_NAME_CURSOR CURSOR
		FOR
		SELECT DISTINCT RW_TABLE FROM #CUSTOMERS WHERE RW_TABLE IS NOT NULL
 
		OPEN TABLE_NAME_CURSOR;
 
		FETCH NEXT FROM TABLE_NAME_CURSOR INTO @TABLE_NAME
 
		WHILE @@FETCH_STATUS = 0
			BEGIN
  
	  
			  SET @SQL_QUERY= N'INSERT INTO [CCDW_RW].[dbo].'+QUOTENAME(@TABLE_NAME)+'
			  SELECT NAME,CUST_ID,OPEN_DT,CONSULT_DT,VAC_ID,DR_NAME,STATE,COUNTRY,POSTCODE,DOB,FLAG,CAST(GETDATE() AS DATE)
			  FROM #CUSTOMERS WHERE RW_TABLE ='''+@TABLE_NAME+''''

			  EXEC sp_executesql @SQL_QUERY
 
			  FETCH NEXT  FROM TABLE_NAME_CURSOR  INTO @TABLE_NAME
			END

		CLOSE TABLE_NAME_CURSOR
 
		DEALLOCATE TABLE_NAME_CURSOR

		DROP TABLE #CUSTOMERS

END

------------------------------------------

CREATE TABLE [dbo].[CUST_MAPPING](
	[COUNTRY] [varchar](5) NULL,
	[TABLE_NAME] [varchar](30) NULL
) ON [PRIMARY]

-------------------------------------------
CREATE TABLE [dbo].[CUSTOMERS](
	[NAME] [varchar](255) NULL,
	[CUST_ID] [varchar](18) NULL,
	[OPEN_DT] [date] NULL,
	[CONSULT_DT] [date] NULL,
	[VAC_ID] [char](5) NULL,
	[DR_Name] [char](255) NULL,
	[State] [char](5) NULL,
	[Country] [char](5) NULL,
	[POSTCODE] [int] NULL,
	[DOB] [date] NULL,
	[FLAG] [char](1) NULL
) ON [PRIMARY]
-------------------------------------
CREATE TABLE [dbo].[JOB_STATUS](
	[JOB_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[JOB_NAME] [varchar](30) NULL,
	[FILE_MISSING] [int] NULL,
	[JOB_PASS_FAIL] [int] NULL,
	[JOB_START] [datetime2](3) NULL,
	[JOB_END] [datetime2](3) NULL,
	[OPDATE] [date] NULL,
	[COMMENTS] [varchar](4000) NULL,
	[LOAD_DATE] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[JOB_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

-----------------------------------------

CREATE TABLE [dbo].[RAW_FILE_DETAILS](
	[JOB_NAME] [varchar](20) NULL,
	[FILE_PATH] [varchar](1000) NULL,
	[FILE_NAME] [varchar](20) NULL,
	[FILE_EXTN] [varchar](10) NULL,
	[LOAD_DATE] [date] NULL
) ON [PRIMARY]

------------------------------------------

CREATE TABLE [dbo].[CUST_AU](
	[NAME] [varchar](255) NULL,
	[CUST_ID] [varchar](18) NULL,
	[OPEN_DT] [date] NULL,
	[CONSULT_DT] [date] NULL,
	[VAC_ID] [char](5) NULL,
	[DR_Name] [char](255) NULL,
	[State] [char](5) NULL,
	[County] [char](5) NULL,
	[POSTCODE] [int] NULL,
	[DOB] [date] NULL,
	[FLAG] [char](1) NULL,
	[LOAD_DATE] [date] NULL
) ON [PRIMARY]


CREATE TABLE [dbo].[CUST_IND](
	[NAME] [varchar](255) NULL,
	[CUST_ID] [varchar](18) NULL,
	[OPEN_DT] [date] NULL,
	[CONSULT_DT] [date] NULL,
	[VAC_ID] [char](5) NULL,
	[DR_Name] [char](255) NULL,
	[State] [char](5) NULL,
	[County] [char](5) NULL,
	[POSTCODE] [int] NULL,
	[DOB] [date] NULL,
	[FLAG] [char](1) NULL,
	[LOAD_DATE] [date] NULL
) ON [PRIMARY]

CREATE TABLE [dbo].[CUST_NYC](
	[NAME] [varchar](255) NULL,
	[CUST_ID] [varchar](18) NULL,
	[OPEN_DT] [date] NULL,
	[CONSULT_DT] [date] NULL,
	[VAC_ID] [char](5) NULL,
	[DR_Name] [char](255) NULL,
	[State] [char](5) NULL,
	[County] [char](5) NULL,
	[POSTCODE] [int] NULL,
	[DOB] [date] NULL,
	[FLAG] [char](1) NULL,
	[LOAD_DATE] [date] NULL
) ON [PRIMARY]


CREATE TABLE [dbo].[CUST_PHIL](
	[NAME] [varchar](255) NULL,
	[CUST_ID] [varchar](18) NULL,
	[OPEN_DT] [date] NULL,
	[CONSULT_DT] [date] NULL,
	[VAC_ID] [char](5) NULL,
	[DR_Name] [char](255) NULL,
	[State] [char](5) NULL,
	[County] [char](5) NULL,
	[POSTCODE] [int] NULL,
	[DOB] [date] NULL,
	[FLAG] [char](1) NULL,
	[LOAD_DATE] [date] NULL
) ON [PRIMARY]

CREATE TABLE [dbo].[CUST_USA](
	[NAME] [varchar](255) NULL,
	[CUST_ID] [varchar](18) NULL,
	[OPEN_DT] [date] NULL,
	[CONSULT_DT] [date] NULL,
	[VAC_ID] [char](5) NULL,
	[DR_Name] [char](255) NULL,
	[State] [char](5) NULL,
	[County] [char](5) NULL,
	[POSTCODE] [int] NULL,
	[DOB] [date] NULL,
	[FLAG] [char](1) NULL,
	[LOAD_DATE] [date] NULL
) ON [PRIMARY]