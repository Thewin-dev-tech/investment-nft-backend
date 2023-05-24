
drop table IF EXISTS expenses;
drop table IF EXISTS images;
drop table IF EXISTS transactions;
drop table IF EXISTS deposits;
drop table IF EXISTS devices;
drop table IF EXISTS withdraw_details;
drop table IF EXISTS withdraws;
drop table IF EXISTS pools;
drop table IF EXISTS pool_types;
drop table IF EXISTS invoices;
drop table IF EXISTS receipts;
drop table IF EXISTS smart_contract;
drop table if EXISTS qr_codes;
drop table IF EXISTS banks;
drop table IF EXISTS orders;
drop table IF EXISTS users;

drop table IF EXISTS partners;

CREATE TABLE smart_contract(
		id int(20) AUTO_INCREMENT,
		address varchar(100) ,
		chain_id int(5),
		abi varchar(10000),
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		CONSTRAINT PRIMARY KEY(id) 
);

CREATE TABLE users (
	id int(20) auto_increment,
	citiszen_id varchar(255),
	user_no varchar(20),
	name varchar(255),
	address varchar(255),
	role int(11) , 
	remember_token varchar(100),
	wallet_public_key varchar(200),
	wallet_private_key varchar(200),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP default CURRENT_TIMESTAMP,
	CONSTRAINT user_pk PRIMARY KEY(id)	
);

create table banks (
	id int(20) auto_increment,
	user_id int(20) ,
	uuid varchar(36) ,
	bank_number varchar(20),
	bank_name varchar(255),
	bank_brnach varchar(255),
	bank_type varchar(3),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT bank_pk PRIMARY KEY(id),
	CONSTRAINT bank_user_fk FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE	
);

create table orders(
	id int(20) auto_increment,
	order_no varchar(20),
	user_id int(20) ,
	status tinyint(1),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP default CURRENT_TIMESTAMP,
	CONSTRAINT order_pk PRIMARY KEY(id),
	CONSTRAINT order_user_fk FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE	
);

create table qr_codes(
	id int(20) auto_increment,
	ref1 varchar(20) ,
	ref2 varchar(20),
	ref3 varchar(20),
	amount DECIMAL(8,2),
	qr_text varchar(255),
	qr_image varchar(10000),
	type tinyint(1),
	payment_channel varchar(4),
	user_id int(20),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP default CURRENT_TIMESTAMP,
	CONSTRAINT qr_codes_pk PRIMARY KEY(id),
	constraint qr_codes_user_fk FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE	
);

create table invoices(
	id int(20) auto_increment,
	invoice_no VARCHAR(20),
	order_id	int(20),
	price decimal(10,2),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP default CURRENT_TIMESTAMP,
	CONSTRAINT invoice_pk PRIMARY KEY(id),
	CONSTRAINT invoice_order_fk FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE	
);

create table receipts(
	id int(20) auto_increment,
	receipt_no VARCHAR(20),
	order_id	int(20),
	price decimal(10,2),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP default CURRENT_TIMESTAMP,
	CONSTRAINT receipt_pk PRIMARY KEY(id),
	CONSTRAINT receipt_order_fk FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE	
);


create table pool_types(
	id int(20) auto_increment,
	type_name varchar(100),
	service_charge int(3),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP default CURRENT_TIMESTAMP,
	CONSTRAINT pool_type_pk PRIMARY KEY(id)
);

create table pools (
	id int(20) auto_increment,
	pool_no int(20),
	nft_id int(20),
	contract_id int(20),
	name varchar(100),
	order_id int(20),
	type_id int(20),
	max_price DECIMAL(10,2),
	min_price DECIMAL(10,2),
	cap_price DECIMAL(10,2),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP default CURRENT_TIMESTAMP,
	CONSTRAINT pool_pk PRIMARY KEY(id),
	CONSTRAINT pool_smart_contract_fk FOREIGN KEY(contract_id) REFERENCES smart_contract(id)  ON DELETE CASCADE,
	CONSTRAINT pool_order_fk FOREIGN KEY(order_id) REFERENCES orders(id)  ON DELETE CASCADE	,
	CONSTRAINT pool_pool_type_fk FOREIGN KEY(type_id) REFERENCES pool_types(id) ON DELETE CASCADE	
);


