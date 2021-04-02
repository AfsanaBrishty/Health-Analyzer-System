Create or replace view myview_user(vw_id,vw_class,vw_wt,vw_ag,vw_ht) as
Select S1.ins_id,S1.Gender,S1.Weight,S1.Age,S1.Height
From sys_user S1;

Select * From myview_user;
commit;

Create or replace view myview_health_data(vw_id,vw_bmi,vw_bmr,vw_bfp) as
Select S2.ins_id,S2.BMI,S2.BMR,S2.BFP
From user_health_info S2;

Select * From myview_health_data;
commit;

Create or replace view myview_diet_chart(vw_pid,vw_gender,vw_name,vw_start_age,vw_end_age) as
Select S3.Plan_id,S3.Gender,S3.Suggested_by,S3.Age_low,S3.Age_up
From diet_chart_table S3;

Select * From myview_diet_chart;
commit;

