USE proyecto;

INSERT INTO marca (nombre) VALUES 
('Apple'),  
('Nokia'), 
('Xiaomi'), 
('Huawei'), 
('Samsung');

INSERT INTO movil (nombre, marca, precio_venta, precio_compra, fecha_lanzamiento) 
VALUES ('iPhone 7 Plus', 1, 799.99, 399.99, '2016-07-10'),
       ('iPhone 11', 1, 999.99, 699.99, '2019-09-20'),
       ('Nokia 8', 2, 499.99, 299.99, '2017-08-16'),
       ('Nokia 7.2', 2, 349.99, 249.99, '2019-09-05'),
       ('Xiaomi Mi 10', 3, 699.99, 499.99, '2020-02-14'),
       ('Xiaomi Redmi Note 8', 3, 249.99, 199.99, '2019-08-29'),
       ('Huawei P30 Pro', 4, 899.99, 699.99, '2019-03-26'),
       ('Huawei Mate 20 Pro', 4, 799.99, 599.99, '2018-10-16'),
       ('Samsung Galaxy S9', 5, 699.99, 499.99, '2018-03-16'),
       ('Samsung Galaxy S20', 5, 999.99, 799.99, '2020-03-06');
       
INSERT INTO pais (nombre) VALUES 
('Estados Unidos'), 
('China'), 
('India'), 
('Alemania'), 
('Japón');

INSERT INTO fabrica (nombre, pais) VALUES 
('Apple Manufacturing Plant', 1),
('Huawei Pekin Electronics Plant', 2),
('Samsung India Electronics Pvt. Ltd.', 3),
('Nokia Group Plant Berlin', 4),
('Xiaomi Manufacturing Group Plant', 5);

INSERT INTO procedencia VALUES
(1,1),
(1,2),
(4,3),
(4,4),
(5,5),
(5,6),
(2,7),
(2,8),
(3,9),
(3,10);

SELECT * FROM fabrica;

SET SQL_SAFE_UPDATES = 0;

UPDATE pais
SET nombre='Bahrat'
WHERE nombre='India';

DELETE FROM fabrica
WHERE nombre='Xiaomi Manufacturing Group Plant';

SET SQL_SAFE_UPDATES = 1;