create table devices(
	id int(20) auto_increment,
	pool_id int(20),
	device_id varchar(100),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP default CURRENT_TIMESTAMP,
	CONSTRAINT device_pk PRIMARY KEY(id),
	CONSTRAINT device_pool_fk FOREIGN KEY(pool_id) REFERENCES pools(id) ON DELETE CASCADE	
);

create table expenses(
		id int(20) auto_increment,
		device_id int(20),
		detail varchar(100),
		amount DECIMAL(10,2),
		created_at TIMESTAMP default CURRENT_TIMESTAMP,
		updated_at TIMESTAMP default CURRENT_TIMESTAMP,
		CONSTRAINT expeneses_pk PRIMARY KEY(id),
		CONSTRAINT expeneses_device_fk FOREIGN KEY(device_id) REFERENCES devices(id) ON DELETE CASCADE	
);

create table images(
		id int(20) auto_increment,
		device_id int(20),
		photo varchar(255),
		created_at TIMESTAMP default CURRENT_TIMESTAMP,
		updated_at TIMESTAMP default CURRENT_TIMESTAMP,
		CONSTRAINT image_pk PRIMARY KEY(id),
		CONSTRAINT image_device_fk FOREIGN KEY(device_id) REFERENCES devices(id)
);

create table transactions(
		id int(20) auto_increment,
		device_id int(20),
		total decimal(10,2),
		ref_no varchar(20),
		payment_channel_id varchar(4),
		created_at TIMESTAMP default CURRENT_TIMESTAMP,
		updated_at TIMESTAMP default CURRENT_TIMESTAMP,
		CONSTRAINT transaction_pk PRIMARY KEY(id),
		CONSTRAINT transaction_device_fk FOREIGN KEY(device_id) REFERENCES devices(id)
);

create table deposits(
		id int(20) auto_increment,
		ref_no varchar(255),
		total DECIMAL(10,2),
		status TINYINT(1),
		cut_off TINYINT(1),
		payment_channel_id varchar(4),
		pool_id int(20),
		transaction_id int(20),
		tx_hash varchar(100),
		created_at TIMESTAMP default CURRENT_TIMESTAMP,
		updated_at TIMESTAMP default CURRENT_TIMESTAMP,
		CONSTRAINT deposit_pk PRIMARY KEY(id),
		CONSTRAINT deposit_pool_fk FOREIGN KEY(pool_id) REFERENCES pools(id)
);

create table withdraws(
	id int(20) auto_increment,
	ref_no varchar(255),
	pool_id int(20),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP default CURRENT_TIMESTAMP,
	CONSTRAINT withdraw_pk PRIMARY KEY(id),
	CONSTRAINT withdraw_pool_fk FOREIGN KEY(pool_id) REFERENCES pools(id)
);

create table withdraw_details(
	id int(20) auto_increment,
	ref_no varchar(255),
	total DECIMAL(10,2),
	service_charge DECIMAL(10,2),
	withdraw_id int(20),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP default CURRENT_TIMESTAMP,
	CONSTRAINT withdraw_details_pk PRIMARY KEY(id),
	CONSTRAINT withdraw_detail_withdraw_fk FOREIGN KEY(withdraw_id) REFERENCES withdraws(id)
);

create table partners(
	id int(20) auto_increment,
	merchant_name varchar(255),
	business_type varchar(255),
	partner_id varchar(20),
	secret_key varchar(64),
	created_at TIMESTAMP default CURRENT_TIMESTAMP,
	updated_at TIMESTAMP default CURRENT_TIMESTAMP,
	CONSTRAINT partner_pk PRIMARY KEY(id)
);


