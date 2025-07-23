
sp_helpdb [OKPlaza_total] 

sp_helpdb [OKPlaza]

---------------------------------------------

USE [OKPlaza_total];
GO
 
ALTER DATABASE [OKPlaza_total]
SET RECOVERY SIMPLE;
GO
 
DBCC SHRINKFILE ( [OKPlaza_total] , 1);
GO
 
ALTER DATABASE [OKPlaza_total]
SET RECOVERY FULL;
GO


-- https://blog.naver.com/sky0210love/20152593651
-- https://www.wrapuppro.com/programing/view/Xkn67MKgsKC6yL8


/*

-- db간 테이블, 컬럼 차이 확인 쿼리
SELECT 

    tobe.TABLE_NAME,

    tobe.COLUMN_NAME,

    tobe.DATA_TYPE,

    tobe.CHARACTER_MAXIMUM_LENGTH

FROM (

    SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH

    FROM [OKPlaza_total].INFORMATION_SCHEMA.COLUMNS

) tobe

LEFT JOIN (

    SELECT TABLE_NAME, COLUMN_NAME

    FROM [OKPlaza].INFORMATION_SCHEMA.COLUMNS

) asis

    ON tobe.TABLE_NAME = asis.TABLE_NAME

   AND tobe.COLUMN_NAME = asis.COLUMN_NAME

WHERE asis.COLUMN_NAME IS NULL

ORDER BY tobe.TABLE_NAME, tobe.COLUMN_NAME;*/