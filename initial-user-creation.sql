--add to table creation sql file
CREATE TYPE br_states AS ENUM ('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO', 'DF');

--import cities csv

--ALTER SEQUENCE users_id_seq RESTART WITH 1;
Create SCHEMA stock;

select * from investors;

SELECT id FROM investors WHERE cpf = '00000000000';

INSERT INTO users_type (type, created_by)
	VALUES ('admin', 1);

INSERT INTO users_type (type, created_by)
	VALUES ('user', 1);

ALTER SEQUENCE users_id_seq RESTART WITH 1;
INSERT INTO users (email, password, user_type_id)
	VALUES ('admin@admin.com', '$2b$10$GfIYRgFapvUp3nMt6AQsPeNov0zPf0gHCDZ0mIfuRLB8v2rvS3irO', 1);

/* teste relação
select users.id, email, password, type
	from users
left join users_type on users_type.id = user_type_id
*/

ALTER SEQUENCE investors_id_seq RESTART WITH 1;
INSERT INTO investors (user_id, full_name, document, cpf, birth_date, mother_full_name)
	VALUES (1, 'System Administrator', '00000000000000', '00000000000', CURRENT_DATE, 'Machine');


/* teste relação	
select investors.id, email, full_name, mother_full_name, type
	from investors
left join users on users.id = user_id
left join users_type on users_type.id = user_type_id
*/

ALTER SEQUENCE addresses_id_seq RESTART WITH 1;
INSERT INTO addresses (investor_id, city_id, public_place, number, zip_code)
	VALUES (1, 68, 'R. Rui Barbosa', 285, '69900120');


ALTER SEQUENCE phones_id_seq RESTART WITH 1;
INSERT INTO phones (city_code, phone_number, investor_id)
	VALUES ('68', '32232201', 1);



/* final test query*/
WITH address_with_city AS (
	SELECT cities.name AS cidade, cities.state AS estado, public_place AS logradouro, number AS número,
	zip_code AS cep, investor_id
		FROM addresses
	LEFT JOIN cities on cities.id = city_id --junta cidades com endereço
),
investor_data AS (
	select investors.id, type, full_name AS nome, email, mother_full_name AS "nome da mãe",
	city_code AS ddd, phone_number AS telefone
		from investors
	left join users on users.id = user_id --junta usuário com investidor
	left join users_type on users_type.id = user_type_id --junta usuário com user_type
	left join phones on phones.investor_id = investors.id --junta phone com investidor
)
SELECT investor_data.id, investor_data.type, nome, email, "nome da mãe", estado, cidade, logradouro, número, cep, ddd, telefone
	FROM investor_data
LEFT JOIN address_with_city on investor_data.id = investor_id




-- USER CREATION PROTOCOL

--alterar o email e o hash do password
--pegar o id da nova entrada em usuário para o campo user_id da próxima etapa
INSERT INTO users (email, password, user_type_id)
	VALUES ('cliente1@apressada.com.br', '$2b$10$BozLt.TKQdhCEkIGmu0gduzqGSpc9eIf17RAsnUBWTz3MUNvB118O', 2);
	
--mudar o user_id com o valor anterior, mudar os demais campos ao sabor do momento
--pegar o valor do id dessa entrada para investor_id das próximas duas queries
INSERT INTO investors (user_id, full_name, document, cpf, birth_date, mother_full_name)
	VALUES (2, 'Apressada da Silva', '12345678901234', '98765432109', '1996-01-15' , 'Muito Apressadona');

--mudar o investor id com o valor obtido na etapa anterior e buscar o city id na tabela cities
--para obter a cidade:
/*SELECT cities.id, cities.name, cities.state
	FROM cities
WHERE cities.name = 'Valinhos'
*/
INSERT INTO addresses (investor_id, city_id, public_place, number, zip_code)
	VALUES (2, 3899, 'R. Um', 85, '13090000');
	
INSERT INTO phones (city_code, phone_number, investor_id)
	VALUES ('19', '32252491', 2);

SELECT * FROM accounts;
SELECT * FROM stock_brokers;

SELECT * FROM stock_brokers
WHERE stock_brokers.name ~* 'clear';

INSERT INTO accounts (account_number, branch_number, investor_id, stock_broker_id)
	VALUES ('12345678901234', '1234', 2, 12);

  WITH address_with_city AS (
    SELECT cities.name AS city, cities.state AS state, public_place AS street, number AS number,
    zip_code AS zip, investor_id
      FROM addresses
    LEFT JOIN cities on cities.id = city_id --junta cidades com endereço
  ),
  investor_data AS (
    select investors.id, type, full_name AS name, email, mother_full_name AS mother,
    city_code AS areacode, phone_number AS phone, document, cpf, birth_date
      from investors
    left join users on users.id = user_id --junta usuário com investidor
    left join users_type on users_type.id = user_type_id --junta usuário com user_type
    left join phones on phones.investor_id = investors.id --junta phone com investidor
  )
  SELECT investor_data.id, investor_data.type, name, email, birth_date, document, cpf, mother, state, city, street, number, zip, areacode, phone
    FROM investor_data
  LEFT JOIN address_with_city on investor_data.id = investor_id
  where id = 4;
