use examtask
GO
CREATE TRIGGER delete_group
ON group_student
after UPDATE
AS
BEGIN

END
GO

select distinct g.name , g.id from [group] g
 join  group_student gs on g.id = gs.id 

select * from group_student where id = 1

SELECT * FROM [group]