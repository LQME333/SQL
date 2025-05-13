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
*/

    ALTER TABLE empleadosx
    MODIFY COLUMN id VARCHAR(5);
    update empleadosx set id = lpad(id, 5, '0');


2_ mediante las funciones, genera un numero aleatorio de 6 cifras
        3_consultar la fecha de entrada de todos los empleados, y mediante los dias trabajados, ordenalos descendentemente