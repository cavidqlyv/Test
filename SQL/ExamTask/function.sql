USE examtask 

IF EXISTS (SELECT * 
           FROM   sys.objects 
           WHERE  object_id = Object_id(N'[dbo].[Checkuser]') 
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' )) 
  DROP FUNCTION [dbo].[Checkuser] 

go 

CREATE FUNCTION dbo.Checkuser (@username VARCHAR(40), 
                               @password VARCHAR(40)) 
returns BIT 
AS 
  BEGIN 
      DECLARE @result BIT =0; 
      DECLARE @student INT=0; 
      DECLARE @teacher INT=0; 

      SELECT @student = Count(*) 
      FROM   student 
      WHERE  username = @username 
             AND [password] = @password 

      IF @student = 1 
        BEGIN 
            RETURN 1; 
        END 

      SELECT @teacher = Count(*) 
      FROM   teacher 
      WHERE  username = @username 
             AND [password] = @password 

      IF @teacher = 1 
        BEGIN 
            RETURN 1; 
        END 

      RETURN 0; 
  END 

go 
SELECT * FROM student
SELECT dbo.Checkuser('hgawthorp0','X1aILVov5');