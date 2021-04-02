SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE HAS_pack AS
    PROCEDURE m_plan_proc(p_id IN diet_chart_table.Plan_id%TYPE,suggby2 IN diet_chart_table.Suggested_by%TYPE);
    PROCEDURE bmi_suggestion(G1 IN sys_user.Gender%TYPE,C IN number);
    PROCEDURE bfp_suggestion(G1 IN sys_user.Gender%TYPE,A1 IN sys_user.Age%TYPE,C IN number);
    PROCEDURE bmr_suggestion(G1 IN sys_user.Gender%TYPE,H1 IN sys_user.Height%TYPE,C IN number);
	PROCEDURE healthy_meal_plan(Gender IN sys_user.Gender%TYPE,age_check IN sys_user.Age%TYPE);
	
	FUNCTION is_number_wt(Weight in out varchar2)
	RETURN sys_user.Weight%TYPE;
	FUNCTION is_number_age(Age in out varchar2)
	RETURN sys_user.Age%TYPE;
	FUNCTION is_number_ht(Height in out varchar2)
	RETURN sys_user.Height%TYPE;
	FUNCTION func_user_info_insert(Gender IN sys_user.Gender%TYPE,Weight IN sys_user.Weight%TYPE,Age IN sys_user.Age%TYPE,Height IN sys_user.Height%TYPE)
	RETURN sys_user.ins_id%TYPE;
	FUNCTION  bmi(usr_id IN sys_user.ins_id%TYPE)
    RETURN NUMBER;
	FUNCTION bmr(usr_id IN sys_user.ins_id%TYPE)
    RETURN NUMBER;
	FUNCTION bfp(usr_id IN sys_user.ins_id%TYPE,bmi_res IN number)
    RETURN NUMBER;
	FUNCTION insert_health_info(age_check sys_user.Age%TYPE,usr_id IN sys_user.ins_id%TYPE,bmi_res IN number,bmr_res IN number,bfp_res IN number)
    RETURN NUMBER;
