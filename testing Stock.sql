use Pro;

/*
create Actor
*/
insert into Actor(Name,Reference,LocalStock) values
('Garage2','InternalStock2',true),
('Garage','InternalStock1',true),
('Fournisseur 1','Fourniseur M P',false),
('Client 2','client001',false);


select * from Actor;

/*
create stocks
  */
 insert into stock (Name,idActor,Reference) values
 ('Garage',1,'InternalStock1'),
 ('Garage2',4,'InternalStock2');

 select * from Stock;
   
 create trigger InitStockActor before insert on Stock
 for each row

	insert into Actor(Name,Reference,LocalStock) values (New.Name, New.Reference,true);
 
 create trigger InitActorinStok after insert on Actor
 for each row
	update Stock set idActor = NEW.idActor where Name = NEW.Name and Reference = NEW.Reference;
	 
  