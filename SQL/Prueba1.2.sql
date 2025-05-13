-- EXAMEN DE SQL – MODELO B
-- DURACIÓN: 90 MINUTOS – TOTAL: 10 PUNTOS

--------------------------------------------------------------------------------
1. DEFINICIONES SQL  
(5 preguntas tipo test, 1 punto total, 0,2 cada una)

1.1 ¿Cuál de estos comandos se usa para iniciar una transacción manualmente?  
    A) BEGIN TRANSACTION   B) START SESSION  
    C) COMMIT               D) ROLLBACK  
    A

1.2 ¿A qué categoría pertenece el comando ALTER INDEX?  
    A) DML   B) DQL   C) DDL   D) DCL  
    C

1.3 ¿Qué hace el comando RENAME TABLE antiguo TO nuevo?  
    A) Crea una copia de la tabla  
    B) Cambia el nombre de la tabla  
    C) Elimina la tabla antigua y crea una nueva  
    D) Migra datos a otra base  
    B
 
1.4 El comando SHOW COLUMNS FROM tabla; se clasifica dentro de:  
    A) DDL   B) DML   C) DCL   D) DQL  
    D

1.5 ¿Qué sentencia revierte cambios de datos hechos durante una transacción?  
    A) ROLLBACK   B) UNDO   C) CANCEL   D) REVERT  

    D --> A

--------------------------------------------------------------------------------
2. DDL  
(8 preguntas: 3 tipo test + 5 prácticas, total: 2 puntos)

**Tipo test (0,5 puntos total)**  
2.1 ¿Qué comando modifica la definición de una columna existente?  
    A) CHANGE COLUMN   B) ALTER TABLE  
    C) MODIFY TABLE   D) UPDATE TABLE  
    A --> b 

2.2 ¿Qué hace DROP INDEX idx_producto ON inventario;?  
    A) Elimina la columna idx_producto  
    B) Elimina el índice llamado idx_producto  
    C) Vacía la tabla inventario  
    D) Renombra el índice  
    B

2.3 ¿Cuál es el efecto de TRUNCATE TABLE pedidos;?  
    A) Elimina la tabla pedidos  
    B) Vacía todas las filas de pedidos  
    C) Elimina el esquema pedidos  
    D) Resetea la definición de la tabla  
    B

**Prácticas (0,3 puntos cada una)**  
2.4 Crea la base de datos `almacenes` y la tabla `proveedores` con campos:  
    id INT, nombre VARCHAR(100), contacto VARCHAR(100), fecha date.  
    create database almacenes;
    create table proveedores(id INT unsigned, nombre VARCHAR(100), contacto VARCHAR(100), fecha date);


2.5 Añade la columna `ciudad` (VARCHAR(50)) a `proveedores`.  
    alter table proveedores add column ciudad varchar(50);

2.6 Cambia el tipo de `contacto` a TEXT en `proveedores`.  
    alter table proveedores modify contacto text;

2.7 Renombra la tabla `proveedores` a `proveedores_activos`.  
    alter table proveedores rename proveedores to proveedores_activos;
    --> alter table proveedores rename to proveedores_activos;

2.8 Elimina la columna `ciudad` de `proveedores_activos`.  
    drop column ciudad from proveedores_activos;
    --> alter table proveedores_activos drop column ciudad;

--------------------------------------------------------------------------------
3. DML  
(10 ejercicios prácticos, 2,5 puntos total, 0,25 cada uno)

Se usa la tabla `inventario`:

