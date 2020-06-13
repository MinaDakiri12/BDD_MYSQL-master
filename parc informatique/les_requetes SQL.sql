create database park_info;
use park_info;

create table typelp(
typelp varchar(9) primary key,
nomtype varchar(20))ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE salle (
  nsalle varchar(7) NOT NULL,
  nom_salle varchar(20) NOT NULL,
  nbposte tinyint(2) DEFAULT NULL,
  indip varchar(11) DEFAULT NULL,
  PRIMARY KEY (nsalle)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE poste (
  nposte varchar(7) NOT NULL,
  nom_poste varchar(20) NOT NULL,
  indip varchar(11) DEFAULT NULL,
  ad varchar(3) DEFAULT NULL,
  type_poste varchar(9) DEFAULT NULL,
  nsalle varchar(7) DEFAULT NULL,
  PRIMARY KEY (nposte)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE segment (
  indip varchar(11) NOT NULL,
  nom_segment varchar(20) DEFAULT NULL,
  etage tinyint(1) DEFAULT NULL,
  PRIMARY KEY (indip)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE logiciel (
  nlog varchar(5) NOT NULL,
  nomlog varchar(20) NOT NULL,
  dateach datetime DEFAULT NULL,
  version varchar(7) DEFAULT NULL,
  typelog varchar(9) DEFAULT NULL,
  prix decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (nlog)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE installation (
  nposte varchar(7) DEFAULT NULL,
  nlog varchar(5) DEFAULT NULL,
  num_ins int(5) NOT NULL AUTO_INCREMENT,
  date_ins timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  delai decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (num_ins)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;


INSERT INTO installation VALUES ('p2','log1',1,'2003-05-15 00:00:00',NULL),
('p2','log2',2,'2003-09-16 23:00:00',NULL),
('p4','log5',3,NULL,NULL),
('p6','log6',4,'2003-05-20 00:00:00',NULL),
('p6','log1',5,'2003-05-20 00:00:00',NULL),
('p8','log2',6,'2003-05-19 00:00:00',NULL),
('p8','log6',7,'2003-05-20 00:00:00',NULL),
('p11','log3',8,'2003-04-19 23:00:00',NULL),
('p12','log4',9,'2003-04-19 23:00:00',NULL),
('p11','log7',10,'2003-04-19 23:00:00',NULL),
('p7','log7',11,'2002-03-31 23:00:00',NULL);
select*from installation

INSERT INTO logiciel VALUES ('log1','Oracle 6','1995-05-13 00:00:00','6.2','UNIX',3000.00),
('log2','Oracle 8','1999-09-15 00:00:00','8i','UNIX',5600.00),
('log3','SQL Server','1998-04-12 00:00:00','7','PCNT',3000.00),
('log4','Front Page','1997-06-03 00:00:00','5','PCWS',500.00),
('log5','WinDev','1997-05-12 00:00:00','5','PCWS',750.00),
('log6','SQL*Net',NULL,'2.0','UNIX',500.00),
('log7','I. I. S.','2002-04-12 00:00:00','2','PCNT',900.00),
('log8','DreamWeaver','2003-09-21 00:00:00','2.0','BeOS',1400.00);
select*from logiciel

INSERT INTO poste VALUES ('p1','Poste 1','130.120.80','01','TX','s01'),
('p2','Poste 2','130.120.80','02','UNIX','s01'),
('p3','Poste 3','130.120.80','03','TX','s01'),
('p4','Poste 4','130.120.80','04','PCWS','s02'),
('p5','Poste 5','130.120.80','05','PCWS','s02'),
('p6','Poste 6','130.120.80','06','UNIX','s03'),
('p7','Poste 7','130.120.80','07','TX','s03'),
('p8','Poste 8','130.120.81','01','UNIX','s11'),
('p9','Poste 9','130.120.81','02','TX','s11'),
('p10','Poste 10','130.120.81','03','UNIX','s12'),
('p11','Poste 11','130.120.82','01','PCNT','s21'),
('p12','Poste 12','130.120.82','02','PCWS','s21');
select*from poste


INSERT INTO salle  VALUES ('s01','Salle 1',3,'130.120.80'),
('s02','Salle 2',2,'130.120.80'),
('s03','Salle 3',2,'130.120.80'),
('s11','Salle 11',2,'130.120.81'),
('s12','Salle 12',1,'130.120.81'),
('s21','Salle 21',2,'130.120.82'),
('s22','Salle 22',0,'130.120.83'),
('s23','Salle 23',0,'130.120.83');
select*from salle


INSERT INTO segment VALUES ('130.120.80','Brin RDC',NULL),
('130.120.81','Brin 1er	étage',NULL),
('130.120.82','Brin 2ème étage',NULL);
select*from segment

INSERT INTO typelp VALUES ('TX','Terminal X-Window'),
('UNIX','Système Unix'),
('PCNT','PC Windows NT'),
('PCWS','PC Windows'),
('NC','Network Computer');
select*from typelp

update segment set etage=0 where  indip='130.120.80';
update segment set etage=1 where  indip='130.120.81';
update segment set etage=2 where  indip='130.120.82';
select*from segment

update logiciel set prix=prix*0.9 where typelog='PNCT'
select nlog,typelog,prix from logiciel where typelog='PCNT';

alter table segment 
add(nbsalle int(2) default 0, nbposte int(2) default 0);
select *from segment

alter table logiciel 
add nbinstall int(2) default 0;
select *from logiciel


alter table poste
add nblog int(2) default 0;
select *from poste;



alter table salle modify nom_salle varchar(30);
desc salle;


alter table segment modify nom_segment varchar(15);
desc segment;

select *from installation;

ALTER TABLE  installation ADD CONSTRAINT UNIQUE(nposte,nlog);

ALTER TABLE poste ADD CONSTRAINT fk_poste_indip foreign key(indip) references segment(indip);
ALTER TABLE poste ADD CONSTRAINT fk_poste_salle foreign key(nsalle) references salle(nsalle);
ALTER TABLE poste ADD CONSTRAINT fk_poste_type foreign key(type_poste) references typelp(typelp);
ALTER TABLE installation ADD CONSTRAINT fk_poste_inst FOREIGN KEY(nposte) REFERENCES poste(nposte);
ALTER TABLE installation ADD CONSTRAINT fk_logiciel_int FOREIGN KEY(nlog) REFERENCES logiciel(nlog);
ALTER TABLE logiciel ADD CONSTRAINT fk_log_type FOREIGN KEY(typelog) REFERENCES typelp(typelp)

select nlog,typelog from logiciel where typelog NOT IN(SELECT typelp from typelp)
insert into typelp values('BeOS','System be');

alter table salle add constraint fk_segment foreign key(indip) references segment(indip);
delete from salle where indip not in(select indip from segment);

create table softs AS SELECT nomlog,version,prix from logiciel;
select *from softs;

alter table softs change nomlog nomsoft varchar(20);
desc softs;

create table pcseuls as select nposte,nom_poste,indip,ad,type_poste,nsalle from poste 
where type_poste='PCNT' OR type_poste='PCWS';
select *from pcseuls ;

ALTER TABLE pcseuls CHANGE nposte np VARCHAR(7);
ALTER TABLE pcseuls CHANGE nom_poste nomP VARCHAR(20);
ALTER TABLE pcseuls CHANGE indip seg VARCHAR(11);
ALTER TABLE pcseuls CHANGE type_poste typeP VARCHAR(9);
ALTER TABLE pcseuls CHANGE nsalle lieu VARCHAR(9); 
desc pcseuls

select nposte,type_poste from poste where nposte='P8';

select nomlog from logiciel where typelog='UNIX';

select nom_poste,indip,ad,nsalle from poste where type_poste='UNIX' or type_poste='PCWS';

select nom_poste,indip,ad,nsalle,type_poste from poste 
where indip='130.120.80' order by nsalle desc;

select nlog from installation where nposte='P6';

select nposte from installation where nlog='log1';

select nom_poste,CONCAT(indip,'.',ad) as adresse_ip from poste where type_poste='TX';

select nposte,count(nlog) as nbr_logiciel from installation group by nposte;

SELECT nsalle, COUNT(nposte) FROM poste GROUP BY (nsalle) ORDER BY 2;

SELECT nlog, COUNT(nposte) FROM installation GROUP BY (nlog);

SELECT AVG(prix) FROM logiciel WHERE typelog = 'UNIX';

SELECT MAX(dateach) FROM logiciel;

SELECT nposte FROM installation GROUP BY nposte HAVING COUNT(nlog)=2;

SELECT CONCAT(indip,'.',ad) FROM poste p, installation i
 WHERE p.nposte = i.nposte AND i.nlog = 'log6'; 

SELECT CONCAT(indip,'.',ad) FROM poste
 WHERE nposte IN
 (SELECT nposte FROM installation WHERE nlog = 'log6'); 


SELECT nom_segment FROM segment
 WHERE indip IN (SELECT indip FROM Poste WHERE type_poste = 'TX'
 GROUP BY indip HAVING COUNT(*)=3); 

SELECT nom_salle FROM salle WHERE nsalle IN
 (SELECT nsalle FROM poste WHERE nposte IN
 (SELECT nposte FROM installation WHERE nlog =
 (SELECT nlog FROM logiciel WHERE nomlog = 'Oracle 6'))); 
 
 SELECT nomlog FROM Logiciel WHERE dateach =
 (SELECT MAX(dateach) FROM logiciel); 
 
 






















