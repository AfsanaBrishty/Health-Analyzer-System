Create or replace view myview_health_data_site(vw_id,vw_bmi,vw_bmr,vw_bfp) as
Select S1.ins_id,S1.BMI,S1.BMR,S1.BFP
From user_health_info_site S1;
select * from myview_health_data_site;
commit;

Create or replace view myview_diet_chart_site(vw_pid,vw_meal_plan) as
Select S2.Plan_id,S2.Meal_Plan
From diet_chart_table_site S2;
select * from myview_diet_chart_site;
commit;