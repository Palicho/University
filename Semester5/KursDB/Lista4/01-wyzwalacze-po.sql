-- 1 --
drop table if exists liczby;
go
create table liczby ( liczba int )
go

drop trigger if exists tr_insert_liczby
drop trigger if exists tr_update_liczby
drop trigger if exists tr_delete_liczby
go

create trigger tr_insert_liczby on liczby after insert
as
begin
  print 'Wstawiono wiersz'
  select * from deleted
  select * from inserted
end
go

create trigger tr_update_liczby on liczby after update
as
begin
  print 'Zmodyfikowo wierszy:'+cast( @@rowcount as varchar )
  select * from deleted
  select * from inserted
end
go

create trigger tr_delete_liczby on liczby after delete
as
begin
  declare @ile int
  set @ile=@@rowcount
  if ( @ile=0 ) print 'Nic nie usuniêto'
  else print 'Usuniêto wierszy: '+cast( @ile as varchar )
end
go

delete from liczby
go

insert liczby values(1)
insert liczby values(2)
go

alter table liczby disable trigger tr_insert_liczby
go

insert liczby values(3)
go

alter table liczby enable trigger all
go

insert liczby values(4)
go

select * from liczby
go

update liczby set liczba=5 where liczba>=3
go

-- 2 --

drop trigger if exists tr_insert_liczby
drop trigger if exists tr_insert_liczby1
drop trigger if exists tr_insert_liczby2
go

create trigger tr_insert_liczby on liczby for insert
as print 'Wstawiono wiersz'
go

create trigger tr_insert_liczby1 on liczby for insert
as print 'Wstawiono wiersz 1'
go

create trigger tr_insert_liczby2 on liczby for insert
as print 'Wstawiono wiersz 2'
go

insert liczby values(10)
go

sp_settriggerorder tr_insert_liczby2, first, 'insert'
go

insert liczby values(10)
go

sp_settriggerorder tr_insert_liczby1, first, 'insert' -- tu bêdzie b³¹d
go

exec sp_settriggerorder tr_insert_liczby2, none, 'insert'
exec sp_settriggerorder tr_insert_liczby1, first, 'insert' -- a tu ok
exec sp_settriggerorder tr_insert_liczby2, last, 'insert'
go

insert liczby values(10)
go

-- 3 --

-- praktyczny przyk³ad z dokumentacji

CREATE TRIGGER savedel ON Test..Czytelnik
FOR DELETE
AS INSERT Test..Czytelnik_Deleted SELECT GETDATE, * FROM deleted

-- 4 --

drop trigger if exists tr_insert_liczby
drop trigger if exists tr_insert_liczby1
drop trigger if exists tr_insert_liczby2
go

create trigger tr_insert_liczby on liczby for insert
as
begin
  print 'Wstawiono wiersz'
  rollback
end
go

alter table liczby disable trigger tr_insert_liczby
go
insert liczby values(1)
go
alter table liczby enable trigger all
go

delete liczby
insert liczby values(2)
insert liczby values(2)
insert liczby values(2)
insert liczby values(2)
go

select * from liczby

-- 5 --

drop trigger if exists tr_insert_liczby
drop trigger if exists tr_insert_liczby1
drop trigger if exists tr_insert_liczby2
drop trigger if exists tr_update_liczby
drop trigger if exists tr_delete_liczby
go

create trigger tr_insert_liczby on liczby after insert
as
begin
  print 'Wstawiono wiersz, poziom '+cast( @@nestlevel as varchar )
  insert liczby values(10)
end
go

alter database AdventureWorksLT set recursive_triggers on
go

insert liczby values(5)
go

select * from liczby
go

-- 6 --

drop table if exists liczby
drop table if exists noweliczby
go
create table liczby( liczba int )
create table noweliczby( liczba int check (liczba<=20) )
go

drop trigger if exists tr_insert_liczby
drop trigger if exists tr_insert_noweliczby
go

create trigger tr_insert_liczby on liczby after insert
as
begin
  if ( @@nestlevel>3 ) return -- ulepszenie
  print 'Wstawiono wiersz do liczby; poziom '+cast( @@nestlevel as varchar )
  insert noweliczby select * from inserted
end
go

create trigger tr_insert_noweliczby on noweliczby after insert
as
begin
  if ( @@nestlevel>3 ) return -- ulepszenie
  print 'Wstawiono wiersz do noweliczby; poziom '+cast( @@nestlevel as varchar )
  insert liczby select * from inserted
end
go

--sp_configure 'nested triggers', 1 -- na SQL Azure tego nie ustawimy
--reconfigure

delete from liczby
delete from noweliczby
insert liczby values(5) -- a za drugim razem wstawiamy do noweliczby
select * from liczby
select * from noweliczby
GO
