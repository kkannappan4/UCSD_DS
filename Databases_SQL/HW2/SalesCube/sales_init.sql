drop table if exists state cascade;
CREATE TABLE state
(
  state_id serial primary key NOT NULL,
  state_name character varying(50) NOT NULL
);

drop table if exists category cascade;
CREATE TABLE category
(
  category_id serial primary key NOT NULL,
  category_name character varying(50) NOT NULL,
  category_desc text
);

drop table if exists product cascade;
CREATE TABLE product
(
  product_id serial primary key NOT NULL,
  product_name character varying(50) NOT NULL,
  category_id integer references category(category_id) NOT NULL,
  list_price numeric NOT NULL
);
drop table if exists customer cascade;
CREATE TABLE customer
(
  customer_id serial primary key NOT NULL,
  customer_name character varying(50) NOT NULL,
  state_id integer references state(state_id) NOT NULL
);

drop table if exists sale cascade;
CREATE TABLE sale
(
  sale_id serial primary key NOT NULL,
  customer_id integer references customer(customer_id) NOT NULL,
  product_id integer references product(product_id) NOT NULL,
  quantity integer NOT NULL,
  price numeric NOT NULL
);


INSERT INTO state VALUES (1,'California');
INSERT INTO state VALUES (2,'Arizona');
INSERT INTO state VALUES (3,'Florida');
INSERT INTO state VALUES (4,'New York');
INSERT INTO state VALUES (5,'Utah');
INSERT INTO state VALUES (6,'Texas');
INSERT INTO state VALUES (7,'Atlanta');


INSERT INTO category VALUES (1,'Sports','aaa');
INSERT INTO category VALUES (2,'Education','bbb');
INSERT INTO category VALUES (3,'Electronics','ccc');
INSERT INTO category VALUES (4,'Furniture','ddd');
INSERT INTO category VALUES (5,'Grocery','eee');
INSERT INTO category VALUES (6,'Camping','fff');
INSERT INTO category VALUES (7,'Kitchen Appliance','ggg');
INSERT INTO category VALUES (8,'Women Dress','hhh');
INSERT INTO category VALUES (9,'Men Dress','iii');
INSERT INTO category VALUES (10,'Boys Dress','jjj');
INSERT INTO category VALUES (11,'Girls Dress','kkk');
INSERT INTO category VALUES (12,'Infants','lll');
INSERT INTO category VALUES (13,'Maternity wear','mmm');
INSERT INTO category VALUES (14,'Ladies Shoes','nnn');
INSERT INTO category VALUES (15,'Gents Shoes','ooo');
INSERT INTO category VALUES (16,'Kids Shoes','ppp');
INSERT INTO category VALUES (17,'Medicines','qqq');
INSERT INTO category VALUES (18,'Vegetables','rrr');
INSERT INTO category VALUES (19,'Fruits','sss');
INSERT INTO category VALUES (20,'Accesories','ttt');
INSERT INTO category VALUES (21,'Opticals','uuu');
INSERT INTO category VALUES (22,'Hotel Supplies','vvv');
INSERT INTO category VALUES (23,'Auto parts','www');
INSERT INTO category VALUES (24,'Cleaning items','xxx');
INSERT INTO category VALUES (25,'Watches','yyy');
INSERT INTO category VALUES (26,'Entertainment','zzz');

