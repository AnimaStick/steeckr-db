create table "User"(
	"id" serial primary key,
	"username" varchar(30) unique,
	"email" varchar(30) unique,
	"password" varchar(30),
	birthday date,
	"picture_path" varchar(50),
	"description" text,
	"coins" bigint check (coins >= 0)
);

create table "Animation"(
	"id" serial primary key,
	"animation_path" varchar(50),
	"title" varchar(30),
	"description" varchar(50)
);

create table "Follow"(
	"id" serial primary key,
	"id_follower" int,
	"id_followed" int,
	foreign key("id_follower") references "User"("id"),
	foreign key("id_follower") references "User"("id")		
);

create table "Sticker"(
	"price" bigint,
	"rarity" bigint
)

