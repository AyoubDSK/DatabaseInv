drop database Pro;

create database Pro;

use Pro;
SET SQL_SAFE_UPDATES=0;

create table Article(
idArticle int primary key auto_increment,
Name text,
SalePrice double,
Cost double,
Reference text,
BarCode text,
Archived bool
);
-- set Archived 0

 create trigger AfterInsertArticle BEFORE insert on Article 
 for each row
  set NEW.Archived = 0;

-- Procedure cresate Article 
delimiter |
create procedure AddArticle(NameValue text ,SalePriceValue double ,CostValue double ,ReferenceValue text )
begin 
	insert into  Article(Name,SalePrice,Cost,Reference) values (NameValue,SalePriceValue,CostValue,ReferenceValue);
END;
|

-- Archived Article 
delimiter |
create procedure ArchivedArticle(idArticleValue int)
begin 
	update Article set Archived = 1 where idArticle = idArticleValue;
END;
|

-- modify Article
delimiter |
create procedure ModifyArticle(idArticleValue int ,NameValue  text ,SalePriceValue double ,CostValue double ,ReferenceValue text )
begin 
	
    if NameValue != "" then 
		update Article set Name = NameValue where idArticle = idArticleValue;
    end if;   
    if SalePriceValue != "" then 
		update Article set SalePrice = SalePriceValue where idArticle = idArticleValue;
    end if; 
    if CostValue != "" then 
		update Article set Cost = CostValue where idArticle = idArticleValue;
    end if; 
    if ReferenceValue != "" then 
		update Article set Reference = ReferenceValue where idArticle = idArticleValue;
    end if; 
	
end;
|


create table Dim(
idDimension int auto_increment primary key,
description text,
Title text,
Archived bool);

-- init Dimension 
 insert into Dim(title,description) value ('Default','Default Valule For All Articles');
  
  -- trigger init dimi archived 
  create trigger InsertDim BEFORE insert on Dim 
 for each row
  set NEW.Archived = 0;
  -- add Dimension 
  
  -- add dim
  delimiter |
  create procedure AddDim(titleValue text ,descriptionValue text )
	begin 
	insert into Dim(title,description) value (titleValue,descriptionValue);
	END;
|

-- Archived Dimension

	delimiter |
	create procedure ArchivedDim(idDimensionValue int)
	begin 
		update Dim set Archived = 1 where idDimension = idDimensionValue;
	END;
	|

 -- Modify Dim
 
 delimiter |
create procedure ModifyDim(idDimensionValue int ,TitleValue  text ,descriptionValue text)
begin 
	
    if TitleValue != "" then 
		update Dim set Title = TitleValue where idDimension = idDimensionValue;
    end if;   
    if descriptionValue != "" then 
		update Dim set description = descriptionValue where idDimension = idDimensionValue;
    end if; 
   
	
end;
|

create table DimensionArticle(
idArticle int ,
idDimension int,
primary key(idDimension,idArticle),
constraint FK_Dim_Art foreign key (idArticle) references Article(idArticle),
constraint FK_Dim_Dim foreign key (idDimension) references Dim(idDimension)
);

-- inti Article with Default Dim 


delimiter |
create trigger InitDimArticle after insert on Article
for each row
 begin
	insert into DimensionArticle(idArticle,idDimension) value (NEW.idArticle,1);
 End;
 
 |
 
 
 -- insert dim for Article 
 
 delimiter |
create procedure AddDim(Article int ,Dimension int )
begin
declare inited int; 
	select idDimension into inited from DimensionArticle where idArticle = Article limit 0,1;
    
    if inited = 1 then 
		update DimensionArticle set idDimension = Dimension where idArticle = Article;
    else
		insert into DimensionArticle(idArticle,idDimension) value (Article,Dimension);
    END IF;
END;

|

-- delete Dim from Article 


delimiter |
create procedure DeleteDim(Article int ,Dimension int ) 
begin 
	delete from DimensionArticle where idArticle= Article and idDimension = Dimension;
END;

|



create table Actor(
idActor int primary key auto_increment,
Name text,
Reference text,
LocalStock bool,
Archived bool
);



create table Stock(
	idStock int primary key auto_increment,
	Name text,
	idActor int,
	Reference text,
	constraint FK_Stock_Actor foreign key (idActor) references Actor(idActor),
    Archived bool

);


-- init Archived stock 

create trigger init_Stock before insert on stock 
for each row
	set NEW.Archived=0;


 -- create Actor for Stock
delimiter |
create trigger Relate_Actor_Stock after insert on Actor 
for each row
begin
	if NEW.LocalStock = 1 then 
		update Stock set idActor = NEW.idActor where Name= NEW.Name and Reference= NEW.Reference;
        END if;
END;

|


-- procedure to create stock derectly 

