use examtask
GO
CREATE TRIGGER trigger_delete_group
ON group_student
after UPDATE
AS
BEGIN
UPDATE [group] SET [status]=0 where id NOT IN (select group_id from group_student where [status]=1)
END
GO

select distinct g.name , g.id from [group] g
 join  group_student gs on g.id = gs.id 

select * from group_student where group_id = 13

UPDATE [group] SET [status]=1 where id NOT IN (select group_id from group_student where [status]=1)

select * FROM [group]
EXECUTE Insert_group_student 1,1

EXECUTE Update_group_student 10,1,1,0

