-- przyklad z ksi¹¿ki Kalen Delaney, MS SQL Server 2000

alter DATABASE AdventureWorksLT set recursive_triggers on
go

drop table if exists budzet;
go
create table budzet
(
  nazwa_wydzialu varchar(30) not null,
  nazwa_wydzialu_nadrzednego varchar(30) null,
  budzet_miesieczny int not null
)
go

delete from budzet
insert budzet values( 'Szkolenia krajowe', 'Szkolenia', 10 )
insert budzet values( 'Szkolenia', 'Us³ugi edukacyjne', 100 )
insert budzet values( 'Us³ugi edukacyjne', 'Us³ugi', 500 )
insert budzet values( 'Us³ugi', null, 1200 )
go

drop trigger if exists update_budzet
go
create trigger update_budzet on budzet after update as
begin
  declare @rows int
  set @rows=@@rowcount
  if ( @rows=0 ) return
  if ( @rows>1 ) begin
    print 'Mo¿na modyfikowaæ tylko jeden wiersz jednoczeœnie'
    rollback transaction
    return
  end
  if ( ( select nazwa_wydzialu_nadrzednego from inserted ) is null ) return
  update budzet set budzet_miesieczny=budzet_miesieczny +
    ( select budzet_miesieczny from inserted ) -
    ( select budzet_miesieczny from deleted )
    where nazwa_wydzialu=( select nazwa_wydzialu_nadrzednego from deleted )
end
go

select * from budzet

update budzet set budzet_miesieczny=20 where nazwa_wydzialu='Szkolenia krajowe'

select * from budzet