INSERT INTO product VALUES (1,'bat',1,40);
INSERT INTO product VALUES (2,'ball',1,10);
INSERT INTO product VALUES (3,'glove',1,20);
INSERT INTO product VALUES (4,'pen',2,1.5);
INSERT INTO product VALUES (5,'book',2,50);
INSERT INTO product VALUES (6,'TV',3,500);
INSERT INTO product VALUES (7,'Laptop',3,1000);
INSERT INTO product VALUES (8,'Microwave oven',3,200);
INSERT INTO product VALUES (9,'Chair',4,100);
INSERT INTO product VALUES (10,'Desk',4,200);
INSERT INTO product VALUES (11,'Spinach',5,3.5);
INSERT INTO product VALUES (12,'Bread',5,2);
INSERT INTO product VALUES (13,'bag',1,50);
INSERT INTO product VALUES (14,'bag',6,200);
INSERT INTO product VALUES (15,'tent',1,500);
INSERT INTO product VALUES (16,'vest',1,100);
INSERT INTO product VALUES (17,'board',2,50);
INSERT INTO product VALUES (18,'Mobile phone',3,300);
INSERT INTO product VALUES (19,'Bed',4,700);
INSERT INTO product VALUES (20,'Milk',5,5);
INSERT INTO product VALUES (21,'Chains',6,50);
INSERT INTO product VALUES (22,'Cereals',5,10);
INSERT INTO product VALUES (23,'badminton kit',1,100);
INSERT INTO product VALUES (24,'Sofa',4,600);
INSERT INTO product VALUES (25,'Flour',5,20);
INSERT INTO product VALUES (26,'Toaster',7,20);
INSERT INTO product VALUES (27,'Mixer',7,50);
INSERT INTO product VALUES (28,'Tshirt',8,30);
INSERT INTO product VALUES (29,'Jeans',8,50);
INSERT INTO product VALUES (30,'Tshirt',9,30);
INSERT INTO product VALUES (31,'Jeans',9,50);
INSERT INTO product VALUES (32,'Tshirt',10,30);
INSERT INTO product VALUES (33,'Jeans',10,50);
INSERT INTO product VALUES (34,'Tshirt',11,30);
INSERT INTO product VALUES (35,'Jeans',11,50);
INSERT INTO product VALUES (36,'Sweater',12,50);
INSERT INTO product VALUES (37,'Tshirt',13,30);
INSERT INTO product VALUES (38,'shoes1',14,80);
INSERT INTO product VALUES (39,'shoes2',14,80);
INSERT INTO product VALUES (40,'shoes1',15,80);
INSERT INTO product VALUES (41,'shoes2',15,80);
INSERT INTO product VALUES (42,'shoes1',16,80);
INSERT INTO product VALUES (43,'shoes2',16,80);
INSERT INTO product VALUES (44,'aspirin',17,10);
INSERT INTO product VALUES (45,'coughsyrup',17,20);
INSERT INTO product VALUES (46,'tomato',18,5);
INSERT INTO product VALUES (47,'onion',18,3);
INSERT INTO product VALUES (48,'apple',19,5);
INSERT INTO product VALUES (49,'banana',19,3);
INSERT INTO product VALUES (50,'bracelet',20,200);
INSERT INTO product VALUES (51,'earraings',20,50);
INSERT INTO product VALUES (52,'lens',21,20);
INSERT INTO product VALUES (53,'towel',22,10);
INSERT INTO product VALUES (54,'shampoo',22,5);
INSERT INTO product VALUES (55,'tyre',23,200);
INSERT INTO product VALUES (56,'oil',23,100);
INSERT INTO product VALUES (57,'brush',24,10);
INSERT INTO product VALUES (58,'girlswatch',25,100);
INSERT INTO product VALUES (59,'Playstation',26,300);
INSERT INTO product VALUES (60,'Videogame',26,500);

INSERT INTO customer VALUES (1,'Aaron',1);
INSERT INTO customer VALUES (2,'Ben',2);
INSERT INTO customer VALUES (3,'Charles',3);
INSERT INTO customer VALUES (4,'David',6);
INSERT INTO customer VALUES (5,'Lee',6);
INSERT INTO customer VALUES (6,'John',4);
INSERT INTO customer VALUES (7,'Sheldon',7);
INSERT INTO customer VALUES (8,'Mary',5);
INSERT INTO customer VALUES (9,'Julie',3);
INSERT INTO customer VALUES (10,'Smily',5);
INSERT INTO customer VALUES (11,'Williams',4);
INSERT INTO customer VALUES (12,'Christine',1);
INSERT INTO customer VALUES (13,'Sophie',5);
INSERT INTO customer VALUES (14,'Rachel',1);
INSERT INTO customer VALUES (15,'Mike',4);
INSERT INTO customer VALUES (16,'Paul',1);
INSERT INTO customer VALUES (17,'Emily',2);
INSERT INTO customer VALUES (18,'Sofia',4);
INSERT INTO customer VALUES (19,'Nathan',3);
INSERT INTO customer VALUES (20,'Penny',1);
INSERT INTO customer VALUES (21,'Ben',4);
INSERT INTO customer VALUES (22,'Sophie',1);
INSERT INTO customer VALUES (23,'Julie',3);
INSERT INTO customer VALUES (24,'Karen',2);
INSERT INTO customer VALUES (25,'Robert',3);



