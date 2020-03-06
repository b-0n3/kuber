CREATE DATABASE userSet;

use userSet;

create table staff (
id int , 
birth_day varchar(100),
birth_place varchar(200),
sex varchar (200),
sit_fam varchar (200),
nationalite varchar(200),
date_embauche varchar(200),
grade varchar(200),
functio_n varchar(200),
post varchar(200),
categorie varchar(200),
echelon int,
ent_effect varchar(200),
regime_retraite varchar(200),
affil_recore int,
date_der_promo varchar(200),
image varchar(200), 
cin varchar(200), 
section_analytique varchar(200),
 CONSTRAINT PK_S PRIMARY KEY (id)
);

CREATE TABLE  admin(
    username varchar(200),
firstname varchar(200),
lastname varchar(200),
phonnumber varchar(200),
birth_day varchar(200),
post varchar(200),
password varchar(500),
salt blob,
image varchar(200),
email varchar(300), 
CONSTRAINT PK PRIMARY KEY (username)
);