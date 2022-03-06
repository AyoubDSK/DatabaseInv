use Pro;

-- article in stock
-- check quantity


-- insert into Article_in_Stock(idStock,idArticle,idDimension,Quantity,Lot) values (1,1,1,200,'7322Y2022'),(1,2,2,140,'2333Y2022'),(2,1,1,200,'3232Y2022');



select * from Article_in_Stock AIS inner join Stock S inner join Article A inner join Dim D on  AIS.idStock= S.idStock and AIS.idArticle= A.idArticle and AIS.idDimension= D.idDimension;

--  drop view Article_in_stock_With_Dimesion;
--  drop view Quantity_Article_in_Stock; 

--   create view Article_in_stock_With_Dimesion as
--   select Quantity , AIS.idArticle,AIS.idDimension,D.Title,A.Name as Article,A.Reference as ArticleReference , Lot ,AIS.idStock , S.Name as Stock,S.idActor as StockActor,S.Reference as StockReference 
--   from Article_in_Stock AIS inner join Stock S inner join Article A inner join Dim D on  AIS.idStock= S.idStock and AIS.idArticle= A.idArticle and AIS.idDimension= D.idDimension;



--   create view Quantity_Article_in_Stock as
--   select sum(Quantity), idArticle,Title,Article,ArticleReference from Article_in_stock_With_Dimesion group by idArticle;

select * from Article_in_stock_With_Dimesion ; 
select * from Quantity_Article_in_Stock ;

-- create view Quantity_in_Stock as
-- select sum(Quantity),idStock,Stock,StockActor,StockReference from Article_in_stock_With_Dimesion group by idStock;

select * from Quantity_in_Stock;

select sum(Quantity),idArticle,idDimension,Title,Article,ArticleReference from Article_in_stock_With_Dimesion where idArticle=1 and idDimension= 1; 

select * from Article_in_stock_With_Dimesion where idDimension = 1 and idArticle =1 and idStock=1;

-- destocker from stock 
select * from Article_in_Stock;

-- update Article_in_Stock set Quantity= Quantity - 100 where idStock=1 and idArticle=1 and idDimension=1;

select * from Article_in_Stock;


select * from Actor;
