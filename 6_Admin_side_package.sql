SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE HAS_pack2 AS
    FUNCTION Insert_data(Gender diet_chart_table.Gender%TYPE,Name diet_chart_table.Suggested_by%TYPE,Age_range_start diet_chart_table.Age_low%TYPE,Age_Range_end diet_chart_table.Age_up%TYPE,Meal_plan varchar2)
	RETURN NUMBER;
	FUNCTION is_number_pid(p_id IN OUT varchar2)
    RETURN diet_chart_table.Plan_id%TYPE;
	
	PROCEDURE Delete_data(pid_check IN diet_chart_table.Plan_id%TYPE);
	
    PROCEDURE update_gndr(p_id IN varchar2,gndr IN diet_chart_table.Gender%TYPE);
	PROCEDURE update_name(p_id IN varchar2,name IN diet_chart_table.Suggested_by%TYPE);
	PROCEDURE update_age_start(p_id IN varchar2,age_start IN varchar2);
    PROCEDURE update_age_end(p_id IN varchar2,age_end IN varchar2);
	PROCEDURE update_mplan(p_id IN varchar2,m_plan IN varchar2);
	
END HAS_pack2;
/
CREATE OR REPLACE PACKAGE BODY HAS_pack2 AS

    FUNCTION Insert_data(Gender diet_chart_table.Gender%TYPE,Name diet_chart_table.Suggested_by%TYPE,Age_range_start diet_chart_table.Age_low%TYPE,Age_Range_end diet_chart_table.Age_up%TYPE,Meal_plan varchar2)
	RETURN NUMBER
	IS
    C diet_chart_table.Plan_id%TYPE;
    A diet_chart_table.Plan_id%TYPE;
    BEGIN
	   Insert into diet_chart_table 
       values(B_SEQUENCE.nextval,Gender,Name,Age_range_start,Age_Range_end);
       commit;
       FOR R IN (SELECT * FROM diet_chart_table) LOOP
           A := R.Plan_id;
       END LOOP;
       C := A;
	   Insert into diet_chart_table_site@has_mysite
       values(C,Meal_plan);
	   commit;
       Return C;
	END Insert_data;
	
	FUNCTION is_number_pid(p_id IN OUT varchar2)
    RETURN diet_chart_table.Plan_id%TYPE
    IS
    pid_res_num diet_chart_table.Plan_id%TYPE;
    BEGIN
	   pid_res_num := TO_NUMBER(p_id);
	   RETURN pid_res_num;
	   EXCEPTION
	       WHEN OTHERS THEN
		       RETURN 0;
	END is_number_pid;
	
	PROCEDURE Delete_data(pid_check IN diet_chart_table.Plan_id%TYPE)
    IS
    BEGIN
       DELETE FROM diet_chart_table
       WHERE Plan_id = pid_check;
       commit;
	   DELETE FROM diet_chart_table_site@has_mysite
       WHERE Plan_id = pid_check;
       commit;
    END Delete_data;
	
	PROCEDURE update_gndr(p_id IN varchar2,gndr IN diet_chart_table.Gender%TYPE)
    IS
    BEGIN
	    update diet_chart_table set Gender = gndr where Plan_id = p_id;
	    commit;
    END update_gndr;
	
	PROCEDURE update_name(p_id IN varchar2,name IN diet_chart_table.Suggested_by%TYPE)
    IS
    BEGIN
        update diet_chart_table set Suggested_by = name where Plan_id = p_id;
	    commit;
    END update_name;
	
	PROCEDURE update_age_start(p_id IN varchar2,age_start IN varchar2)
    IS
    BEGIN
        update diet_chart_table set Age_low = age_start where Plan_id = p_id;
	    commit;
    END update_age_start;
	
	PROCEDURE update_age_end(p_id IN varchar2,age_end IN varchar2)
    IS
    BEGIN
       update diet_chart_table set Age_up = age_end where Plan_id = p_id;
	   commit;
    END update_age_end;
	
	PROCEDURE update_mplan(p_id IN varchar2,m_plan IN varchar2)
    IS
    BEGIN
       update diet_chart_table_site@has_mysite set Meal_Plan = m_plan where Plan_id = p_id;
	   commit;
    END update_mplan;
	
END HAS_pack2;
/