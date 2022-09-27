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
DO $$
DECLARE
	contador INT := 0;
BEGIN
	LOOP
		contador := contador + 1;
		EXIT WHEN contador > 20;
		IF contador % 7 = 0 THEN
			--pula a iteração atual
			CONTINUE;
		END IF;
		CONTINUE WHEN contador % 11 = 0;
		RAISE NOTICE '%', contador;
	END LOOP;
END;
$$
--------------------------------------------------------------------
DO $$
DECLARE
	i INT;
	j INT;
BEGIN
	i := 0;
	<<externo>>
	LOOP
		i := i + 1;
		EXIT WHEN i > 10;
		j := 0;
		<<interno>>
		LOOP
			RAISE NOTICE '% %', i, j;
			j := j + 1;
			EXIT WHEN j > 10;
			EXIT externo WHEN i > 5;
		END LOOP;
	END LOOP;
END;
$$
---------------------------------------------------
DO $$
DECLARE
	nota INT;
	media NUMERIC (10, 2) := 0;
	contador INT := 0;
BEGIN
	SELECT fn_valor_aleatorio_entre(0, 11) - 1 INTO nota;
	WHILE nota >= 0 LOOP
		RAISE NOTICE '%', nota;
		media := media + nota;
		contador := contador + 1;
		SELECT fn_valor_aleatorio_entre (0, 11) - 1 INTO nota;
	END LOOP;
	IF contador >= 1 THEN
		RAISE NOTICE 'Média: %', media / contador;
	ELSE	
		RAISE NOTICE 'Nenhuma nota gerada';
	END IF;
END;
$$
--------------------------------------------------
DO $$
DECLARE
	valor INT := 6;
BEGIN
	FOR i IN 1..10 LOOP
		RAISE NOTICE '%', i;
	END LOOP;
	RAISE NOTICE '--------------------------';
	FOR i IN 10..1 LOOP
		RAISE NOTICE '%', i;
	END LOOP;
	RAISE NOTICE '--------------------------';
	FOR i IN REVERSE 10..1 LOOP
		RAISE NOTICE '%', i;
	END LOOP;
	RAISE NOTICE '--------------------------';
	FOR i IN 1..50 BY valor + 3 LOOP
		RAISE NOTICE '%', i;
	END LOOP;
	RAISE NOTICE '--------------------------';
	FOR i IN REVERSE 50..1 BY 2 LOOP
		RAISE NOTICE '%', i;
	END LOOP;
END;
$$
------------------------------------------------
CREATE TABLE tb_aluno(
	cod_aluno SERIAL PRIMARY KEY,
	nota INT
);
DO $$
BEGIN
	--gerando 10 valores aleatoriamente
	FOR i IN 1..10 LOOP
		INSERT INTO tb_aluno (nota) 
		VALUES(fn_valor_aleatorio_entre(0, 10));
	END LOOP;
END;
$$
SELECT * FROM tb_aluno;

DO $$
DECLARE
	aluno RECORD;
	media NUMERIC(10, 2) := 0;
	total INT;
BEGIN
	FOR aluno IN
		SELECT * FROM tb_aluno		 
	LOOP
		RAISE NOTICE '%', aluno.nota;
		media := media + aluno.nota;
	END LOOP;
	SELECT COUNT(*) FROM tb_aluno INTO total;
	RAISE NOTICE 'Média: %', media / total;
END;
$$
----------------------------------------------
DO $$
DECLARE
	valores INT[] := ARRAY[
		fn_valor_aleatorio_entre(1, 10),
		fn_valor_aleatorio_entre(1, 10),
		fn_valor_aleatorio_entre(1, 10),
		fn_valor_aleatorio_entre(1, 10),
		fn_valor_aleatorio_entre(1, 10)
	];
	valor INT;
	soma INT := 0;
BEGIN
	FOREACH valor IN ARRAY valores LOOP
		RAISE NOTICE 'Valor da vez: %', valor;
		soma := soma + valor;
	END LOOP;
	RAISE NOTICE 'Soma= %.', soma;
END;
$$
--------------------------------------------
DO $$
DECLARE
	vetor INT[] := ARRAY[1, 2, 3];
	matriz INT[] := ARRAY[
		[1, 2, 3],
		[4, 5, 6],
		[7, 8, 9]
	];
	var_aux INT;
	vet_aux INT[];
BEGIN
	--exemplo sem SLICE com vetor
	FOREACH var_aux IN ARRAY vetor LOOP
		RAISE NOTICE '%', var_aux;
	END LOOP;
	
	--exemplo com SLICE igual 1
	FOREACH vet_aux SLICE 1 IN ARRAY vetor LOOP
		RAISE NOTICE '%', vet_aux;
		FOREACH var_aux IN ARRAY vet_aux LOOP
			RAISE NOTICE '%', var_aux;
		END LOOP;
	END LOOP;
	
	FOREACH var_aux SLICE 0 IN ARRAY matriz LOOP
		RAISE NOTICE '%', var_aux;
	END LOOP;
	
	FOREACH vet_aux SLICE 1 IN ARRAY matriz LOOP
		RAISE NOTICE '%', vet_aux;
	END LOOP;
	
	FOREACH vet_aux SLICE 1 IN ARRAY matriz LOOP
		RAISE NOTICE '%', vet_aux;
	END LOOP;
END;
$$
------------------------------------------





