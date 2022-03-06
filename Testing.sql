use Pro;


/* create articles 

insert into Article(Name,SalePrice,Cost,Reference) values 
('Pro2',2000,1500,'Pro0001'),
('Pro3',3000,2500,'Pro0002'),
('Pro4',4000,3500,'Pro0003'),
('Pro5',5000,4500,'Pro0004');
*/

/*
 create dimension

 
 insert into Dim(title) values
('dim1'),
('dim2'),
('dim3'),
('dim4'),
('dim5'); 
 */

 /*
 create relation between Articles and  dimension

 insert into DimensionArticle(idArticle,idDimension) values
(1,1),
(1,2),
(1,3),
(2,2),
(3,2),
(3,4);

 */
 select * from Dim;


-- -- select * from DimensionArticle;

-- -- select * from Article A inner join DimensionArticle D on 
-- -- A.idArticle =D.idArticle;

-- -- select  concat('[',D.title,']',A.Name) as Article , idDimension,A.idArticle    from Article A inner join DimensionArticle D on 
-- -- A.idArticle =D.idArticle;

-- select * from Article A inner join DimensionArticle DA inner join Dim D on
-- A.idArticle = DA.idArticle and
-- DA.idDimension = D.idDimension
-- ;

-- select  concat('[',D.Title,']',A.Name) Article , A.idArticle,DA.idDimension , A.Reference from Article A inner join DimensionArticle DA inner join Dim D on
-- A.idArticle = DA.idArticle and
-- DA.idDimension = D.idDimension
-- ;

select * from Article_Dimension;
select * from Article where idArticle = 1;

select A.idArticle,Article,A.SalePrice,A.Cost,A.Reference,BarCode,Title,Name,D.idDimension from Article A join Article_Dimension AD join Dim D on A.idArticle=AD.idArticle and AD.idDimension= D.idDimension and A.idArticle=1 ;

 -- drop view Article_Dimension_deltail;

-- create view Article_Dimension_deltail as 
-- select A.idArticle,Article,A.SalePrice,A.Cost,A.Reference,BarCode,Title,Name,D.idDimension from Article A join Article_Dimension AD join Dim D on A.idArticle=AD.idArticle and AD.idDimension= D.idDimension;

select * from Article_Dimension_deltail where idArticle=1;

-- Article(Name,SalePrice,Cost,Reference) values 
-- ('Pro2',2000,1500,'Pro0001'),
delimiter |
create procedure AddArticle(NameValue text ,SalePriceValue double ,CostValue double ,ReferenceValue text )
begin 
	insert into  Article(Name,SalePrice,Cost,Reference) values (NameValue,SalePriceValue,CostValue,ReferenceValue);
END;






