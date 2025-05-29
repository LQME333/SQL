/*
==========================================================================================

Indice(SQL en linux)
    1_Definiciones
    2_DDL
        2.1_DDL operaciones
        2.2_DDL consulta
        2.3_DDL tipo de datos
        2.4_DDL modificacion
    3_DML  <<-----------------------------
        3.1_INSERT, UPDATE, DELETE
    4_DQL
        4.1_ESTRUCTURA

============================================================================================
*/

/* 
Más adelante usaremos DATAGRIP para MYSQL
*/

/*
=============================================================================================
3.1_INSERT, UPDATE, DELETE

    - INSERT INTO ???(???,???...) VALUES(???,???...);  añadir dato especifico
    - INSERT INTO ??? VALUES(???,???...); añadir dato para todo el campo
    añadir multiples filas de fatos
        - INSERT INTO ???(???,???,...) VALUES(???,???,...),(???,???,...),....
        - INSERT INTO ??? VALUES(???,???,...),(???,???,...),....

    - UPDATE ??? SET ?=?, ??=??,...[WHERE CONDICION];
    - DELETE FROM ??? [condicion];

*/

/*
BD1 --> console 
*/
    insert into empleados3(codigo, id, name, genero, edad, dni, fecha) values (1, 1234567890, 'pepa', 'f', 44, '56756788XT', '1999-09-07');
    insert into empleados3 values(2, '1111111111', 'pepe', 'm', 18, '787788ULTRS', '2000-04-21');
    insert into empleados3 values(2, '1111111111', 'pepe', 'm', 18, '787788ULTRS', '2000-04-21'),
                                 (3, '2222222222', 'pepe2', 'm', 18, '787788PRO', '2010-04-20'),
                                 (4, '3333333333', 'pepe3', 'f', 30, '787788LITE', '2000-07-21');
    
    update empleados3 set name='ana', id=100 where name='pepe3'; /*cambiamos datos*/
    update empleados3 set genero='f', name='juana' where name='pepe';
    update empleados3 set fecha ='2009-10-01';

    delete from empleados3 where edad > 40;
    delete from empleados3 WHERE codigo IS NOT NULL limit 1;  /*eliminar la fila1*/

