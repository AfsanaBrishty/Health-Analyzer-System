clear screen;
SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
	p_id varchar2(10) := '&Enter_PlanID';
	pid_check diet_chart_table.Plan_id%TYPE;
	A diet_chart_table.Plan_id%TYPE;
	flg number := 0;
	wrong_pid_excp1 EXCEPTION;
	wrong_pid_excp2 EXCEPTION;

BEGIN
    pid_check := HAS_pack2.is_number_pid(p_id);
	IF pid_check=0 THEN
	   RAISE wrong_pid_excp1;
	END IF;
    FOR R IN (SELECT * FROM diet_chart_table) LOOP
	   A := R.Plan_id;
	   IF A = p_id THEN
	    flg := 1;
		HAS_pack2.Delete_data(pid_check);
	   END IF;
	END LOOP;
	IF flg = 0 THEN
	   RAISE wrong_pid_excp2;
	END IF;
EXCEPTION
    WHEN wrong_pid_excp1 THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   DBMS_OUTPUT.PUT_LINE('Write Plan ID appropriately..');
    WHEN wrong_pid_excp2 THEN
	   DBMS_OUTPUT.PUT_LINE(chr(10));
	   DBMS_OUTPUT.PUT_LINE('No row having this plan id');
	WHEN OTHERS THEN 
       DBMS_OUTPUT.PUT_LINE('Something else is making an error');
END;
/