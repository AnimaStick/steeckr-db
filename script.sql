drop table if exists "Album" cascade;
drop table if exists "Album_Category" cascade;
drop table if exists "Animation" cascade;
drop table if exists "Animation_Category" cascade;
drop table if exists "Category" cascade;
drop table if exists "Comment" cascade;
drop table if exists "Follow" cascade;
drop table if exists "Post" cascade;
drop table if exists "Sticker" cascade;
drop table if exists "User" cascade;

create table "User"(
	"id" serial primary key,
	"username" varchar(30) not null unique,
	"email" varchar(30) not null unique,
	"password" varchar(100) not null,
	birthday date not null,
	"picture_path" varchar(70),
	"description" text,
	"coins" bigint not null check (coins >= 0) default 0
);

create table "Animation"(
	"id" serial primary key,
	"animation_path" varchar(50) not null,
	"title" varchar(30) not null,
	"description" varchar(50),
	"likes" int not null, 
	"views" bigint not null
);

create table "Follow"(
	"id_follower" int not null,
	"id_followed" int not null,
	constraint "fk_follower" 
		foreign key("id_follower") 
			references "User"("id"),
	constraint "fk_followed" 
		foreign key("id_followed") 
			references "User"("id")		
);
create table "Album"(
	"id" serial primary key,
	"id_creator" int,
	"sticker_qtd" smallint,
	"nome" varchar(50) not null,
	"creation_date" date not null,
	"description" varchar(255) not null,
	constraint "fk_creator" 
		foreign key("id_creator") 
			references "User"("id")		
);
create table "Sticker"(
	"price" int not null,
	"rarity" smallint not null default 5
) inherits ("Animation");

create table "Category"(
	"id" int primary key,
	"name" varchar(20)
);
create table "Album_Category"(
	"id_album" int,
	"id_category" int,
	constraint "fk_album" 
		foreign key("id_album") 
			references "Album"("id"),
	constraint "fk_category" 
		foreign key("id_category") 
			references "Category"("id")
);
create table "Animation_Category"(
	"id_animation" int,
	"id_category" int,
	constraint "fk_animation" 
		foreign key("id_animation") 
			references "Animation"("id"),
	constraint "fk_category" 
		foreign key("id_category") 
			references "Category"("id")
);

create table "Post"(
	"id" int primary key, 
	"id_animation" int,
	"data_inclusao" date,
	constraint "fk_animation" 
		foreign key("id_animation") 
			references "Animation"("id")
);
create table "Comment"(
	"id" int primary key, 
	"id_user" int,
	"id_post" int,
	"comment" varchar(140),
	constraint "fk_user" 
		foreign key("id_user") 
			references "User"("id"),
	constraint "fk_post" 
		foreign key("id_post")
			references "Post"("id")
);


