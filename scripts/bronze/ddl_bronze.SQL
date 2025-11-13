--FULL LOAD IN BRONZE LAYER


--EXECUTE THE SOTRED PROCEDURE 
EXEC bronze.load_bronze;
GO



CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME ,@batch_start_time DATETIME ,@batch_end_time DATETIME;

    BEGIN TRY
	    SET @batch_start_time = GETDATE();
        PRINT '==========================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '==========================';

        PRINT '--------------------------';
        PRINT 'LOADING CRM TABLES';
        PRINT '--------------------------';

        --1
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        FROM 'D:\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        --2
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_prd_info;

        BULK INSERT bronze.crm_prd_info
        FROM 'D:\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        --3
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        FROM 'D:\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        PRINT '--------------------------';
        PRINT 'LOADING ERP TABLES';
        PRINT '--------------------------';

        --4
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_CUST_AZ12;

        BULK INSERT bronze.erp_CUST_AZ12
        FROM 'D:\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        --5
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_LOC_A101;

        BULK INSERT bronze.erp_LOC_A101
        FROM 'D:\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';

        -- 6
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

        BULK INSERT bronze.erp_PX_CAT_G1V2
        FROM 'D:\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW=2,
            FIELDTERMINATOR=',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------';


		SET @batch_end_time = GETDATE();

		PRINT '===============================';
        PRINT 'LOADING BRONZE LAYER COMPLETED';
        PRINT 'TOTAL DURATION: ' + CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'SECONDS';
        PRINT '===============================';


    END TRY

    BEGIN CATCH
        PRINT '===============================';
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        PRINT 'ERROR MESSAGE : ' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER  : ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
        PRINT 'ERROR STATE   : ' + CAST(ERROR_STATE() AS VARCHAR(10));
        PRINT '===============================';
    END CATCH;
END;
GO
