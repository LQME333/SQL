/*1. DEFINICIONES SQL
1. DEFINICIONES SQL - (5 preguntas tipo test, 1 punto total, 0.2 cada una)


1.1 ¿Qué lenguaje se utiliza para otorgar permisos a un usuario?
A) DDL B) DCL C) DML D) DQL
    B

1.2 ¿Qué hace el comando DROP TABLE?
A) Crea una tabla nueva B) Modifica una tabla C) Elimina una tabla D) Inserta datos
    C

1.3 ¿Cuál de estos comandos es parte del DML?
A) SELECT B) UPDATE C) CREATE D) GRANT
    C--->B

1.4 El comando SHOW TABLES; pertenece a:
A) DML B) DQL C) DCL D) DDL
    D--->B
    
1.5 ¿Qué comando muestra la estructura de una tabla?
A) SHOW DATABASES B) DESC C) ALTER D) SELECT *
    B


---------------------------------------------------------------------------------------

2. DDL
2. DDL - (8 preguntas: 3 tipo test + 5 prácticas, total: 1.5 puntos)

Tipo test (0.5 puntos total)

2.1 ¿Cuál comando crea una tabla en SQL?
A) MAKE TABLE B) BUILD TABLE C) CREATE TABLE D) INIT TABLE
    C

2.2 ¿Qué hace ALTER TABLE empleados DROP columna1?
A) Borra la tabla B) Elimina una columna C) Cambia el nombre D) Añade columna
    B

2.3 ¿Qué hace TRUNCATE TABLE productos?
A) Borra BD B) Vacía la tabla C) Borra fila D) Muestra datos
    B


Prácticas (0.3 puntos cada una)

2.4 Crea BD empresa_bd y tabla clientes con: id, nombre, correo, fecha_registro, comentario
    CREATE DATABASE empresa_bd;
    CREATE TABLE clientes(id varchar(10), nombre varchar(10), correo varchar(30), fecha_registro date, comentario varchar(50));

2.5 Añade columna telefono a clientes
    alter clientes add telefono tinyint unsigned;
    ---> ALTER TABLE clientes ADD COLUMN telefono

2.6 Cambia tipo de correo a text
    alter clientes modify correo text;
    ---> ALTER TABLE clientes MODIFY COLUMN correo text

2.7 Renombra clientes a clientes_registrados
    alter clientes rename to clientes_registrados;
    ---> ALTER TABLE clientes RENAME TO clientes_registrados;

2.8 Elimina columna telefono
    alter drop column telefono;
    ---> ALTER TABLE clientes_registrados DROP COLUMN telefono;

-------------------------------------------------------------------------------------

3. DML
3. DML - (10 ejercicios prácticos, 2.5 puntos total, 0.25 cada uno)

Usar tabla 'ventas'
    CREATE TABLE ventas (
        id INT AUTO_INCREMENT PRIMARY KEY,
        producto VARCHAR(50),
        cantidad INT,
        precio_unitario DECIMAL(5,2),
        fecha_venta DATE
    );

3.1 Inserta una venta de teclado, 3u, 19.99EUR, 2023-02-15
    insert into ventas(id, producto, cantidad, precio_unitario, fecha_venta) values
                      (1, 'teclado', 3, 19.99, '2023-02-15');

3.2 Inserta 2 ventas más
    insert into ventas(id, producto, cantidad, precio_unitario, fecha_venta) values
                      (2, 'teclado', 2, 9.99, '2023-03-15'),
                      (3, 'raton', 1, 12.99, '2023-02-16');


3.3 Cambia cantidad a 5 para id=1
    alter ventas cantidad = 4 where id = 1;
    ---> UPDATE ventas SET cantidad = 5 WHERE id = 1;

3.4 Precio a 12.5 donde producto=ratón
    alter ventas price = 12.5 where producto = 'raton';
    ---> UPDATE Ventas SET precio_unitario = 12.5 WHERE producto = 'raton';

3.5 Elimina venta con id=3
    drop ventas where id = 3;
    ---> DELETE FROM ventas WHERE id = 3;

3.6 Elimina ventas de producto pantalla
    drop ventas where producto = 'pantalla';
    ---> DELETE FROM ventas WHERE producto = 'pantalla';

3.7 Inserta USB, cargador, monitor en una sola sentencia
    insert into ventas(id, producto, cantidad, precio_unitario, fecha_venta) values
                      (4, 'USB', 2, 19.99, '2023-03-19'),
                      (5, 'cargador', 7, 22.99, '2025-02-16'),
                      (6, 'monitor', 4, 152.99, '2024-02-16');


3.8 Aumenta precio 10%
    alter ventas price = price * 1.1;
    ---> UPDATE ventas SET precio = precio * 1.1;

3.9 Resta 1 a cantidad si >10
    alter ventas cantidad -1 where cantidad > 10;
    ---> UPDATE ventas SET cantidad = cantidad -1 WHERE cantidad > 10;
3.10 Elimina ventas antes de 2022
    drop ventas where date < 2022;
    ---> DELETE FROM ventas WHERE fecha ventas < '2022-01-01';

---------------------------------------------------------------------------

4. DQL - (15 ejercicios prácticos, 3.5 puntos total, ~0.233 cada uno)


4.1 Mostrar producto, cantidad, precio
    select producto, cantidad, precio from ventas;

4.2 Mostrar productos únicos
    select productos from ventas group by productos;
    ---> select distinct producto from ventas

4.3 Precio > 20
    select price from ventas where precio > 20;

4.4 Fechas entre 2022-01-01 y 2023-01-01
    select date from ventas where date < '2022-01-01' and date > '2023-01-01';
    ---> select *from ventas  where fecha between '2022-01-01' and '2023-01-01';

4.5 Producto monitor o ratón
    ---> select producto for ventas where producto in('monitor','ratón');

4.6 Precio entre 10 y 30
    select price from ventas where price between 10 and 30;

4.7 Producto termina en "r"
    select productos from ventas where producto like '%r';

4.8 Total de registros
    select count(*) from ventas;

4.9 Precio promedio
    select avg(precio) from ventas;

4.10 Precio max y min
    select max(precio), min(price) from ventas;

4.11 Agrupar por producto y sumar cantidad
    select producto, sum(cantidad) from ventas group by producto;

4.12 Productos con >2 ventas
    select producto, count(*) from ventas group by producto having count(*) > 2;

4.13 Ordenar por fecha DESC
    select producto, fecha from ventas order by fecha desc;

4.14 Top 5 cantidad
    select producto, cantidad from ventas order by cantidad desc limit 5;

4.15 Ordenar por precio y fecha ASC
    select producto, precio, fecha from ventas order by precio, fecha;


----------------------------------------------------------------------------

5. DCL
5. DCL - (5 preguntas tipo test, 1 punto total, 0.2 cada una)

5.1 ¿Qué hace GRANT?
A) Modifica tabla B) Da permisos C) Elimina usuario D) Muestra tablas
    B

5.2 ¿Comando correcto para crear usuario?
A) ADD USER B) CREATE USER C) NEW USER D) MAKE USER
    B

5.3 ¿Qué hace REVOKE?
A) Da permisos B) Elimina tabla C) Quita permisos D) Reinicia tabla
    C

5.4 ¿Qué hace SHOW GRANTS FOR 'usuario'@'localhost'?
A) Ver tablas B) Ver permisos C) Borrar usuario D) Crear permisos
    B

5.5 ¿Diferencia entre GRANT ON bd1.* y GRANT ON *.*?
A) Una BD vs todas B) Igual C) Solo root D) Borra BD
 A
*/

/*
======================================================================================================

*/