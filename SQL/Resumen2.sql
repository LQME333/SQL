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
============================================================================================
*/

/* 
Más adelante usaremos DATAGRIP para MYSQL

ALTER USER 'root'@'localhost'
  IDENTIFIED WITH mysql_native_password
  BY '123456';
FLUSH PRIVILEGES;
EXIT;
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