/*
=============================================================================================
4.1_ESTRUCTURA ejecucuion

    SELECT lista_campo    --> nombre/categoria/precio
    FROM lista_tablas     --> productos
    WHERE lista_condiciones         --> precio>30
    GROUP BY campo_agrupacion       --> categoria
    HAVING condicion_grupo          --> COUNT(*5) > 5 (mostrar grupos que tienen > 5 productos)
    ORDER BY lista_campos_ordenar   --> precio
    LIMIT parametros_paginacion     --> 10

    SELECT ???,???,...FROM ???; --> consulta varios campos
    SELECT * FROM ???;  
        
    SELECT ???[AS ???], ???[AS ???], ...;  --> asignar nomobres temporales(no cambiar)
    SELECT DISTINCT ??? FROM ???; --> eliminar duplicados

*/

    create table empleadosx(
        id int,
        code varchar(10),
        name varchar(10),
        gender char,
        age tinyint unsigned,
        dni char(5),
        address varchar(50),
        fecha date
    );

    INSERT INTO empleadosx(id, code, name, gender, age, dni, address, fecha)
    VALUES
        (1, '111X', 'ANA', 'F', 18, '1111P', 'CALLE1', '2001-01-14'),
        (2, '222X', 'JUAN', 'M', 19, '2222P', 'CALLE2', '2002-01-15'),
        (3, '333X', 'LOLA', 'F', 20, '3333P', 'CALLE3', '2003-01-16'),
        (4, '444X', 'TOMAS', 'M', 21, '4444P', 'CALLE4', '2004-01-17'),
        (5, '555X', 'ADRIAN', 'M', 22, '5555P', 'CALLE5', '2005-01-18'),
        (6, '666X', 'CARLOTA', 'F', 23, '6666P', 'CALLE6', '2006-01-19'),
        (7, '777X', 'ANDRES', 'M', 24, '7777P', 'CALLE7', '2007-01-20'),
        (8, '888X', 'ZOE', 'F', 25, '8888P', 'CALLE8', '2008-01-21'),
        (9, '999X', 'JUANA', 'F', 26, '9999P', 'CALLE9', '2009-01-22'),
        (10, '101010X', 'ENRIQUE', 'M', 27, '1010P', 'CALLE10', '2010-01-23'),
        (11, '111111X', 'TEO', 'M', 28, '1111P', 'CALLE11', '2011-01-24'),
        (12, '121212X', 'MATEO', 'M', 29, '1212P', 'CALLE12', '2012-01-25'),
        (13, '131313X', 'MATEU', 'M', 30, '1313P', 'CALLE13', '2013-01-26'),
        (14, '141414X', 'LUCIA', 'F', 31, '1414P', 'CALLE14', '2014-01-27'),
        (15, '151515X', 'PABLO', 'M', 32, '1515P', 'CALLE15', '2015-01-28'),
        (16, '161616X', 'ZENS', 'F', 33, '1616P', 'CALLE16', '2016-01-29'),
        (17, '171717X', 'PEPA', 'F', 34, '1717P', 'CALLE17', '2017-01-30'),
        (18, '181818X', 'JORK', 'M', 35, '1818P', 'CALLE18', '2018-01-31'),
        (19, '191919X', 'TERESA', 'F', 36, '1919P', 'CALLE19', '2019-02-01'),
        (20, '202020X', 'TINA', 'F', 37, '2020P', 'CALLE20', '2020-02-02');
        
    select name, age, gender from empleadosx;
    select id, code, name, gender, age, dni, address, fecha from empleadosx; /*imprime todo*/
    select *from empleadosx; /*imprime todo*/
    /*
        name age gender
        ANA, 18, F
        JUAN,19, M
        LOLA,20, F
        TOMAS,21,M
        ADRIAN,22,M
    */
    select address as 'lugar de trabajo' from empleadosx; /*address --> lugar de trabajo*/
    select address 'lugar de trabajo' from empleadosx;
    select distinct address from empleadosx; /*muestra solo los que existen sin repetir*/

    /*
        Condiciones: < > >= <= =, <> o !=, AND o &&, OR o ||, NOT o !,
                    BETWEEN...AND, IN(...), LIKE, IS NULL
        
        Ejercicio:
            1_Consultar empleados mayor de 8 años
            2_COnsultar empleados de menos de 20 años
            3_COnsultar empleados de 20 años
            4_COnsultar empleados que no tengan dni
            5_COnsultar empleados que tengan dni
            6_consultar empleados que no tengan 88 años
            7_consultar empleados entre 15 y 20 años
            8_COnsultar empleados mujeres y tengan menos de 25 años
            9_COnsultar empleados que tengan 18,20,40 años
            10_COnsultar empleados con 2 letras de nombre
            11_COnsultar empleados con P en la ultima letra dni
    */

        select * from empleadosx where age > 8;
        select * from empleadosx where age < 20 ;
        select * from empleadosx where age = 20 ;
        select * from empleadosx where dni is null;
        select * from empleadosx where dni is not null;
        select * from empleadosx where age != 88; /*age <> 88*/
        select * from empleadosx where age between 15 and 20; /*age<20 && age>15 */ /*&&*/
        select * from empleadosx where gender = 'F' && age < 25;
        select * from empleadosx where age in(18,20,40); /*age=18 && ||=20 || age=40*/ 
        select * from empleadosx where name like '__';
        select * from empleadosx where dni like '%P'; /*___...P*/



    /*
        Funciones: count, max, min, avg, sum --> afectan a columnas
    
        Ejercicio:
            1_contar los empleados totales
            2_edad media de empleados
            3_edad mas grande
            4_edad mas pequeña
            5_edad media de mujeres
    
    */

        select count(*) from empleadosx;
        select count(id) from empleadosx;
        select avg(age) from empleadosx;
        select max(age) from empleadosx;
        select min(age) from empleadosx;
        select sum(age) from empleadosx where gender = 'F';

    /*
        WHERE --> antes de agrupar
        HAVING --> despues de agrupar
        orden: WHERE, GROUP BY, HAVING

        Ejercicio: 
            1_contar mediante genero, los empleados hombres y mujeres que hay
            2_contar mediante genero, la edad media de hombres y mujeres
            3_contar los empleados menor de 45 años cuyo trabajan mas de 1 empleados en el mismo sitio
    
    */

        select count(*) from empleadosx group by gender; /*10,10*/
        select gender, count(*) from empleadosx group by gender; /*F10, M10*/

        select gender, avg(age) from empleadosx group by gender;    

        select address, count(*) from empleadosx where age <45 group by address ; /*imprime los que hay*/
        select address, count(*) from empleadosx where age <45 group by address having count(*) >=2 ; /*2*/
        select address, count(*) direccion from empleadosx where age <45 group by address having direccion >=2 ; /*2*/


    /*
        Ordenar: SELECT ??? FROM ??? ORDER BY ? ?, ? ?,...;
                - ASC CRECIENTE
                - DESC DECRECIENTE

        Ejercicio: 
            1_ordenar empleados con edad de mayor a menor
            2_ordenar de reciente a antiguo la fecha de empleados
            3_ordenar crecientemente por edad y luego por fecha
    
    */

        select * from empleadosx order by age; /*ascendente por defecto*/
        select * from empleadosx order by age desc;
        select id, name, age from empleadosx order by age desc;

        select id, name, fecha from empleadosx order by fecha;

        select * from empleadosx order by age, fecha desc;

    /*
        Indice: SELECT ??? FROM ??? LIMIT indice_inicio, cantidad_registro;
            - EL indice comienza en 0
            - Si se consulta la 1ºpagina se omite indice
    
        Ejercicio: 
            1_pagina1 10 items
            2_pagina2 10 items

    */
        select * from empleadosx limit 0,10; /*0=pagina1 y 10 los items*/
        select * from empleadosx limit 10; /*0=pagina1 y 10 los items*/
        select * from empleadosx limit 10,10; 

    /*
        Ejercicio de DQL !!!
            1_consultar empleados mujeres de 20,21,22,23 años
            2_consultar los empleados hombre con edad entre 20-40 y que tenga 3letras en el nombre
            3_contar los empleados de menor de 60 años, de h ombres y mujeres
            4_consultar laedad y nombre de los empleados menor igual a 35 años, y ordenalo en orden ascendente y fecha ascendente
            5_consultar los empleados hombre de entre 20 y 40 años los 5 primeros empleados, una vez obtenidos, ordenalos en orden ascendente
    */

    /*estructura compilacion
        FROM --> WHERE --> GROUP BY --> SELECT --> ORDER BY --> LIMIT 
    */
