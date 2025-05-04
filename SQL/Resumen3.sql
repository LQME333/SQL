/*
==========================================================================================

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
    5_DCL       <<-----------------------------
        5.1 DCL usurios
        5.2 DCL permisos
*/


/*
===================================================================================================
5.1_DCL usuarios

    En la carpeta 'mysql' -> tables -> user -> una tabla de permisos

    Ejercicio:
        1_crear usuario1, solo accede con host contraseña 123456
        2_crear usuario2, puede acceder a bd desde cualquier host, contraseña 123456
        3_cambiar contraseña 1234 al usuario2
        4_ eliminar usuario1@localhost 
*/


    create user 'usuario1'@'localhost' identified by '123456';
    /*  mysql -u usuario1 -p    123456
        show databases;
        +--------------------+
        | Database           |
        +--------------------+
        | information_schema |
        | performance_schema |
        +--------------------+
            VEMOS QUE NO TIENE PERMISOS PARA VER OTRAS BASE DE DATOS    
    */

    create user 'usuario2'@'%' identified by '123456';

    alter user 'usuario2'@'%' identified by '1234';

    drop user 'usuario1'@'localhost';

/*
===================================================================================================
5.2_DCL permisos

        ALL, ALL PRIVILEGES --> todos los permisos
        SELECT 
        INSERT 
        UPDATE --> modificar datos
        DELETE --> eliminar datos
        ALTER --> modificar tabla
        DROP --> eliminar tabls, base de datos
        CREATE --> crear tablas, base de datos

        Consultar permisos --> SHOW GRANTS FOR '???'@'???';
        Dar permisos --> GRANT ??? ON ??? TO '???'@'???';
        Eliminar permisos --> REVOKE ??? ON ??? FROM '???'@'???;'

        en vez de bd2.*, se puede usar *.* para referirnos todas las bd y tablas

*/
        show grants for 'usuario2'@'%';  /*GRANT USAGE ON *.* TO `usuario2`@`%`  no tengo permisos, solo podemos entrar a la sesion*/
        grant all on bd2.* to 'usuario2'@'%'  /*GRANT ALL PRIVILEGES ON `bd2`.* TO `usuario2`@`%`   todos los permisos para bd2*/
        /*
        +--------------------+
        | Database           |
        +--------------------+
        | bd2                |
        | information_schema |
        | performance_schema |
        +--------------------+

        +---------------+
        | Tables_in_bd2 |
        +---------------+
        | empleadosx    |
        +---------------+

        */

        revoke all on bd2.* from 'usuario2'@'%';
        /*
        +--------------------+
        | Database           |
        +--------------------+
        | information_schema |
        | performance_schema |
        +--------------------+
        */