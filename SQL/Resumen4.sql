/* 
Indice(SQL en linux)
    1_Definiciones
    2_DDL
        2.1_DDL operaciones
        2.2_DDL consulta
        2.3_DDL tipo de datos
        2.4_DDL modificacion
    3_DML  
        3.1_INSERT, UPDATE, DELETE
    4_DQL
        4.1_ESTRUCTURA
    5_DCL       
        5.1 DCL usurios
        5.2 DCL permisos
    6_Funciones <<-----------------------------
        6.1_funciones strings
        6.2_funciones numericas
        6.3_funciones fecha
        6.4 funciones flujo control
*/

/*
===============================================================================
6.1 funciones string

    CONCAT(S1,S2,S3.....) --> combina los caracteres
    LOWER(str), UPPER(str) --> mayuscula miyuscula
    LPAD(str, n ,pad)  --> rellenar str por la izquierda con pad hasta tener longitud n
    RPAD(str, n, pad)
    TRIM(str) --> elimina los espacios en blaco al principio y final
    SUBSTRING(str, start, len) --> devuelve subcadena de str desde posicion starst con length len

    select concat('hello', ' mysql');
    select lower(' mySql');
    select upper(' mysql');
    select lpad('01', 5, '-');   ---01  
    select rpad('01', 5, '-');   01---  
    select trim('          hello  mysql  ');  hello  mysql
    select substring('hello mysql', 1, 5);      hello

    Ejercicio:
        1_ por razones de organizacion, el id de los empleados seran de 5 cifras
           si no, se rellenarn con 0 delante, ej, 1 = 00001

        ALTER TABLE empleadosx
        MODIFY COLUMN id VARCHAR(5);
        update empleadosx set id = lpad(id, 5, '0');
*/


/*
================================================================================
6.2 funciones numericas

    CEIL(x) redondear hacia arriba
    FLOOR(x) redondear hacia abajo
    RAND() VALOR ALEATORIO del 0 al 1
    MOD(X,Y) resto
    ROUND(x,y) valor aleatorio con decimal


    select ceil(1.5);  2
    select floor(1.7);  1
    select mod(5,4);  1
    select round(2.34,1);  2.3

    Ejercicio:
        2_ mediante las funciones, genera un numero aleatorio de 6 cifras

        select lpad(round(rand(),6)*1000000, 6, '0');
        select lpad(round(rand()*1000000,0), 6, '0');
*/


/*
================================================================================
6.3 funciones de fechas

    CURDATE() --> volver dia actual(current)
    CURTIME() --> volver tiempo actual
    NOW() --> volver fecha y tiempo actual
    YEAR(date) --> devuelve el año
    MONTH(date) 
    DAY(date) 
    DATE_ADD(date, INTERVALexpr type) --> devuelve date + otro
    DATEDIFF(DATE1,DATE2) --> devuelve la diferencia de tiempo

    select curdate();  2025-05-13
    select curtime();
    select now();   2025-05-13 09:12:26
    select year(now());  2025
    select month(now());  5
    select day(now());  13
    select date_add(now(), INTERVAL 70 DAY);  2025-07-22 09:16:16
    select date_add(now(), INTERVAL 70 year);  2095-05-13 09:16:47
    select datediff('2020-01-01', now() );  -1959


    Ejercicio:
        3_consultar la fecha de entrada de todos los empleados, 
        y mediante los dias trabajados, ordenalos descendentemente

        select name, datediff(now(), fecha) dias from empleadosx order by dias desc;
*/




/*
================================================================================
6.4 funciones flujo control

    if(value,t,f);
    ifnull(value1, value2);
    CASE WHEN [val1] THEN [res1] ... else [default] END
    CASE [expr] WHEN [val1] THEN [res1] ... ELSE [default] END

    select if(true, 'ok', 'error');  ok
    select ifnull('ok', 'nook');  ok
    select ifnull('', 'nook');  no imprime nada
    select ifnull(null, 'nook');  nook

    Ejercicio:
        1_consultar empleados con sus nombres y direccion, si la direccion es ciudad grande ebtinces 1 sino 2
        2_notas, igual mayor que 85 sobresaliente, mayor igual que 60 aprobado, sino suspendido

    select name, case address when 'CALLE1' THEN 'JEJE' WHEN 'CALLE4' THEN 'JEJE' ELSE 'POPOP' END from empleadosx;
    select name, nota, case when nota >= 85 then 'sobresaliente' when nota >=60 then 'aprobado' else 'suspendido' end as calificacion from empleados;


*/