INSERT INTO sale VALUES (1,1,1,2,40);
INSERT INTO sale VALUES (2,1,2,4,8);
INSERT INTO sale VALUES (3,2,3,6,20);
INSERT INTO sale VALUES (4,3,8,4,200);
INSERT INTO sale VALUES (5,4,10,3,200);
INSERT INTO sale VALUES (6,5,11,2,3);
INSERT INTO sale VALUES (7,6,6,1,500);
INSERT INTO sale VALUES (8,7,15,6,500);
INSERT INTO sale VALUES (9,8,20,8,5);
INSERT INTO sale VALUES (10,10,21,3,50);
INSERT INTO sale VALUES (11,9,18,5,300);
INSERT INTO sale VALUES (12,11,22,6,10);
INSERT INTO sale VALUES (13,12,24,2,600);
INSERT INTO sale VALUES (14,13,25,4,20);
INSERT INTO sale VALUES (15,14,12,2,2);
INSERT INTO sale VALUES (16,15,16,1,100);
INSERT INTO sale VALUES (17,17,5,5,50);
INSERT INTO sale VALUES (18,18,7,2,1000);
INSERT INTO sale VALUES (19,16,19,1,700);
INSERT INTO sale VALUES (20,19,11,2,3);
INSERT INTO sale VALUES (21,20,12,100,2);
INSERT INTO sale VALUES (22,21,4,4,1);
INSERT INTO sale VALUES (23,22,9,2,100);
INSERT INTO sale VALUES (24,23,13,1,50);
INSERT INTO sale VALUES (25,24,14,4,1);
INSERT INTO sale VALUES (26,23,14,5,1);
INSERT INTO sale VALUES (27,25,17,1,50);
INSERT INTO sale VALUES (28,13,18,2,300);
INSERT INTO sale VALUES (29,8,20,50,5);
INSERT INTO sale VALUES (30,10,7,4,1000);
INSERT INTO sale VALUES (31,9,23,3,100);
INSERT INTO sale VALUES (32,16,24,2,600);
INSERT INTO sale VALUES (33,19,25,20,20);
INSERT INTO sale VALUES (34,6,15,2,500);
INSERT INTO sale VALUES (35,12,18,2,300);
INSERT INTO sale VALUES (36,15,21,1,50);
INSERT INTO sale VALUES (37,23,22,10,10);
INSERT INTO sale VALUES (38,19,14,2,200);
INSERT INTO sale VALUES (39,3,19,1,700);
INSERT INTO sale VALUES (40,4,25,3,20);
INSERT INTO sale VALUES (41,7,4,10,1.5);
INSERT INTO sale VALUES (42,17,2,3,10);
INSERT INTO sale VALUES (43,5,22,10,10);
INSERT INTO sale VALUES (44,22,14,2,200);
INSERT INTO sale VALUES (45,25,19,1,700);
INSERT INTO sale VALUES (46,20,25,3,20);
INSERT INTO sale VALUES (47,14,4,10,1.5);
INSERT INTO sale VALUES (48,9,2,3,10);
INSERT INTO sale VALUES (49,23,4,10,1.5);
INSERT INTO sale VALUES (50,2,2,3,10);
INSERT INTO sale VALUES (51,3,26,2,20);
INSERT INTO sale VALUES (52,4,29,3,50);
INSERT INTO sale VALUES (53,5,30,3,30);
INSERT INTO sale VALUES (54,6,31,2,50);
INSERT INTO sale VALUES (55,7,32,5,30);
INSERT INTO sale VALUES (56,8,33,2,50);
INSERT INTO sale VALUES (57,9,34,3,30);
INSERT INTO sale VALUES (58,10,35,4,50);
INSERT INTO sale VALUES (59,11,36,5,50);
INSERT INTO sale VALUES (60,12,37,6,30);
INSERT INTO sale VALUES (61,16,28,5,30);
INSERT INTO sale VALUES (62,14,38,3,80);
INSERT INTO sale VALUES (63,15,39,2,80);
INSERT INTO sale VALUES (64,17,40,5,80);
INSERT INTO sale VALUES (65,18,41,3,80);
INSERT INTO sale VALUES (66,19,42,4,80);
INSERT INTO sale VALUES (67,20,43,5,80);
INSERT INTO sale VALUES (68,21,44,6,10);
INSERT INTO sale VALUES (69,22,45,7,20);
INSERT INTO sale VALUES (70,23,46,4,5);
INSERT INTO sale VALUES (71,24,47,5,3);
INSERT INTO sale VALUES (72,25,48,2,5);
INSERT INTO sale VALUES (73,1,49,1,3);
INSERT INTO sale VALUES (74,2,50,5,200);
INSERT INTO sale VALUES (75,25,27,3,50);
INSERT INTO sale VALUES (76,3,51,2,50);
INSERT INTO sale VALUES (77,4,52,4,20);
INSERT INTO sale VALUES (78,5,53,2,10);
INSERT INTO sale VALUES (79,6,54,3,5);
INSERT INTO sale VALUES (80,7,55,4,200);
INSERT INTO sale VALUES (81,8,56,5,100);
INSERT INTO sale VALUES (82,9,57,3,10);
INSERT INTO sale VALUES (83,10,58,2,100);
INSERT INTO sale VALUES (84,11,59,1,300);
INSERT INTO sale VALUES (85,12,60,4,500);
INSERT INTO sale VALUES (86,19,42,4,80);
INSERT INTO sale VALUES (87,20,43,5,80);
INSERT INTO sale VALUES (88,21,44,6,10);
INSERT INTO sale VALUES (89,22,45,7,20);
INSERT INTO sale VALUES (90,23,46,4,5);
INSERT INTO sale VALUES (91,24,47,5,3);
INSERT INTO sale VALUES (92,25,48,2,5);
INSERT INTO sale VALUES (93,11,49,1,3);
INSERT INTO sale VALUES (94,12,50,5,200);
INSERT INTO sale VALUES (95,25,27,3,50);
INSERT INTO sale VALUES (96,13,51,2,50);
INSERT INTO sale VALUES (97,14,52,4,20);
INSERT INTO sale VALUES (98,15,53,2,10);
INSERT INTO sale VALUES (99,16,54,3,5);
INSERT INTO sale VALUES (100,17,55,4,200);
INSERT INTO sale VALUES (101,18,56,5,100);
INSERT INTO sale VALUES (102,19,57,3,10);
INSERT INTO sale VALUES (103,10,58,2,100);
INSERT INTO sale VALUES (104,11,59,1,300);
INSERT INTO sale VALUES (105,12,60,4,500);