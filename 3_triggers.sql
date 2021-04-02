SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER my_trig_1
AFTER INSERT
ON sys_user
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(chr(10));
  DBMS_OUTPUT.PUT_LINE('**New user infornamtion inserted**');
END;
/
CREATE OR REPLACE TRIGGER my_trig_2
AFTER INSERT 
ON user_health_info
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(chr(10));
  DBMS_OUTPUT.PUT_LINE('**New user health record inserted**');
END;
/
CREATE OR REPLACE TRIGGER my_trig_3
AFTER INSERT
ON diet_chart_table
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(chr(10));
  DBMS_OUTPUT.PUT_LINE('**New row for meal plan inserted**');
END;
/
CREATE OR REPLACE TRIGGER my_trig_4
AFTER DELETE
ON diet_chart_table
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(chr(10));
  DBMS_OUTPUT.PUT_LINE('**A row for meal plan deleted**');
END;
/
CREATE OR REPLACE TRIGGER my_trig_5
AFTER UPDATE
ON diet_chart_table
DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE(chr(10));
  DBMS_OUTPUT.PUT_LINE('**Updated the table containing healthy meal plan**');
END;
/
CREATE OR REPLACE TRIGGER my_trig_6
BEFORE UPDATE
ON diet_chart_table
FOR EACH ROW
DECLARE
  A diet_chart_table.Plan_id%TYPE;
  B diet_chart_table.Gender%TYPE;
  C diet_chart_table.Suggested_by%TYPE;
  D diet_chart_table.Age_low%TYPE;
  E diet_chart_table.Age_up%TYPE;
BEGIN
  A := :OLD.Plan_id;
  B := :OLD.Gender;
  C := :OLD.Suggested_by;
  D := :OLD.Age_low;
  E := :OLD.Age_up;
  Insert into diet_chart_table_old_data values(A,B,C,D,E);
  DBMS_OUTPUT.PUT_LINE('**Old record has been also stored**');
END;
/
