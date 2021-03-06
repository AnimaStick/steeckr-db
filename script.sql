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
drop table if exists "User_Animation" cascade;
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
	"animation_path" varchar(200) not null,
	"title" varchar(30) not null,
	"description" varchar(50),
	"views" bigint not null default 0,
    "creation_date" timestamp not null default now(),
	constraint "fk_user" 
		foreign key("id_user") 
			references "User"("id") on delete cascade,
    "price" int default null,
    "rarity" int default null
);

create table "Like"(
    "id_user" int not null,
    "id_animation" int not null,
    constraint "fk_user" 
		foreign key("id_user") 
			references "User"("id") on delete set null,
    constraint "fk_animation" 
		foreign key("id_animation") 
			references "Animation"("id") on delete cascade,
    primary key(id_animation,id_user)	
);

create table "User_Animation"(
    "id_user" int not null,
    "id_animation" int not null,
	"quantity" int default 1,
    constraint "fk_user" 
		foreign key("id_user") 
			references "User"("id") on delete cascade,
    constraint "fk_animation" 
		foreign key("id_animation") 
			references "Animation"("id") on delete cascade,
    primary key(id_animation,id_user)	
);

create table "Follow"(
	"id_follower" int not null,
	"id_followed" int not null,
	constraint "fk_follower" 
		foreign key("id_follower") 
			references "User"("id") on delete cascade,
	constraint "fk_followed" 
		foreign key("id_followed") 
			references "User"("id") on delete cascade		
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
			references "User"("id") on delete cascade		
);

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
create table "Comment"(
	"id_user" int,
	"id_animation" int not null,
	"comment" varchar(140),
	constraint "fk_user" 
		foreign key("id_user") 
			references "User"("id") on delete set null,
	constraint "fk_animation" 
		foreign key("id_animation")
			references "Animation"("id") on delete cascade
);

/* ANIMATIONS INSERT EXAMPLES */
/*insert into "Animation"(id_user, animation_path, title, description, "views") values
(1, 'https://mir-s3-cdn-cf.behance.net/project_modules/disp/4c1f1384533141.5d5fa79310f29.gif','anim1','dan??a marota', 1200),
(1, 'https://user-images.githubusercontent.com/50672087/107100571-290c1300-6858-11eb-919d-87b65633a43f.gif','anim2','oie :D', 1300),
(1, 'https://user-images.githubusercontent.com/50672087/107100571-290c1300-6858-11eb-919d-87b65633a43f.gif','anim2','oie :D', 1300),
(1, 'https://images.squarespace-cdn.com/content/v1/5876be053e00be4f63b6796c/1521584987912-ZV7AYJW1BPLS4P4RVRQH/Pumpum-crying.gif','anim3','triste boneco andando cora????o ;-;', 1400),
(1, 'https://pa1.narvii.com/6506/d431ed2ace9b0793a604e5dffa4c3e2f2962aece_hq.gif','animSonic','classic sonic running high-resolution pixel art', 5000),
(1, 'https://3.bp.blogspot.com/-XLIyhaTXJ8A/WZRFGpXtzFI/AAAAAAAAKM0/wZSKyitzqsMLCnaiqTkGVnFf1lVkdG0qQCLcBGAs/s640/dfaa6728122f430aff97ca6741ca3d3c1b99c2b1_hq.gif','anim29','sonic movements animation', 4920),
(1, 'https://user-images.githubusercontent.com/50672087/107100571-290c1300-6858-11eb-919d-87b65633a43f.gif','anim2','oie :D', 1300),
(1, 'https://user-images.githubusercontent.com/50672087/107100571-290c1300-6858-11eb-919d-87b65633a43f.gif','anim2','oie :D', 1300),
(1, 'https://user-images.githubusercontent.com/50672087/107100571-290c1300-6858-11eb-919d-87b65633a43f.gif','anim2','oie :D', 1300),
(1, 'https://user-images.githubusercontent.com/50672087/107100571-290c1300-6858-11eb-919d-87b65633a43f.gif','anim2','oie :D', 1300),
(1, 'https://user-images.githubusercontent.com/50672087/107100571-290c1300-6858-11eb-919d-87b65633a43f.gif','anim2','oie :D', 1300),
(1, 'https://user-images.githubusercontent.com/50672087/107100571-290c1300-6858-11eb-919d-87b65633a43f.gif','anim2','oie :D', 1300),
(1, 'https://user-images.githubusercontent.com/50672087/107100571-290c1300-6858-11eb-919d-87b65633a43f.gif','anim2','oie :D', 1300)
*/
/*SESSION TABLE, GUARDA AS SESS??ES PARA UM USU??RIO SE MANTER LOGADO DURANTE X TEMPO*/
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