drop procedure CreateStock;

DELIMITER |
create procedure CreateStock(Name text,Reference text)
begin
	insert into Stock (Name,Reference) value(Name,Reference);
 insert into Actor(Name,Reference,LocalStock) value
 (Name,Reference,true);

end;
|

create table Article_in_Stock(
	idStock int,
	idArticle int,
    idDimension int,
	Quantity long,
	Lot text,
	primary key(idStock,idArticle),
	constraint FK_AIS_Article foreign key (idArticle) references Article(idArticle),
	constraint FK_AIS_Stock foreign key (idStock) references Stock(idStock),
    constraint FK_AIS_Dimension foreign key (idDimension) references Dim(idDimension)
);


create table TypeOperation(
	idType int primary key auto_increment,
	Title text,
    idActorshipper int,
    idActorReceipt int,
    constraint FK_Tr_Actor_shipper foreign key (idActorshipper) references Actor(idActor),
	constraint FK_Tr_Actors foreign key (idActorReceipt) references Actor(idActor)
);

create table TypeOperationSaved(
idTOS int auto_increment primary key ,
idType int ,
TitleSaved text,
Archived bool,
constraint FK_TOS_TO foreign key (idType) references TypeOperation(idType)
);


create table Operation(
	idOperation int primary key auto_increment,
	idType int,
	Title text,
	DateOp datetime,
	constraint FK_OPTYPE foreign key (idType) references TypeOperation(idType)
);




create table OperationList(
	idOperation int,
	idOpAr int primary key auto_increment,
	
	Note text,
    constraint FK_OpList_Operation foreign key (idOperation) references Operation(idOperation)
    
);


create table OperationArticle(
	idArticle int ,
	idOpAr int,
    idDimension int,
	Quantity int,
    primary key(idOpAr,idArticle),
    constraint FK_OA_Article foreign key (idArticle) references Article(idArticle),
    constraint FK_OA_OpAr foreign key (idOpAr) references OperationList(idOpAr),
     constraint FK_OpAr_Dimension foreign key (idDimension) references Dim(idDimension)
);

-- view to see all Article with dimension
create view Article_Dimension as select  concat('[',D.title,']',A.Name) Article , A.idArticle,DA.idDimension , A.Reference from Article A inner join DimensionArticle DA inner join Dim D on
A.idArticle = DA.idArticle and
DA.idDimension = D.idDimension;

-- view to see All Detail about Article and his Dimenssion 
create view Article_Dimension_deltail as 
select A.idArticle,Article,A.SalePrice,A.Cost,A.Reference,BarCode,Title,Name,D.idDimension from Article A join Article_Dimension AD join Dim D on A.idArticle=AD.idArticle and AD.idDimension= D.idDimension;

-- view Quantity of articles with dimension
 create view Article_in_stock_With_Dimesion as
 select Quantity , AIS.idArticle,AIS.idDimension,D.Title,A.Name as Article,A.Reference as ArticleReference , Lot , S.Name as Stock,S.idActor as StockActor,S.Reference as StockReference 
 from Article_in_Stock AIS inner join Stock S inner join Article A inner join Dim D on  AIS.idStock= S.idStock and AIS.idArticle= A.idArticle and AIS.idDimension= D.idDimension;

-- view Quantity of article sum of dim

 create view Quantity_Article_in_Stock as
 select sum(Quantity) as Quantity , idArticle,Title,Article,ArticleReference,Lot,Stock,StockActor,StockReference from Article_in_stock_With_Dimesion group by idArticle;

-- Dash All Article with group by idArticle ..  quantity  
create view DashArticle_Quantity as
select A.idArticle,Name,SalePrice,Cost,Reference,Quantity from Article A inner join Quantity_Article_in_Stock QAS on A.idArticle= QAS.idArticle; 

-- view to see actor (fournisseur, client)
create view Actor_External as select idActor,Name,Reference  from Actor where LocalStock = false;

-- view ro see stock actor in Operation
create view Actor_Stock as select idActor,Name,Reference from Actor where LocalStock = true;

-- view to see all shipper in type operation
create view TypeOperationShipper as 
select *  from TypeOperation T join Actor A on T.idActorshipper = A.idActor  group by  idActorshipper;

-- view to see all Receipt
create view TypeOperationReceipt as 
select * from TypeOperation T join Actor A on T.idActorReceipt = A.idActor  group by  idActorReceipt;

create view TypeOperationActor as
select TOP.idType,TOP.Title,TOP.idActorshipper,TOP.Name as NameShipper,TOP.Reference as ReferenceShipper,TOR.idActorReceipt,TOP.Name as NameReceipt,TOR.Reference as ReferenceReceipt from TypeOperationShipper TOP inner join TypeOperationReceipt TOR on TOP.idType=TOR.idType;

