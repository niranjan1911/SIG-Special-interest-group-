//triggers

delimiter//
create trigger post_del 
after delete on post
for each row
begin
	delete from comment where post_id=OLD.post_id;
end//
delimiter ;


//triggers

delimiter//
create trigger question_del 
after delete on questions
for each row
begin
	delete from answers where question_id=OLD.question_id;
end//
delimiter ;
