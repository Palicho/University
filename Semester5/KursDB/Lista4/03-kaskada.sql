drop table if exists emp
drop table if exists dept
go
create table dept ( deptid int primary key, nazwa varchar(10) )
create table emp ( empid int primary key, deptid int constraint FK_dept references dept(deptid), nazwisko varchar(20) )
go

alter table emp nocheck constraint FK_dept
go

insert dept values(1, 'IT')
insert dept values(2, 'HR')
insert dept values(3, 'Marketing')
insert emp values(1, 1, 'Kowalski')
insert emp values(2, 2, 'Nowak')
insert emp values(3, 1, 'Kowalski1')
insert emp values(4, 2, 'Nowak2')
go

drop trigger if exists tr_cascadedept;
go
create trigger tr_cascadedept on dept after update
as
begin
  declare @newdeptid int
  declare @olddeptid int
  declare @num_affected int
  set @num_affected=@@rowcount
  if ( @num_affected=0 ) return
  if update( deptid )
  begin
    if ( @num_affected=1 )
    begin
      select @newdeptid=deptid from inserted
      select @olddeptid=deptid from deleted
      update emp set deptid=@newdeptid where deptid=@olddeptid
      set @num_affected=@@rowcount
      raiserror('Modyfikacja kaskadowa klucza podstawowego w tabeli dept z %d na %d w %d wierszach tabeli emp', 10, 1, @olddeptid, @newdeptid, @num_affected)
    end
    else
    begin
      raiserror('Mo¿na modyfikowaæ wartoœæ klucza g³ównego tylko w jednym wierszu',16,1)
      rollback transaction
    end
  end
end
go

update dept set deptid=4 where deptid=1

select * from dept
select * from emp
