clear screen;
SET VERIFY OFF;
SET SERVEROUTPUT ON;
DECLARE
    Gender diet_chart_table.Gender%TYPE := '&Enter_Gender';
	Name diet_chart_table.Suggested_by%TYPE := '&Suggested_by_whom';
	Age_range_start diet_chart_table.Age_low%TYPE := '&Age_Range_start';
	Age_range_end diet_chart_table.Age_up%TYPE := '&Age_Range_end';
	Meal_plan varchar2(1000) := '&Enter_Meal_Plan';
	C diet_chart_table.Plan_id%TYPE;
	wrong_gender_excp EXCEPTION;

BEGIN
    IF Gender != 'male' and Gender != 'female' THEN
	   RAISE wrong_gender_excp;
	END IF;
	C := HAS_pack2.Insert_data(Gender,Name,Age_range_start,Age_Range_end,Meal_plan);
	DBMS_OUTPUT.PUT_LINE('Plan ID= '|| C);
EXCEPTION
    WHEN wrong_gender_excp THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   DBMS_OUTPUT.PUT_LINE('Write male or female appropriately..');
	WHEN OTHERS THEN 
       DBMS_OUTPUT.PUT_LINE('Something else is making an error');
END;
/