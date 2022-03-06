use pro;

-- insert into Article_in_Stock(idStock,idArticle,idDimension,Quantity,Lot) values (1,1,1,200,'7322Y2022'),(1,2,2,140,'2333Y2022'),(2,1,1,200,'3232Y2022');

/*
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
*/

-- call AddDim(15,5);



select * from DimensionArticle;


-- delimiter |
-- create procedure DeleteDim(Article int ,Dimension int ) 
-- begin 
-- 	delete from DimensionArticle where idArticle= Article and idDimension = Dimension;
-- END;
-- |

-- call DeleteDim(15,5);


select * from DimensionArticle;

