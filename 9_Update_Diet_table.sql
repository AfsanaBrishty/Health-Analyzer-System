clear screen;
SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
	p_id varchar2(100) := '&Enter_PlanID';
	gndr diet_chart_table.Gender%TYPE := '&Enter_Gender_or_write_no';
	name diet_chart_table.Suggested_by%TYPE := '&New_name_or_write_no';
	age_start varchar2(100) := '&New_Starting_age_or_write_0';
	age_end varchar2(100) := '&New_Ending_age_or_write_0';
	m_plan varchar2(1000) := '&New_Meal_plan_or_write_no';
	A diet_chart_table.Plan_id%TYPE;
	flg NUMBER;
	flg_g NUMBER;
	flg1 NUMBER;
	flg2 NUMBER;
	flg3 NUMBER;
	flg4 NUMBER;
	flg5 NUMBER;
	wrong_pid_excp1 EXCEPTION;
	wrong_pid_excp2 EXCEPTION;
	wrong_gender_excp EXCEPTION;
	wrong_name_excp EXCEPTION;
	wrong_agestrt_excp EXCEPTION;
	wrong_agend_excp EXCEPTION;
	wrong_mplan_excp EXCEPTION;
BEGIN
    flg := 0;
	flg_g := 0;
    flg1 := 0;
	flg2 := 0;
	flg3 := 0;
	flg4 := 0;
	flg5 := 0;
	
	IF regexp_like(p_id, '^[^a-zA-Z]*$') THEN 	
		flg := 1;
	ELSE
	    RAISE wrong_pid_excp1;
	END IF;
	
	IF flg = 1 THEN
	    FOR R IN (SELECT * FROM diet_chart_table) LOOP
	        A := R.Plan_id;
	        IF A = p_id THEN
	           flg_g := 1;
	        END IF;
	    END LOOP;
		IF flg_g = 0 THEN
		   RAISE wrong_pid_excp2;
		END IF;
	END IF;
	
	
    IF gndr != 'no' and (gndr = 'male' or gndr = 'female') THEN
	    flg1 := 1; 
    ELSIF gndr = 'no' THEN
        DBMS_OUTPUT.PUT_LINE('You have selected not to update gender');	
	ELSE
	   RAISE wrong_gender_excp;
	END IF;
	
	IF name != 'no' and regexp_like(name, '^[^0-9]*$')  THEN
	    flg2 := 1; 
    ELSIF name = 'no' THEN
	    DBMS_OUTPUT.PUT_LINE('You have selected not to update name');
    ELSE
	   RAISE wrong_name_excp;		
	END IF;
	
	IF age_start != 0 and regexp_like(age_start, '^[^a-zA-Z]*$') and age_start < age_end  THEN
	    flg3 := 1; 
    ELSIF age_start = 0	THEN
     	DBMS_OUTPUT.PUT_LINE('You have selected not to update starting age');
    ELSE
	   RAISE wrong_agestrt_excp;
	END IF;
	
	IF age_end != 0 and regexp_like(age_end, '^[^a-zA-Z]*$') and age_end > age_start  THEN
	    flg4 := 1;  
	ELSIF age_end = 0 THEN
	    DBMS_OUTPUT.PUT_LINE('You have selected not to update ending age'); 
    ELSE
	   RAISE wrong_agend_excp;
	END IF;
	
	IF m_plan != 'no' THEN
	    flg5 := 1; 
    ELSIF m_plan = 'no' THEN
	    DBMS_OUTPUT.PUT_LINE('You have selected not to update meal plan'); 
	ELSE
	   RAISE wrong_mplan_excp;
	END IF;
	
	IF flg1 = 1 THEN
	   HAS_pack2.update_gndr(p_id,gndr);
	END IF;
	IF flg2 = 1 THEN
	   HAS_pack2.update_name(p_id,name);
	END IF;
	IF flg3 = 1 THEN
	   HAS_pack2.update_age_start(p_id,age_start);
	END IF;
	IF flg4 = 1 THEN
	   HAS_pack2.update_age_end(p_id,age_end);
	END IF;
	IF flg5 = 1 THEN
	   HAS_pack2.update_mplan(p_id,m_plan);
	END IF;
	
EXCEPTION
    WHEN wrong_pid_excp1 THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   DBMS_OUTPUT.PUT_LINE('Write plan id appropriately..');
	WHEN wrong_pid_excp2 THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   DBMS_OUTPUT.PUT_LINE('No row having this plan id');
    WHEN wrong_gender_excp THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   DBMS_OUTPUT.PUT_LINE('Write male or female or no appropriately..');
	WHEN wrong_name_excp THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   DBMS_OUTPUT.PUT_LINE('Please write for name or no properly!!');
	WHEN wrong_agestrt_excp THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));  
	   DBMS_OUTPUT.PUT_LINE('Please write for starting age properly!!');
	WHEN wrong_agend_excp THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));   
	   DBMS_OUTPUT.PUT_LINE('Please write for ending age properly!!');
	WHEN wrong_mplan_excp THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));   
	   DBMS_OUTPUT.PUT_LINE('Please write for meal plan properly!!');
	WHEN OTHERS THEN 
       DBMS_OUTPUT.PUT_LINE('Something else is making an error');
END;
/