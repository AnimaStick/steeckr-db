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
drop table if exists "Like" cascade;
/*drop table if exists "Session" cascade;*/

create table "User"(
	"id" serial primary key,
	"username" varchar(30) not null unique,
	"email" varchar(30) not null unique,
	"password" varchar(100) not null,
	birthday date not null,
	"picture_path" varchar(70),
	"description" text,
    "isAdm" boolean not null default false,
    "lastDailyPacket" timestamp not null default '1970-01-01 23:59:00',
	"coins" bigint not null check (coins >= 0) default 0
);

create table "Animation"(
	"id" serial primary key,
	"id_user" int not null,
	"animation_path" varchar(60) not null,
	"title" varchar(30) not null,
	"description" varchar(50),
	"views" bigint not null default 0,
    "creation_date" timestamp not null default now(),
	constraint "fk_user" 
		foreign key("id_user") 
			references "User"("id")
);

create table "Like"(
    "id_user" int not null,
    "id_animation" int not null,
    constraint "fk_user" 
		foreign key("id_user") 
			references "User"("id"),
    constraint "fk_animation" 
		foreign key("id_animation") 
			references "Animation"("id"),
    primary key(id_animation,id_user)	
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
	"id_creator" int not null,
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
	"id_album" int not null,
	"id_category" int not null,
	constraint "fk_album" 
		foreign key("id_album") 
			references "Album"("id"),
	constraint "fk_category" 
		foreign key("id_category") 
			references "Category"("id"),
	primary key(id_category,id_album)
);
create table "Animation_Category"(
	"id_animation" int not null,
	"id_category" int not null,
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
	"id_user" int not null,
	"id_post" int not null,
	"comment" varchar(140),
	constraint "fk_user" 
		foreign key("id_user") 
			references "User"("id"),
	constraint "fk_post" 
		foreign key("id_post")
			references "Post"("id"),
    primary key("id_user", "id_post")
);

/*SESSION TABLE, GUARDA AS SESSÕES PARA UM USUÁRIO SE MANTER LOGADO DURANTE X TEMPO*/
/*
CREATE TABLE "session" (
  "sid" varchar NOT NULL COLLATE "default",
  "sess" json NOT NULL,
  "expire" timestamp(6) NOT NULL
)
WITH (OIDS=FALSE);

ALTER TABLE "session" ADD CONSTRAINT "session_pkey" PRIMARY KEY ("sid") NOT DEFERRABLE INITIALLY IMMEDIATE;

CREATE INDEX "IDX_session_expire" ON "session" ("expire");
*/

