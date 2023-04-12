alter DATABASE AdventureWorksLT SET recursive_triggers off
go

-- 1 --
drop table if exists liczby
drop table if exists noweliczby
create table liczby( liczba int, gdzie varchar(20) )
create table noweliczby( liczba int check (liczba<=20), gdzie varchar(20) )
go
-- Rekurencja --
drop trigger if exists tr_insert_liczby1
drop trigger if exists tr_insert_liczby2
drop trigger if exists tr_insert_liczby3
go

create trigger tr_insert_liczby1 on liczby instead of insert
as
begin
  print 'Wstawiono wiersz do liczby (t1); poziom '+cast( @@nestlevel as varchar )
-- Rozpatrzyæ dwa przypadki: z poni¿sz¹ instrukcj¹ i bez tej instrukcji
  --insert liczby select liczba, 't1' from inserted
  insert liczby select liczba, 't1' from inserted
end
go
create trigger tr_insert_liczby2 on liczby after insert
as
begin
  print 'Wstawiono wiersz do liczby (t2); poziom '+cast( @@nestlevel as varchar )
  insert liczby select liczba, 't2' from inserted
end
go

insert liczby(liczba) values(5)
go

delete from liczby
go
select * from liczby
go

-- 2 --
-- Wzajemne wywo³ywania: tutaj dzia³a bez ograniczeñ --

drop table if exists liczby
drop table if exists noweliczby
go
create table liczby( liczba int )
create table noweliczby( liczba int check (liczba<=20) )
go

drop trigger if exists tr_insert_liczby
drop trigger if exists tr_insert_noweliczby
go

create trigger tr_insert_liczby on liczby instead of insert
as
begin
  if ( @@nestlevel>2 ) return -- ulepszenie
  print 'Wstawiono wiersz do liczby; poziom '+cast( @@nestlevel as varchar )
  insert liczby select * from inserted
  print 'Liczby; krok 2'
  insert noweliczby select * from inserted
  print 'Liczby; koniec'
end
go

create trigger tr_insert_noweliczby on noweliczby instead of insert
as
begin
  if ( @@nestlevel>2 ) return -- ulepszenie
  print 'Wstawiono wiersz do noweliczby; poziom '+cast( @@nestlevel as varchar )
  insert noweliczby select * from inserted
  print 'Noweliczby; krok 2'
  insert liczby select * from inserted
  print 'Noweliczby; koniec'
end
go

-- start

--sp_configure 'nested triggers', 1
--go
--reconfigure
--go

delete from liczby
delete from noweliczby
insert liczby values(5)
select * from liczby
select * from noweliczby

-- 3 --
-- Brak ³¹czenie cascade z wyzwalaczami typu ,,instead of''

drop table if exists dept
drop table if exists emp
create table dept(deptid int primary key, nazwa varchar(10))
create table emp(empid int primary key, deptid int references dept(deptid) on delete cascade, nazwisko varchar(20)) 
go

insert dept values(1, 'IT')
insert dept values(2, 'HR')
insert dept values(3, 'Marketing')
insert emp values(1,1,'Kowalski')
insert emp values(2,1,'Nowak')
go

delete from dept where deptid=1
select * from emp join dept on emp.deptid=dept.deptid
go

drop trigger if exists tr_emp
go
-- tego wyzwalacza nie mo¿na utworzyæ, poniewa¿ w emp jest references z 
create trigger tr_emp on emp instead of delete
as print 'Usuniêto rekord(y)'
go
-- 4 --

drop table emp
drop table dept
create table dept(deptid int identity(1,1) not null primary key, nazwa varchar(10) unique)
create table emp(empid int identity(1,1) not null primary key, deptid int references dept(deptid), nazwisko varchar(20)) 
go

insert dept values('IT')
insert dept values('HR')
insert dept values('Marketing')
insert emp values(1,'Kowalski')
insert emp values(2,'Nowak')
insert emp values(1,'Kowalski1')
insert emp values(2,'Nowak2')
go

drop view if exists zestaw
go
create view zestaw as
select e.empid nr, d.nazwa dzial, e.nazwisko nazwisko from emp e join dept d on e.deptid=d.deptid
go

drop trigger if exists delete_zestaw
go
create trigger delete_zestaw on zestaw instead of delete
as
begin
  delete emp where empid in (select nr from deleted)
  declare c cursor for select deptid from dept where nazwa in (select dzial from deleted)
  declare @nr int
  open c
  fetch c into @nr
  while ( @@fetch_status=0 )
  begin
    if not exists(select * from emp join dept on emp.deptid=dept.deptid where dept.deptid=@nr)
    begin
      delete dept where deptid=@nr
    end
    fetch c into @nr
  end
  close c
  deallocate c
  print 'usuwanie'
end
go

select * from zestaw
go

delete from zestaw where nazwisko='Kowalski' or nazwisko='Nowak2'
go

select * from zestaw
select * from emp
select * from dept

-- podobnie mo¿na zrealizowaæ wstawianie czegoœ do widoku zestaw, jak równie¿ update

-- 5 --

drop table if exists lekarz
drop table if exists pacjent
create table lekarz (pesel char(11), nazwisko varchar(20), telefon varchar(20))
create table pacjent (pesel char(11), nazwisko varchar(20), telefon varchar(20))
go

insert lekarz values( '00000000001', 'Kowalski1', '071/1234567' )
insert lekarz values( '00000000002', 'Kowalski2', '071/1234568' )
insert lekarz values( '00000000003', 'Kowalski3', '071/1234569' )

insert pacjent values( '00000000011', 'Nowak1', '071/1234557' )
insert pacjent values( '00000000012', 'Nowak2', '071/1234558' )
insert pacjent values( '00000000013', 'Nowak3', '071/1234559' )
go

drop view if exists kontakty
go
create view kontakty as
select pesel,nazwisko,telefon,'lekarz' as 'typ' from lekarz
union
select pesel,nazwisko,telefon,'pacjent' as 'typ' from pacjent
go

select * from kontakty
-- Poni¿sze zapytanie nie zadzia³a
insert into kontakty values('12345678901','Nowy','032/2222333','pacjent')

-- Tworzymy odpowiedni wyzwalacz
drop trigger if exists insert_kontakty
go
create trigger insert_kontakty on kontakty instead of insert
as
begin
  if ( (select count(*) from inserted)>1 )
  begin
    print 'Mo¿na wstawiæ tylko jeden wiersz'
    return
  end
  declare @typ varchar(7)
  set @typ=(select top 1 typ from inserted)
  if ( @typ = 'lekarz' )
  begin
    print 'dodajemy lekarza'
    insert into lekarz select pesel, nazwisko, telefon from inserted
    return
  end
  if ( @typ = 'pacjent' )
  begin
    print 'dodajemy pacjenta'
    insert into pacjent select pesel, nazwisko, telefon from inserted
    return
  end
  print 'nic nie dodajemy'
end

select * from kontakty
insert into kontakty values('12345678901','Nowy','032/2222333','lekarz')
select * from kontakty
select * from lekarz

-- 6 --

sp_helptext insert_kontakty
sp_helptrigger liczby
sp_helptrigger kontakty, 'insert'
