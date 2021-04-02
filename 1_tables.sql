clear screen;
drop table sys_user cascade constraints;
drop table user_health_info cascade constraints;
drop table bmi_chart_table;
drop table body_fat_chart_table;
drop table bmr_chart_table;
drop table diet_chart_table;
drop table diet_chart_table_old_data;
drop SEQUENCE A_SEQUENCE;
drop SEQUENCE B_SEQUENCE;
	
create table sys_user(
ins_id number,
Gender varchar2(10) NOT NULL,
Weight number NOT NULL, 
Age number NOT NULL, 
Height number NOT NULL,
PRIMARY KEY (ins_id)
);
CREATE SEQUENCE A_SEQUENCE START WITH 1 INCREMENT BY 1;
create table user_health_info(
ins_id number, 
BMI number,
BMR number,
BFP number,
FOREIGN KEY(ins_id) REFERENCES sys_user(ins_id)
);
create table bmi_chart_table(
Gender varchar2(10) NOT NULL,
Undrwt_up number NOT NULL,
Normalwt_low number NOT NULL,
Normalwt_up number NOT NULL,
OverWeight_low number NOT NULL,
OverWeight_up number NOT NULL,
Obese_low number NOT NULL,
Obese_up number NOT NULL,
ExtremeObese number NOT NULL
);
insert into bmi_chart_table values('male',18.4,18.5,24.9,25,29.9,30,34.9,35);
insert into bmi_chart_table values('female',18.4,18.5,24.9,25,29.9,30,34.9,35);

create table body_fat_chart_table(
Gender varchar2(10) NOT NULL,
Age_low number NOT NULL,
Age_up number NOT NULL,
Healthy_low number NOT NULL,
Healthy_up number NOT NULL,
OverWeight_up number NOT NULL
);
insert into body_fat_chart_table values('female',20,40,21,33,39);
insert into body_fat_chart_table values('female',41,60,23,35,40);
insert into body_fat_chart_table values('female',61,79,24,36,42);
insert into body_fat_chart_table values('male',20,40,8,19,25);
insert into body_fat_chart_table values('male',41,60,11,22,27);
insert into body_fat_chart_table values('male',61,79,13,25,30);

create table bmr_chart_table(
Gender varchar2(10) NOT NULL,
Height number NOT NULL,
BMR_low number NOT NULL,
BMR_up number NOT NULL
);
insert into bmr_chart_table values('male',162.56,1200,1600);
insert into bmr_chart_table values('male',165.1,1275,1685);
insert into bmr_chart_table values('male',167.64,1340,1750);
insert into bmr_chart_table values('male',170.18,1410,1820);
insert into bmr_chart_table values('male',172.72,1480,1890);
insert into bmr_chart_table values('male',175.26,1550,1960);
insert into bmr_chart_table values('male',177.8,1615,2030);
insert into bmr_chart_table values('male',180.34,1685,2095);
insert into bmr_chart_table values('male',182.88,1750,2165);
insert into bmr_chart_table values('male',185.42,1820,2235);
insert into bmr_chart_table values('male',187.96,1890,2300);
insert into bmr_chart_table values('male',190.5,1960,2370);
insert into bmr_chart_table values('male',193.04,2030,2440);

insert into bmr_chart_table values('female',154.94,1120,1350);
insert into bmr_chart_table values('female',157.48,1135,1370);
insert into bmr_chart_table values('female',160.02,1155,1390);
insert into bmr_chart_table values('female',162.56,1195,1430);
insert into bmr_chart_table values('female',165.1,1235,1470);
insert into bmr_chart_table values('female',167.64,1270,1500);
insert into bmr_chart_table values('female',170.18,1310,1550);
insert into bmr_chart_table values('female',172.72,1350,1585);
insert into bmr_chart_table values('female',175.26,1370,1600);
insert into bmr_chart_table values('female',177.8,1410,1650);
insert into bmr_chart_table values('female',180.34,1450,1685);

CREATE SEQUENCE B_SEQUENCE START WITH 3 INCREMENT BY 1;

create table diet_chart_table(
Plan_id number NOT NULL,
Gender varchar2(30) NOT NULL,
Suggested_by varchar2(30) NOT NULL,
Age_low number NOT NULL,
Age_up number NOT NULL,
PRIMARY KEY (Plan_id)
);


create table diet_chart_table_old_data(
Plan_id number NOT NULL,
Gender varchar2(30) NOT NULL,
Suggested_by varchar2(30) NOT NULL,
Age_low number NOT NULL,
Age_up number NOT NULL,
PRIMARY KEY (Plan_id)
);

insert into diet_chart_table values(1,'male','Dr.MORGAN FARGO',19,50);
insert into diet_chart_table values(2,'female','Dr.MORGAN FARGO',19,50);

commit;
select * from sys_user;
select * from user_health_info;
select * from bmi_chart_table;
select * from body_fat_chart_table;
select * from bmr_chart_table;