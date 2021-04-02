clear screen;
SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
    Gender sys_user.Gender%TYPE := '&Enter_Gender_Male_or_Female';
	Weight varchar2(10) := '&Enter_Your_Weight_In_KG';
	Age varchar2(10) := '&Enter_Your_Age_In_Year';
	Height varchar2(10) := '&Enter_Your_Height_In_cm';
	usr_id sys_user.ins_id%TYPE;
	bmi_res number;
	bmr_res number;
	bfp_res number;
	c number;
	wt_check sys_user.Weight%TYPE;
	age_check sys_user.Age%TYPE;
	ht_check sys_user.Height%TYPE;
	wrong_gender_excp EXCEPTION;
	neg_val_excp EXCEPTION;
	wrong_wt_excp EXCEPTION;
	wrong_age_excp EXCEPTION;
	wrong_ht_excp EXCEPTION;
BEGIN
    IF Gender != 'male' and Gender != 'female' THEN
	   RAISE wrong_gender_excp;
	END IF;
	wt_check := HAS_pack.is_number_wt(Weight);
	IF wt_check=0 THEN
	   RAISE wrong_wt_excp;
	END IF;
	age_check := HAS_pack.is_number_age(Age);
	IF age_check=0 THEN
	   RAISE wrong_age_excp;
	END IF;
	ht_check := HAS_pack.is_number_ht(Height);
	IF ht_check=0 THEN
	   RAISE wrong_ht_excp;
	END IF;
	IF Weight < 0 or Height <0 or Age<0 THEN
	   RAISE neg_val_excp;
	END IF;
	
	usr_id := HAS_pack.func_user_info_insert(Gender,wt_check,age_check,ht_check);
	DBMS_OUTPUT.PUT_LINE(chr(10));
	bmi_res := HAS_pack.bmi(usr_id);
	bmr_res := HAS_pack.bmr(usr_id);
	bfp_res := HAS_pack.bfp(usr_id,bmi_res);
	c := HAS_pack.insert_health_info(age_check,usr_id,bmi_res,bmr_res,bfp_res);
	HAS_pack.healthy_meal_plan(Gender,age_check);
	
EXCEPTION
    WHEN wrong_gender_excp THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   DBMS_OUTPUT.PUT_LINE('Write male or female appropriately..');
	WHEN wrong_wt_excp THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   DBMS_OUTPUT.PUT_LINE('Write WEIGHT appropriately..');
	WHEN wrong_age_excp THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   DBMS_OUTPUT.PUT_LINE('Write AGE appropriately..');
	WHEN wrong_ht_excp THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   DBMS_OUTPUT.PUT_LINE('Write HEIGHT appropriately..');
	WHEN neg_val_excp THEN
	   IF Weight<0 THEN
	    DBMS_OUTPUT.PUT_LINE(chr(10));
	    DBMS_OUTPUT.PUT_LINE('Weight/Age/Height can not be negative(-ve)');
	    Weight := Weight*(-1);
	    DBMS_OUTPUT.PUT_LINE('Now Weight is: '|| Weight);
	   END IF;
	   IF Age<0 THEN
	    DBMS_OUTPUT.PUT_LINE(chr(10));
	    DBMS_OUTPUT.PUT_LINE('Weight/Age/Height can not be negative(-ve)');
	    Age := Age*(-1);
	    DBMS_OUTPUT.PUT_LINE('Now Age is: '|| Age);
	   END IF;
	   IF Height<0 THEN
	    DBMS_OUTPUT.PUT_LINE(chr(10));
	    DBMS_OUTPUT.PUT_LINE('Weight/Age/Height can not be negative(-ve)');
	    Height := Height*(-1);
	    DBMS_OUTPUT.PUT_LINE('Now Height is: '|| Height);
	   END IF;
	   usr_id := HAS_pack.func_user_info_insert(Gender,wt_check,age_check,ht_check);
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   bmi_res := HAS_pack.bmi(usr_id);
	   bmr_res := HAS_pack.bmr(usr_id);
	   bfp_res := HAS_pack.bfp(usr_id,bmi_res);
	   c := HAS_pack.insert_health_info(age_check,usr_id,bmi_res,bmr_res,bfp_res);
	   HAS_pack.healthy_meal_plan(Gender,age_check);
	WHEN NO_DATA_FOUND THEN
	   DBMS_OUTPUT.PUT_LINE('Data not found');
	WHEN OTHERS THEN 
       DBMS_OUTPUT.PUT_LINE('Something else is making an error');
END;
/