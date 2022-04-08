--user info
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
WHERE investor_data.id = 2;

-- consulting FII
SELECT * FROM real_estate_investment_funds
WHERE ticker_symbol = 'BCFF11'

-- consulting stocks
SELECT * FROM stocks
WHERE ticker_symbol = 'ITSA4';

-- registering fii opening balance
INSERT INTO real_estate_investment_funds_opening_balance (investor_id, real_estate_investment_fund_id, quantity, unit_value)
VALUES (2, 19, 148, 98.34);

-- registro ação opening balance
INSERT INTO stocks_opening_balance (investor_id, stock_id, quantity, unit_value)
VALUES (2, 2612, 317, 9.99);

SELECT * FROM stocks_opening_balance;

-- test left join
SELECT stocks.ticker_symbol, stocks_opening_balance.quantity, stocks_opening_balance.unit_value
	FROM stocks_opening_balance
LEFT JOIN stocks
	ON stocks.id = stocks_opening_balance.stock_id


