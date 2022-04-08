-- consulting FII
SELECT * FROM real_estate_investment_funds
WHERE ticker_symbol = 'BCFF11';

-- consulting stocks
SELECT * FROM stocks
WHERE ticker_symbol = 'ODPV3';

-- consulting stock_broker
SELECT * FROM stock_brokers
WHERE stock_brokers.name ~* 'clear';


-- CREATE NEW INVOICE
INSERT INTO invoices (investor_id, stock_broker_id, invoice_number, trading_floor_date)
VALUES (2, 12, 9871462, '2021-05-21');

select * from invoices

-- with the id from the previous query, create the following tables

-- create clearing expenses
INSERT INTO clearing (invoice_id, clearing_expenses, register_expenses)
VALUES (1, 0.32, 0);

SELECT * FROM clearing;

-- create operational costs
INSERT INTO operational_costs(invoice_id, operational_tax, custody_tax, municipal_tax, execution, tds, others)
VALUES (1, 0, 0, 0, 0, 0, 0);

SELECT * FROM operational_costs;

-- create stock_market costs
INSERT INTO stock_market (invoice_id, option_tax, ana_tax, fees)
VALUES (1, 0, 0, 0.06);

SELECT * FROM stock_market

-- create opertations
INSERT INTO operations_stocks (invoice_id, stock_id, quantity, unit_value, operation)
VALUES (1, 2800, 100, 12.9, 'C');

SELECT * FROM operations_stocks

-- select ok mas falta pegar o nome da companhia da ação
SELECT stock_brokers.name, invoices.invoice_number, invoices.trading_floor_date, clearing_expenses,
register_expenses, operational_tax, custody_tax, municipal_tax, execution, tds, others, option_tax, ana_tax, fees,
operations_stocks.quantity, operations_stocks.unit_value
FROM invoices
LEFT JOIN stock_brokers
	ON invoices.stock_broker_id = stock_brokers.id
LEFT JOIN clearing
	ON invoices.id = clearing.invoice_id
LEFT JOIN operational_costs
	ON invoices.id = operational_costs.invoice_id
LEFT JOIN stock_market
	ON invoices.id = stock_market.invoice_id
LEFT JOIN operations_stocks
	ON invoices.id = operations_stocks.invoice_id;




SELECT operations_stocks.quantity, operations_stocks.unit_value, stocks.company_name
	FROM operations_stocks
LEFT JOIN stocks
	on operations_stocks.stock_id = stocks.id;

