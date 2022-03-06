use Pro;



-- select * from Article limit 0 , 10;

-- select * from Quantity_Article_in_Stock;
-- drop view Quantity_Article_in_Stock;

--  create view Quantity_Article_in_Stock as
--  select sum(Quantity) as Quantity , idArticle,Title,Article,ArticleReference,Lot,Stock,StockActor,StockReference from Article_in_stock_With_Dimesion group by idArticle;
--  
-- create view DashArticle_Quantity as
-- select A.idArticle,Name,SalePrice,Cost,Reference,Quantity from Article A  join Quantity_Article_in_Stock QAS on A.idArticle= QAS.idArticle; 




-- describe Article;

--  update Article set Archived = 0 where idArticle  >0;


--   
  

-- select idArticle,Name,Reference from Article where Archived= 0 ;

-- drop trigger InitStockActor;

-- drop trigger InitActorinStok;

--  create trigger InitStockActor before insert on Stock
--  for each row
-- 	insert into Actor(Name,Reference,LocalStock) values (New.Name, New.Reference,true);
--  
--  create trigger InitActorinStok after insert on Actor
--  for each row
-- 	update Stock set idActor = NEW.idActor where Name = NEW.Name and Reference = NEW.Reference;


/*
select idActor into @x   from Actor where Name = NEW.Name and Reference= NEW.Reference;
		set NEW.idActor= @x;

 drop trigger StockActor;

 delimiter |
   create trigger StockActor Before insert on Stock
   for each row 
   begin 
 	declare x int;
      
    insert into  Actor(Name,Reference,LocalStock) values
    (NEW.Name,NEW,Reference,1);

  	
   END;
  |





 delimiter |

 CREATE TRIGGER ActorAfterStock After INSERT ON Actor
   FOR EACH ROW
  BEGIN
     declare id integer;
    	set @id = NEW.idActor;
     if ( NEW.LocalStock = 1) then
 		UPDATE Stock SET idActor = @id WHERE Name = NEW.Name and Reference = NEW.Reference;
     END IF;
     
   END;
 |

*/

-- drop trigger Relate_Actor_Stock;


/* 

delimiter |
create trigger Relate_Actor_Stock after insert on Actor 
for each row
begin
	if NEW.LocalStock = 1 then 
		update Stock set idActor = NEW.idActor where Name= NEW.Name and Reference= NEW.Reference;
        END if;
END;

|*/


--   insert into Stock (Name,Reference,Archived) value
--   ('StockBlida','InternalStock3',0);

-- insert into Actor(Name,Reference,LocalStock) values
-- ('StockBlida','InternalStock3',true);


-- create trigger init_Stock before insert on stock 
-- for each row
-- 	set NEW.Archived=0;


-- insert into Stock (Name,Reference) value
--  ('NewStck','InternalStock4');
insert into Actor(Name,Reference,LocalStock) values
 ('NewStck','InternalStock4',true);
show triggers;
 select * from Stock ;
 select * from Actor;
 