```sql
CREATE TABLE inventario (
  id INT AUTO_INCREMENT PRIMARY KEY,
  articulo VARCHAR(50),
  stock INT,
  precio DECIMAL(6,2),
  fecha_ingreso DATE
);

3.1 Inserta un artículo “monitor” con stock 10, precio 129.50, fecha_ingreso ‘2024-05-01’.
    insert into inventario(id, articulo, stock, precio, fecha ingreso) values (1, 'monitor', 10,  129.5, '2024-05-01');

3.2 Inserta otros dos artículos (elige tus propias descripciones).
    insert into inventario(2, 'teclado', 100,  29.5, '2025-05-01'),
    insert into inventario(3, 'cpu', 12,  1129.5, '2025-03-01'); 

3.3 Incrementa el stock en 5 unidades para id = 1.
    update inventario set stock = stock += 5  where id = 1;

3.4 Reduce el precio a 99.99 donde articulo = 'monitor'.
    update inventario set price = 99.99 where articulo = 'monitor';

3.5 Elimina el registro con id = 3.
    delete from inventario where id = 3;

3.6 Elimina todos los artículos con stock = 0.
    delete from inventario where stock = 0;

3.7 Inserta “teclado”, “ratón” y “impresora” en un solo INSERT múltiple.
    insert into inventario values(4, 'teclado', 32, 11.11, '2020-02-02'),
                                  (5, 'raton', 22, 45.45, '2020-03-03'),
                                  (6, 'impresora', 44, 99.99, '2020-08-02');

3.8 Aumenta el precio un 15 % a todos los artículos.
    update inventario set price = price * 1.15;

3.9 Disminuye el stock en 1 unidad si stock > 20.
    update inventario set stock = stock -1 where stock > 20;

3.10 Elimina los registros con fecha_ingreso anterior a ‘2023-01-01’.
    delete from inventario where fecha_ingreso < '2023-01-01';

4 DQL
(15 ejercicios prácticos, 3,5 puntos total, ~0,23 cada uno)

Tabla clientes:

id_cliente	nombre	edad	ciudad	fecha_registro	activo
…	…	…	…	…	…

4.1 Muestra nombre, ciudad y activo.
    select nombre, ciudad, activo from clientes;

4.2 Lista las ciudades únicas de los clientes.
    select distinct ciudad from clientes;

4.3 Selecciona todos los clientes mayores de 30 años.
    select * from clientes where edad > 30;

4.4 Clientes registrados entre ‘2024-01-01’ y ‘2024-12-31’.
    select * from clientes where fecha_registro between ‘2024-01-01’ and ‘2024-12-31’;

4.5 Clientes que viven en ‘Madrid’ o ‘Barcelona’.
    select *from clientes where ciudad in(‘Madrid’,‘Barcelona’);

4.6 Edad entre 18 y 25 años.
    select *from clientes where edad between 18 and 25;

4.7 Nombre que termine en “a”.
    select * from clientes where nombre like '%a';

4.8 Cuenta el total de clientes.
    select count(*) from clientes;

4.9 Calcula la edad promedio.
    select avg(edad) from clientes;

4.10 Edad máxima y mínima.
    select max(edad), min(edad) from clientes;

4.11 Agrupa por ciudad y cuenta clientes por ciudad.
    select ciudad, count(*) from clientes group by ciudad;

4.12 Muestra solo las ciudades con más de 5 clientes.
    select count(*) from clientes group by ciudad having count(*) > 5;

4.13 Ordena los resultados por fecha_registro descendente.
    select *from clientes order by fecha_registro desc;

4.14 Muestra los 5 clientes con mayor edad.
    select * from clientes order by edad desc limit 5;

4.15 Ordena por ciudad ascendente y luego por nombre ascendente.
    select * from clientes order by ciudad asc, nombre asc;



DCL
(5 preguntas tipo test, 1 punto total, 0,2 cada una)

5.1 ¿Cuál de estos es un comando DCL?
A) INSERT B) COMMIT C) GRANT D) SELECT
C

5.2 ¿Qué comando elimina completamente un usuario de la base de datos?
A) DELETE USER B) DROP USER
C) REVOKE USER D) REMOVE USER
B

5.3 ¿Qué hace REVOKE SELECT ON db.tabla TO ‘user’; ?
A) Otorga SELECT a user
B) Revoca SELECT de user
C) Elimina user
D) Muestra permisos de user
B

5.4 ¿Qué devuelve SHOW GRANTS FOR ‘user’@’localhost’; ?
A) Lista de tablas B) Lista de roles
C) Lista de privilegios asignados D) Lista de sesiones
C

5.5 ¿Qué cláusula permite a un usuario conceder a su vez sus privilegios a otros?
A) WITH GRANT OPTION B) AS DELEGATE
C) GRANT PERMISSION D) ALLOW DELEGATION
D