DO $$
DECLARE
	contador INT := 1;
BEGIN
	LOOP
		RAISE NOTICE '%', contador;
		contador := contador + 1;
		IF contador > 10 THEN
			EXIT;
		END IF;
		
	END LOOP;
END;
$$
--------------------------------------------
--saída do loop LOOP com EXIT/WHEN
DO $$
DECLARE
	contador INT := 1;
BEGIN
	LOOP
		RAISE NOTICE '%', contador;
		contador := contador + 1;
		EXIT WHEN contador > 10;
	END LOOP;
END;
$$
----------------------------------------------






