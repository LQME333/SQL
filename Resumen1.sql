/*
===========================================================

Indice(SQL en linux)
    1_Definiciones
    2_DDL
        2.1_DDL operaciones
        2.2_DDL consulta
        2.3_DDL tipo de datos
        2.4_DDL modificacion

===========================================================
*/



/*
===========================================================
1_Definiciones
    DDL(Lenguaje de definición de datos) --> Crea y estructura objetos de base de datos.
    DML(Lenguaje de manipulación de datos) --> Inserta, actualiza o borra datos.
    DQL(Lenguaje de consulta de datos) --> Consulta datos
    DCL(Lenguaje de control de datos) --> Gestiona permisos
*/



/*
============================================================================
2.1_DDL operaciones

    - SHOW DATABASES; --> Ver todas las bases de datos
    - SELECT DATABASE(); --> ver la base de datos actual
    - Crear base de datos: 
        CREATE DATABASE [IF NOT EXISTS] ???
        [DEFAULT CHARSET conjunto_caracteres]
        [COLLATE regla_ordenación];
     - DROP DATABASE [IF EXISTS] ???;
    -USE ???; --> usar bd

*/

SELECT 'Ejemplo:  -----';
create database if not exists bd1 
default charset = utf8mb4 
collate = utf8mb4_spanish_ci; /*con esto creamos la bd*/
use bd1;  /*seleccionamos bd1*/
select database();  
/*vemos que estamos en bd1
+------------+
| database() |
+------------+
| bd1        |
+------------+
*/
drop database if exists bd1;
select database();  
/*
+------------+
| database() |
+------------+
| NULL       |
+------------+
*/
exit; 

/*
==============================================================================
2.2_DDL consulta

    - SHOW TABLES; --> consultar las tablas de nuestra bd
    - DESC ???c --> ver la estructura de la tabla
    - SHOW CREATE TABLE ???; --> muestra el codigo que se uso para crear la tabla
    - CREATE TABLE nombre_tabla (
        campo1 tipo1 [COMMENT 'comentario1 '],
        campo2 tipo2 [COMMENT 'comentario2 '],
        ...
        campoN tipoN [COMMENT 'comentario del campoN']
      ) [COMMENT = 'comentario de la tabla'];

*/

create database if not exists bd1;
use bd1;
create table empleados(
    id int comment 'identificacion',
    name varchar(20) comment 'nombre',
    age int comment 'edad',
    sexo char(1) comment 'm o f '
)comment = 'empleados';
show tables;
/*
+---------------+
| Tables_in_bd1 |
+---------------+
| empleados     |
+---------------+
*/
desc empleados;
/*
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int         | YES  |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
| age   | int         | YES  |     | NULL    |       |
| sexo  | char(1)     | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
*/
show create table empleados;
/*
| empleados | CREATE TABLE `empleados` (
  `id` int DEFAULT NULL COMMENT 'identificacion',
  `name` varchar(20) DEFAULT NULL COMMENT 'nombre',
  `age` int DEFAULT NULL COMMENT 'edad',
  `sexo` char(1) DEFAULT NULL COMMENT 'm o f '
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='empleados' |

*/


/*
==============================================================================
2.3_DDL tipo de datos(unsigned)
    String: 
        CHAR(0-255)fijos    VARCHAR,variables
        TINYTEXT(0-255)
        TEXT(0-2¹⁶)
    Numeros:
        TINYINT(0-255)
        INT/INTEGER(0-2³²)
        FLOAT(4bytes)
        DOUBLE(8bytes)
        DECIMAL(x,y) --> 409.66 = 5numeros+2decimales --> (5,2)
    Tiempo:
        DATE(3bytes)       YYYY-MM-DD              1000-01-01 a 9999-12-31
        TIME(3bytes)       HH:MM:SS                -838.59.59 a 838.59.59
        YEAR(1byte)        YYYY                    1901 a 2155
        DATETIME(8bytes)   YYYY-MM-DD HH:MM:SS     1000-01-01 00:00:00 a 9999-12-31 23:59:59
        TIMESTAMP(4bytes)  YYYY-MM-DD HH:MM:SS     1970-01-01 00:00:01 a 2038-01-19 03:14:07

*/

/*tabla de empleados, con codigo, id, nombre,genero, edad, 
    dni(18 caracteres), dia de contratacion*/

use bd1;
create table empleados2(
    codigo int unsigned,
    id char(10),
    name varchar(20),
    genero char(1), /*m o f*/
    edad tinyint unsigned,
    dni varchar(18),
    fecha date
);
desc empleados2;
 /*
 +--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| codigo | int         | YES  |     | NULL    |       |
| id     | char(10)    | YES  |     | NULL    |       |
| name   | varchar(20) | YES  |     | NULL    |       |
| genero | char(1)     | YES  |     | NULL    |       |
| edad   | tinyint     | YES  |     | NULL    |       |
| dni    | varchar(18) | YES  |     | NULL    |       |
| fecha  | date        | YES  |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
 */


 /*
==================================================================================================
2.4_DDL modificacion
    - ALTER TABLE ??? ADD ??? TYPE 'COMMENT' RESTRICCION; --> añadir
    - ALTER TABLE ??? MODIFY ??? TYPE; --> modificar tipo de dato
    - ALTER TABLE ??? CHANGE ???original ???nuevo TYPE 'COMMENT' RESTRICCION; --> modificar
    - ALTER TABLE ??? DROP ???; --> eliminar
    - ALTER TABLE ??? RENAME TO ???; --> cambia nombre de la tabla?
    - DROP TABLE [IF EXISTS] ??? -->  eliminar tabla entera
    - TRUNCATE TABLE ??? --> reiniciar tabla
    - ALTER TABLE ??? DROP COLUMN ???;


*/

/*VAMOS A CAMBIAR EN TABLA EMPLEADOS2 EL NAME*/
use bd1;
alter table empleados2 add nike varchar(20);
desc empleados2;
/*
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| codigo | int         | YES  |     | NULL    |       |
| id     | char(10)    | YES  |     | NULL    |       |
| name   | varchar(20) | YES  |     | NULL    |       |
| genero | char(1)     | YES  |     | NULL    |       |
| edad   | tinyint     | YES  |     | NULL    |       |
| dni    | varchar(18) | YES  |     | NULL    |       |
| fecha  | date        | YES  |     | NULL    |       |
| nike   | varchar(20) | YES  |     | NULL    |       | <----
+--------+-------------+------+-----+---------+-------+
*/
alter table empleados2 modify nike varchar(30);
desc empleados2;
/*
| nike   | varchar(30) | YES  |     | NULL    |       |
*/

alter table empleados2 change nike ana varchar(15);
desc empleados2;
/*
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| fecha  | date        | YES  |     | NULL    |       |
.......................................................
| ana    | varchar(15) | YES  |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
*/
alter table empleados2 drop ana;
desc empleados2;

alter table empleados2 rename to empleados3;
show tables;
/*
+---------------+
| Tables_in_bd1 |
+---------------+
| empleados     |
| empleados3    |
+---------------+
*/

drop table if exists empleados;
show tables;
/*
+---------------+
| Tables_in_bd1 |
+---------------+
| empleados3    |
+---------------+
*/

use bd1;
create table tablax(
    id char(5)
);
desc tablax;
alter table tablax drop column pepe;
desc tablax;
/*
+-------+---------+------+-----+---------+-------+
| Field | Type    | Null | Key | Default | Extra |
+-------+---------+------+-----+---------+-------+
| id    | char(5) | YES  |     | NULL    |       |
+-------+---------+------+-----+---------+-------+
*/