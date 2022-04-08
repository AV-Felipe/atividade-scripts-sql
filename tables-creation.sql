CREATE TABLE public.investors (
	"id" serial NOT NULL,
	"user_id" int NOT NULL,
	"full_name" varchar(120) NOT NULL,
	"document" varchar(14) NOT NULL UNIQUE,
	"cpf" varchar(11) NOT NULL,
	"birth_date" DATE NOT NULL,
	"mother_full_name" varchar(120) NOT NULL,
	"created_at" DATE NOT NULL,
	"deleted_at" DATE,
	"updated_at" DATE,
	CONSTRAINT "investors_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.accounts (
	"id" serial NOT NULL UNIQUE,
	"account_number" varchar(14) NOT NULL UNIQUE,
	"branch_number" varchar(4) NOT NULL UNIQUE,
	"investor_id" int NOT NULL UNIQUE,
	"stock_broker_id" int NOT NULL UNIQUE,
	"created_at" DATE NOT NULL,
	"deleted_at" DATE,
	"updated_at" DATE,
	CONSTRAINT "accounts_pk" PRIMARY KEY ("account_number","branch_number","investor_id","stock_broker_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.stock_brokers (
	"id" serial NOT NULL UNIQUE,
	"name" varchar(120) NOT NULL,
	"cnpj" varchar(14) NOT NULL,
	"code_number" varchar(3),
	"created_by" int NOT NULL,
	"created_at" DATE NOT NULL,
	"deleted_by" int,
	"deleted_at" DATE,
	"updated_by" int,
	"updated_at" DATE,
	CONSTRAINT "stock_brokers_pk" PRIMARY KEY ("cnpj")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.operations_stocks (
	"id" serial NOT NULL,
	"invoice_id" int NOT NULL,
	"stock_id" int NOT NULL,
	"quantity" int NOT NULL,
	"unit_value" int NOT NULL,
	"operation" varchar(1) NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_at" DATE,
	"deleted_at" DATE,
	CONSTRAINT "operations_stocks_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.phones (
	"id" serial NOT NULL UNIQUE,
	"phone_ddd" varchar(2) NOT NULL UNIQUE,
	"phone_number" varchar(9) NOT NULL UNIQUE,
	"investor_id" int NOT NULL,
	"created_at" DATE NOT NULL,
	"deleted_at" DATE,
	"updated_at" DATE,
	CONSTRAINT "phones_pk" PRIMARY KEY ("phone_ddd","phone_number","investor_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.invoices (
	"id" serial NOT NULL UNIQUE,
	"investor_id" int NOT NULL,
	"stock_broker_id" int NOT NULL,
	"clearing_id" int NOT NULL,
	"stock_market_id" int NOT NULL,
	"operational_cost_id" int NOT NULL,
	"invoice_number" int NOT NULL,
	"trading_floor_date" DATE NOT NULL,
	"created_at" DATE NOT NULL,
	"deleted_at" DATE,
	"updated_at" DATE,
	CONSTRAINT "invoices_pk" PRIMARY KEY ("stock_broker_id","invoice_number")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.stocks (
	"id" serial NOT NULL UNIQUE,
	"ticker_symbol" varchar(7) NOT NULL UNIQUE,
	"company_name" varchar(150) NOT NULL,
	"cnpj" varchar(14) NOT NULL UNIQUE,
	"created_by" int NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_by" int,
	"updated_at" DATE,
	"deleted_by" int,
	"deleted_at" DATE,
	CONSTRAINT "stocks_pk" PRIMARY KEY ("ticker_symbol","cnpj")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.clearing (
	"id" serial NOT NULL UNIQUE,
	"investor_id" int NOT NULL,
	"clearing_expenses" money NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_at" DATE,
	"deleted_at" DATE,
	CONSTRAINT "clearing_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.stock_market (
	"id" serial NOT NULL UNIQUE,
	"option_tax" money NOT NULL,
	"ana_tax" money NOT NULL,
	"fees" money NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_at" DATE,
	"deleted_at" DATE,
	CONSTRAINT "stock_market_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.operational_costs (
	"id" serial NOT NULL,
	"operational_tax" money NOT NULL,
	"custody_tax" money NOT NULL,
	"municipal_tax" money NOT NULL,
	"execution" money NOT NULL,
	"tds" money NOT NULL,
	"others" money NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_at" DATE,
	"deleted_at" DATE,
	CONSTRAINT "operational_costs_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.adresses (
	"id" serial NOT NULL,
	"investor_id" serial NOT NULL,
	"state" varchar(2) NOT NULL,
	"city" varchar(30) NOT NULL,
	"public_place" varchar(150) NOT NULL,
	"number" int NOT NULL,
	"zip_code" varchar(8) NOT NULL,
	"complement" varchar(150) NOT NULL,
	"created_at" DATE NOT NULL,
	"deleted_at" DATE,
	"updated_at" DATE,
	CONSTRAINT "adresses_pk" PRIMARY KEY ("id","investor_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.users (
	"id" serial NOT NULL UNIQUE,
	"email" varchar(150) NOT NULL UNIQUE,
	"pasword" varchar(16) NOT NULL,
	"type" bool NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_at" DATE,
	"deleted_at" DATE,
	CONSTRAINT "users_pk" PRIMARY KEY ("email","pasword")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.stocks_opening_balance (
	"id" serial NOT NULL UNIQUE,
	"investor_id" int NOT NULL,
	"stock_id" int NOT NULL,
	"quantity" int NOT NULL,
	"unit_value" int NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_at" DATE,
	"deleted_at" DATE,
	CONSTRAINT "stocks_opening_balance_pk" PRIMARY KEY ("stock_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.tds_opening_balance (
	"id" serial NOT NULL,
	"investor_id" int NOT NULL,
	"value" serial NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_at" DATE,
	"deleted_at" DATE,
	CONSTRAINT "tds_opening_balance_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.real_estate_investment_funds_opening_balance (
	"id" serial NOT NULL UNIQUE,
	"investor_id" int NOT NULL,
	"stock_id" int NOT NULL,
	"quantity" int NOT NULL,
	"unit_value" int NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_at" DATE,
	"deleted_at" DATE,
	CONSTRAINT "real_estate_investment_funds_opening_balance_pk" PRIMARY KEY ("stock_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.operations_real_estate_investment_funds (
	"id" serial NOT NULL,
	"invoice_id" int NOT NULL,
	"real_estate_investment_fund_id" int NOT NULL,
	"quantity" int NOT NULL,
	"unit_value" int NOT NULL,
	"operation" varchar(1) NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_at" DATE NOT NULL,
	"deleted_at" DATE NOT NULL,
	CONSTRAINT "operations_real_estate_investment_funds_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE public.real_estate_investment_funds (
	"id" serial NOT NULL UNIQUE,
	"ticker_symbol" varchar(6) NOT NULL UNIQUE,
	"real_estate_investment_funds_name" varchar(150) NOT NULL,
	"real_estate_investment_funds_cnpj" varchar(14) NOT NULL UNIQUE,
	"real_estate_investment_funds-administrator_id" int NOT NULL,
	"created_by" int NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_by" int,
	"updated_at" DATE,
	"deleted_by" int,
	"deleted_at" DATE,
	CONSTRAINT "real_estate_investment_funds_pk" PRIMARY KEY ("ticker_symbol","real_estate_investment_funds_cnpj")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public.real_estate_investment_funds_administrators (
	"id" serial NOT NULL UNIQUE,
	"company_name" varchar(150) NOT NULL,
	"cnpj" varchar(14) NOT NULL UNIQUE,
	"created_by" int NOT NULL,
	"created_at" DATE NOT NULL,
	"updated_by" int,
	"updated_at" DATE,
	"deleted_by" int,
	"deleted_at" DATE,
	CONSTRAINT "real_estate_investment_funds_administrators_pk" PRIMARY KEY ("cnpj")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "investors" ADD CONSTRAINT "investors_fk0" FOREIGN KEY ("user_id") REFERENCES "users"("id");

ALTER TABLE "accounts" ADD CONSTRAINT "accounts_fk0" FOREIGN KEY ("investor_id") REFERENCES "investors"("id");
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_fk1" FOREIGN KEY ("stock_broker_id") REFERENCES "stock_brokers"("id");


ALTER TABLE "operations_stocks" ADD CONSTRAINT "operations_stocks_fk0" FOREIGN KEY ("invoice_id") REFERENCES "invoices"("id");
ALTER TABLE "operations_stocks" ADD CONSTRAINT "operations_stocks_fk1" FOREIGN KEY ("stock_id") REFERENCES "stocks"("id");

ALTER TABLE "phones" ADD CONSTRAINT "phones_fk0" FOREIGN KEY ("investor_id") REFERENCES "investors"("id");

ALTER TABLE "invoices" ADD CONSTRAINT "invoices_fk0" FOREIGN KEY ("investor_id") REFERENCES "investors"("id");
ALTER TABLE "invoices" ADD CONSTRAINT "invoices_fk1" FOREIGN KEY ("stock_broker_id") REFERENCES "stock_brokers"("id");
ALTER TABLE "invoices" ADD CONSTRAINT "invoices_fk2" FOREIGN KEY ("clearing_id") REFERENCES "clearing"("id");
ALTER TABLE "invoices" ADD CONSTRAINT "invoices_fk3" FOREIGN KEY ("stock_market_id") REFERENCES "stock_market"("id");
ALTER TABLE "invoices" ADD CONSTRAINT "invoices_fk4" FOREIGN KEY ("operational_cost_id") REFERENCES "operational_costs"("id");


ALTER TABLE "clearing" ADD CONSTRAINT "clearing_fk0" FOREIGN KEY ("investor_id") REFERENCES "investors"("id");



ALTER TABLE "adresses" ADD CONSTRAINT "adresses_fk0" FOREIGN KEY ("investor_id") REFERENCES "investors"("id");


ALTER TABLE "stocks_opening_balance" ADD CONSTRAINT "stocks_opening_balance_fk0" FOREIGN KEY ("investor_id") REFERENCES "investors"("id");
ALTER TABLE "stocks_opening_balance" ADD CONSTRAINT "stocks_opening_balance_fk1" FOREIGN KEY ("stock_id") REFERENCES "stocks"("id");

ALTER TABLE "tds_opening_balance" ADD CONSTRAINT "tds_opening_balance_fk0" FOREIGN KEY ("investor_id") REFERENCES "investors"("id");

ALTER TABLE "real_estate_investment_funds_opening_balance" ADD CONSTRAINT "real_estate_investment_funds_opening_balance_fk0" FOREIGN KEY ("investor_id") REFERENCES "investors"("id");
ALTER TABLE "real_estate_investment_funds_opening_balance" ADD CONSTRAINT "real_estate_investment_funds_opening_balance_fk1" FOREIGN KEY ("stock_id") REFERENCES "stocks"("id");

ALTER TABLE "operations_real_estate_investment_funds" ADD CONSTRAINT "operations_real_estate_investment_funds_fk0" FOREIGN KEY ("invoice_id") REFERENCES "invoices"("id");
ALTER TABLE "operations_real_estate_investment_funds" ADD CONSTRAINT "operations_real_estate_investment_funds_fk1" FOREIGN KEY ("real_estate_investment_fund_id") REFERENCES "real_estate_investment_funds"("id");

ALTER TABLE "real_estate_investment_funds" ADD CONSTRAINT "real_estate_investment_funds_fk0" FOREIGN KEY ("real_estate_investment_funds-administrator_id") REFERENCES "real_estate_investment_funds_administrators"("id");


