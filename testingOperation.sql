use Pro;

/* inset new TypeOperation

insert into TypeOperation(Title,idActorshipper,idActorReceipt) values ('Action0001',3,2), ('Actionintern001',2,1);
*/
select * from TypeOperation;

/*
insert into TOS
*/
-- insert into TypeOperationSaved(idType,TitleSaved) values (2,'Garage 1 -> Garage 2');

select * from Operation;

-- idType,Title,idActorshipper as idActorShipper,idActorReceipt,Name,Reference
select * from TypeOperationShipper;
-- idType,Title,idActorReceipt as idActorReceipt,idActorshipper,Name,Reference
select * from TypeOperationReceipt;

create view TypeOperationActor as
select TOP.idType,TOP.Title,TOP.idActorshipper,TOP.Name as NameShipper,TOP.Reference as ReferenceShipper,TOR.idActorReceipt,TOP.Name as NameReceipt,TOR.Reference as ReferenceReceipt from TypeOperationShipper TOP inner join TypeOperationReceipt TOR on TOP.idType=TOR.idType;

