use my_website;
create table apis(
        id int not null auto_increment primary key,
        message varchar(255)
);
insert into apis(message) values('Hello World');