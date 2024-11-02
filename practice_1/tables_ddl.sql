CREATE TABLE calendar_dim
(
 date_id  serial NOT NULL,
 year     integer NOT NULL,
 quater   integer NOT NULL,
 month    integer NOT NULL,
 week     integer NOT NULL,
 "date"   date NOT NULL,
 week_day varchar(20) NOT NULL,
 leap     varchar(20) NOT NULL,
 CONSTRAINT PK_4 PRIMARY KEY ( date_id )
);


CREATE TABLE customer_dim
(
 cust_id       serial NOT NULL,
 customer_id   varchar(20) NOT NULL,
 customer_name varchar(50) NOT NULL,
 CONSTRAINT PK_5 PRIMARY KEY ( cust_id )
);


CREATE TABLE geo_dim
(
 geo_id      serial NOT NULL,
 country     varchar(13) NOT NULL,
 city        varchar(17) NOT NULL,
 "state"     varchar(20) NOT NULL,
 postal_code varchar(50) NOT NULL,
 CONSTRAINT PK_3 PRIMARY KEY ( geo_id )
);


CREATE TABLE product_dim
(
 prod_id      serial NOT NULL,
 product_id   varchar(15) NOT NULL,
 product_name varchar(127) NOT NULL,
 category     varchar(15) NOT NULL,
 sub_category varchar(11) NOT NULL,
 segment      varchar(11) NOT NULL,
 CONSTRAINT PK_2 PRIMARY KEY ( prod_id )
);


CREATE TABLE sales_fact
(
 sales_id      serial NOT NULL,
 ship_id       serial NOT NULL,
 prod_id       serial NOT NULL,
 geo_id        serial NOT NULL,
 date_id       serial NOT NULL,
 cust_id       serial NOT NULL,
 order_date_id date NOT NULL,
 ship_date_id  date NOT NULL,
 order_id      varchar(14) NOT NULL,
 sales         numeric(9,4) NOT NULL,
 profit        numeric(21,16) NOT NULL,
 quantity      integer NOT NULL,
 discount      numeric(4,2) NOT NULL,
 CONSTRAINT PK_6 PRIMARY KEY ( sales_id ),
 CONSTRAINT FK_1 FOREIGN KEY ( ship_id ) REFERENCES shipping_dim ( ship_id ),
 CONSTRAINT FK_5 FOREIGN KEY ( prod_id ) REFERENCES product_dim ( prod_id ),
 CONSTRAINT FK_4 FOREIGN KEY ( geo_id ) REFERENCES geo_dim ( geo_id ),
 CONSTRAINT FK_3 FOREIGN KEY ( date_id ) REFERENCES calendar_dim ( date_id ),
 CONSTRAINT FK_2 FOREIGN KEY ( cust_id ) REFERENCES customer_dim ( cust_id )
);

CREATE INDEX FK_1 ON sales_fact
(
 ship_id
);

CREATE INDEX FK_2 ON sales_fact
(
 prod_id
);

CREATE INDEX FK_3 ON sales_fact
(
 geo_id
);

CREATE INDEX FK_4 ON sales_fact
(
 date_id
);

CREATE INDEX FK_5 ON sales_fact
(
 cust_id
CREATE TABLE shipping_dim
(
 ship_id       serial NOT NULL,
 shipping_mode varchar(14) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( ship_id )
);