END HAS_pack;
/
CREATE OR REPLACE PACKAGE BODY HAS_pack AS

    PROCEDURE m_plan_proc(p_id IN diet_chart_table.Plan_id%TYPE,suggby2 IN diet_chart_table.Suggested_by%TYPE)
    IS
	pid diet_chart_table.Plan_id%TYPE;
	mpln varchar2(1000);
	BEGIN 
	    FOR R IN (SELECT * FROM diet_chart_table_site@has_mysite) LOOP
	        pid := R.Plan_id;
		    mpln := R.Meal_Plan;
		    IF pid = p_id THEN
		       DBMS_OUTPUT.PUT_LINE(chr(10));
		       DBMS_OUTPUT.PUT_LINE('Suggested by:'||' '||suggby2);
			   DBMS_OUTPUT.PUT_LINE(chr(10));
		       DBMS_OUTPUT.PUT_LINE('Meal Plan:'||' '||mpln);
		    END IF;
	    END LOOP;
	END m_plan_proc;
	
    FUNCTION is_number_wt(Weight IN OUT varchar2)
    RETURN sys_user.Weight%TYPE
	IS
    wt_res_num sys_user.Weight%TYPE;
	
	BEGIN
		wt_res_num := TO_NUMBER(Weight);
		RETURN wt_res_num;
		EXCEPTION
			WHEN OTHERS THEN
				RETURN 0;
    END is_number_wt;
	
	FUNCTION is_number_age(Age IN OUT varchar2)
    RETURN sys_user.Age%TYPE
	IS
    age_res_num sys_user.Age%TYPE;
	
	BEGIN
		age_res_num := TO_NUMBER(Age);
		RETURN age_res_num;
		EXCEPTION
			WHEN OTHERS THEN
				RETURN 0;
    END is_number_age;
	
	FUNCTION is_number_ht(Height IN OUT varchar2)
    RETURN sys_user.Height%TYPE
	IS
    ht_res_num sys_user.Height%TYPE;
	
	BEGIN
		ht_res_num := TO_NUMBER(Height);
		RETURN ht_res_num;
		EXCEPTION
			WHEN OTHERS THEN
				RETURN 0;
    END is_number_ht;
	
    PROCEDURE bmi_suggestion(G1 IN sys_user.Gender%TYPE,C IN number)
    IS
    G11 bmi_chart_table.Gender%TYPE;
    undr_wt_up bmi_chart_table.Undrwt_up%TYPE;
    nrml_wt_low bmi_chart_table.Normalwt_low%TYPE;
    nrml_wt_up bmi_chart_table.Normalwt_up%TYPE;
    ovr_wt_low bmi_chart_table.OverWeight_low%TYPE;
    ovr_wt_up bmi_chart_table.OverWeight_up%TYPE;
    Obs_low bmi_chart_table.Obese_low%TYPE;
    Obs_up bmi_chart_table.Obese_up%TYPE;
    extr_obs bmi_chart_table.ExtremeObese%TYPE;
    BEGIN
      FOR R IN (SELECT * FROM bmi_chart_table) LOOP
	    G11 := R.Gender;
	    undr_wt_up := R.Undrwt_up;
		nrml_wt_low := R.Normalwt_low;
		nrml_wt_up := R.Normalwt_up;
		ovr_wt_low := R.OverWeight_low;
		ovr_wt_up := R.OverWeight_up;
		Obs_low := R.Obese_low;
		Obs_up := R.Obese_up;
		extr_obs := R.ExtremeObese;
		IF G11 = G1 THEN
		    IF C <= undr_wt_up THEN
			  DBMS_OUTPUT.PUT_LINE('Oooppppss..Underweight!!');
			  DBMS_OUTPUT.PUT_LINE('Healthy BMI range for you: '||nrml_wt_low||'-'||nrml_wt_up);
			ELSIF C > undr_wt_up and C <= nrml_wt_up THEN
			  DBMS_OUTPUT.PUT_LINE('Your weight is NORMAL!!');
			  DBMS_OUTPUT.PUT_LINE('Healthy BMI range is: '||nrml_wt_low||'-'||nrml_wt_up);
			ELSIF C > nrml_wt_up and C <= ovr_wt_up THEN
			  DBMS_OUTPUT.PUT_LINE('Oooppppss..Overweight!!');
			  DBMS_OUTPUT.PUT_LINE('Healthy BMI range for you: '||nrml_wt_low||'-'||nrml_wt_up);
			ELSIF C >ovr_wt_up and C <= Obs_up THEN
			  DBMS_OUTPUT.PUT_LINE('Oooppppss..OBESE STATE!!');
			  DBMS_OUTPUT.PUT_LINE('Healthy BMI range for you: '||nrml_wt_low||'-'||nrml_wt_up);
			ELSE
			  DBMS_OUTPUT.PUT_LINE('EXTREMELY OBESE STATE!!');
			  DBMS_OUTPUT.PUT_LINE('Healthy BMI range for you: '||nrml_wt_low||'-'||nrml_wt_up);
			END IF;
		END IF;
	  END LOOP;
    END bmi_suggestion;
   PROCEDURE bfp_suggestion(G1 IN sys_user.Gender%TYPE,A1 IN sys_user.Age%TYPE,C IN number)
   IS
   G11 body_fat_chart_table.Gender%TYPE;
   A_low body_fat_chart_table.Age_low%TYPE;
   A_up body_fat_chart_table.Age_up%TYPE;
   H_low body_fat_chart_table.Healthy_low%TYPE;
   H_up body_fat_chart_table.Healthy_up%TYPE;
   ovw_up body_fat_chart_table.OverWeight_up%TYPE;
   BEGIN
      FOR R IN (SELECT * FROM body_fat_chart_table) LOOP
	    G11 := R.Gender;
	    A_low := R.Age_low;
	    A_up := R.Age_up;
	    H_low := R.Healthy_low;
	    H_up := R.Healthy_up;
	    ovw_up := R.OverWeight_up;
		IF G11 = G1 THEN
		  IF A1>=A_low and A1<=A_up THEN
		    IF C<H_low THEN
			  DBMS_OUTPUT.PUT_LINE('Oooppps..Underfat!!');
			  DBMS_OUTPUT.PUT_LINE('Healthy range for you: '||H_low||'-'||H_up);
			END IF;
			IF C>=H_low and C<=H_up THEN
			  DBMS_OUTPUT.PUT_LINE('Your Body Fat Percentage is in healthy range');
			  DBMS_OUTPUT.PUT_LINE('Healthy range is: '||H_low||'-'||H_up);
			END IF;
			IF C>H_up and C<=ovw_up THEN
			  DBMS_OUTPUT.PUT_LINE('Oooppps..Overweight!!');
			  DBMS_OUTPUT.PUT_LINE('Healthy range for you: '||H_low||'-'||H_up||'%');
			END IF;
			IF C>ovw_up THEN
			  DBMS_OUTPUT.PUT_LINE('You are in Obese state!!');
			  DBMS_OUTPUT.PUT_LINE('Healthy range for you: '||H_low||'-'||H_up||'%');
			END IF;
		  END IF;
		END IF;
	  END LOOP;
   END bfp_suggestion;
   
   PROCEDURE bmr_suggestion(G1 IN sys_user.Gender%TYPE,H1 IN sys_user.Height%TYPE,C IN number)
   IS
   G11 bmr_chart_table.Gender%TYPE;
   H11 bmr_chart_table.Height%TYPE;
   bmr_l bmr_chart_table.BMR_low%TYPE;
   bmr_u bmr_chart_table.BMR_up%TYPE;
   BEGIN
      FOR R IN (SELECT * FROM bmr_chart_table) LOOP
	    G11 := R.Gender;
	    H11 := R.Height;
	    bmr_l := R.BMR_low;
	    bmr_u := R.BMR_up;
		IF G11 = G1 THEN
		   IF H11 = H1 THEN
		    IF C>=bmr_l and C<=bmr_u THEN
			   DBMS_OUTPUT.PUT_LINE('Your BMR is in Healthy range');
			   DBMS_OUTPUT.PUT_LINE('Healthy range is: '||bmr_l||'-'||bmr_u ||' Kcal/Day');
			END IF;
			IF C<bmr_l THEN
			   DBMS_OUTPUT.PUT_LINE('Your BMR is in Under Healthy range');
			   DBMS_OUTPUT.PUT_LINE('Healthy range for you: '||bmr_l||'-'||bmr_u ||' Kcal/Day');
			END IF;
			IF C>bmr_l THEN
			   DBMS_OUTPUT.PUT_LINE('Your BMR is in Over Healthy range');
			   DBMS_OUTPUT.PUT_LINE('Healthy range for you: '||bmr_l||'-'||bmr_u||' Kcal/Day');
			END IF;  
		   END IF;
		END IF;
	  END LOOP;
   END bmr_suggestion;
   
   PROCEDURE healthy_meal_plan(Gender IN sys_user.Gender%TYPE,age_check IN sys_user.Age%TYPE)
   IS
   p_id diet_chart_table.Plan_id%TYPE;
   G11 diet_chart_table.Gender%TYPE;
   suggby diet_chart_table.Suggested_by%TYPE;
   suggby2 diet_chart_table.Suggested_by%TYPE;
   age_range_low diet_chart_table.Age_low%TYPE;
   age_range_up diet_chart_table.Age_up%TYPE;
   BEGIN
      DBMS_OUTPUT.PUT_LINE(chr(10));
      DBMS_OUTPUT.PUT_LINE('We have healthy meal plan suggested by experts for you.');
      FOR R IN (SELECT * FROM diet_chart_table) LOOP
	      p_id := R.Plan_id;
	      G11 := R.Gender;
		  suggby := R.Suggested_by;
		  age_range_low := R.Age_low;
		  age_range_up := R.Age_up;
		  IF G11=Gender and age_check>=age_range_low and  age_check <= age_range_up THEN
		    suggby2 := suggby;
			m_plan_proc(p_id,suggby2);
		  END IF;
	  END LOOP;
   END healthy_meal_plan;
   
   
   
   FUNCTION func_user_info_insert(Gender IN sys_user.Gender%TYPE,Weight IN sys_user.Weight%TYPE,Age IN sys_user.Age%TYPE,Height IN sys_user.Height%TYPE)
   RETURN sys_user.ins_id%TYPE
   IS
   C sys_user.ins_id%TYPE;
   A1 sys_user.ins_id%TYPE;
   G1 sys_user.Gender%TYPE;
   W1 sys_user.Weight%TYPE; 
   Ag1 sys_user.Age%TYPE;   
   Ht1 sys_user.Height%TYPE; 
   Flg NUMBER;   
   BEGIN
      Flg := 0;
      FOR R IN (SELECT * FROM sys_user) LOOP
	    A1 := R.ins_id;
		G1 := R.Gender;
		W1 := R.Weight;
		Ag1 := R.Age;
		Ht1 := R.Height;
		IF G1=Gender and W1=Weight and Ag1=Age and Ht1=Height THEN
		  C := A1;
		  Flg := 1;
		END IF;
	  END LOOP;
	  IF Flg=0 THEN
	    insert into sys_user values(A_SEQUENCE.nextval,Gender,Weight,Age,Height);
		DBMS_OUTPUT.PUT_LINE(chr(10));
		FOR R IN (SELECT * FROM sys_user) LOOP
           A1 := R.ins_id;
        END LOOP;
		C := A1;
	  END IF;
      Return C;
   END func_user_info_insert;
   
   FUNCTION bmi(usr_id IN sys_user.ins_id%TYPE)
   RETURN NUMBER
   IS
   C Number;
   ID1 sys_user.ins_id%TYPE;
   G1 sys_user.Gender%TYPE;
   H1 sys_user.Height%TYPE;
   W1 sys_user.Weight%TYPE;
   Height_meter sys_user.Height%TYPE;
   BEGIN
    FOR R IN (SELECT * FROM sys_user) LOOP
        ID1 := R.ins_id;
		G1 := R.Gender;
		H1 := R.Height;
		W1 := R.Weight;
		IF ID1 = usr_id THEN
		   Height_meter := H1/100;
           C := (W1 / (Height_meter*Height_meter));
           C := Round(C,3);
		   bmi_suggestion(G1,C);
		   DBMS_OUTPUT.PUT_LINE('Your BMI is ' || C ||' Kg/m^2');
	       DBMS_OUTPUT.PUT_LINE(chr(10));
		END IF;
    END LOOP;
    Return C;
   END bmi;
   
   FUNCTION bmr(usr_id IN sys_user.ins_id%TYPE)
   RETURN NUMBER
   IS
   C Number;
   ID1 sys_user.ins_id%TYPE;
   H1 sys_user.Height%TYPE;
   W1 sys_user.Weight%TYPE;
   A1 sys_user.Age%TYPE;
   G1 sys_user.Gender%TYPE;
   BEGIN
    FOR R IN (SELECT * FROM sys_user) LOOP
        ID1 := R.ins_id;
		H1 := R.Height;
		W1 := R.Weight;
		A1 := R.Age;
		G1 := R.Gender;
		IF ID1 = usr_id THEN
		    IF G1 = 'male' THEN
			   C := (66.47+(13.75*W1)+(5.003*H1)-(6.755*A1)); 
			   C := Round(C,3);
			   bmr_suggestion(G1,H1,C);
			   DBMS_OUTPUT.PUT_LINE('Your BMR is ' || C||' Kcal/Day');
			   DBMS_OUTPUT.PUT_LINE(chr(10));
			END IF;
		    IF G1 = 'female' THEN
			   C := (655.1+(9.563*W1)+(1.85*H1)-(4.676*A1));
			   C := Round(C,3);
			   bmr_suggestion(G1,H1,C);
			   DBMS_OUTPUT.PUT_LINE('Your BMR is ' || C||' Kcal/Day');
			   DBMS_OUTPUT.PUT_LINE(chr(10));
			END IF;
		END IF;
    END LOOP;
    Return C;
   END bmr;
   
   FUNCTION bfp(usr_id IN sys_user.ins_id%TYPE,bmi_res IN number)
   RETURN NUMBER
   IS
   C Number;
   ID1 sys_user.ins_id%TYPE;
   A1 sys_user.Age%TYPE;
   G1 sys_user.Gender%TYPE;
   BEGIN
    FOR R IN (SELECT * FROM sys_user) LOOP
        ID1 := R.ins_id;
		A1 := R.Age;
		G1 := R.Gender;
		IF ID1 = usr_id THEN
		    IF G1 = 'male' THEN
			   C := ((1.20*bmi_res)+(0.23*A1)-16.2); 
	           C := Round(C,3);
			   bfp_suggestion(G1,A1,C);
			   DBMS_OUTPUT.PUT_LINE('Your Body Fat Percentage is ' || C ||'%');
			END IF;
			IF G1 = 'female' THEN
	           C := ((1.20*bmi_res)+(0.23*A1)-5.4); 
	           C := Round(C,3);
			   bfp_suggestion(G1,A1,C);
			   DBMS_OUTPUT.PUT_LINE('Your Body Fat Percentage is ' || C ||'%');
            END IF;
		END IF;
    END LOOP;
   Return C;
   END bfp;
   
   FUNCTION insert_health_info(age_check sys_user.Age%TYPE,usr_id IN sys_user.ins_id%TYPE,bmi_res IN number,bmr_res IN number,bfp_res IN number)
   RETURN NUMBER
   IS
   C Number;
   u_id user_health_info.ins_id%TYPE;
   bmi2 user_health_info.BMI%TYPE;
   bmr2 user_health_info.BMR%TYPE;
   bfp2 user_health_info.BFP%TYPE;
   flg NUMBER;
   flg2 NUMBER;
   BEGIN
    flg := 0;
	flg2 := 0;
    FOR R IN (SELECT * FROM user_health_info) LOOP
	    u_id := R.ins_id;
		bmi2 := R.BMI;
		bmr2 := R.BMR;
		bfp2 := R.BFP;
		IF u_id=usr_id and bmi2=bmi_res and bmr2=bmr_res and bfp2=bfp_res THEN
            flg := 1;		
		END IF;
	END LOOP;
	
	FOR R IN (SELECT * FROM user_health_info_site@has_mysite) LOOP
	    u_id := R.ins_id;
		bmi2 := R.BMI;
		bmr2 := R.BMR;
		bfp2 := R.BFP;
		IF u_id=usr_id and bmi2=bmi_res and bmr2=bmr_res and bfp2=bfp_res THEN
            flg2 := 1;		
		END IF;
	END LOOP;
	
	IF flg = 0 and age_check < 40 THEN
		insert into user_health_info values(usr_id,bmi_res,bmr_res,bfp_res);
		commit;
	END IF;
	
	IF flg2 = 0 and age_check >= 40 THEN
		insert into user_health_info_site@has_mysite values(usr_id,bmi_res,bmr_res,bfp_res);
		commit;
	END IF;
    Return C;
   END insert_health_info;
   
END HAS_pack;
/