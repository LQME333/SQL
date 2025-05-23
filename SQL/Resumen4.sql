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
    7_Restricciones
        7.1_Restricciones enlaces externos
        7.2_ELiminar/Actualizar
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



/*
=========================================================================================
77.1_Restricciones enlaces externos
.1_Restricciones enlaces externos
    - LImita datos almacenados
    - Garantiza exactitud, validez e integridad
    - TIPOS:
        NOT NULL → El campo no puede ser NULL
        UNIQUE → Valor único, no se puede repetir
        PRIMARY KEY → Campo único y obligatorio (ni repetido ni NULL), como el DNI
        DEFAULT → Valor por defecto si no se da otro
        CHECK → Valida que el dato cumpla una condición (ej: edad > 0)
        FOREIGN KEY → Conecta con otra tabla, asegura relaciones válidas entre datos


        ***Ejercicio:
            id          int             clave primaria, auto incremento     PRIMARY KEY, AUTO_INCREMENT
            name        varchar(10)     No nulo, único                      NOT NULL, UNIQUE (el contador avanza)
            age         int             mayor que 0 y menor igual a 120     CHECK
            status      char(1)         si no se especifica, por defecto 1  DEFAULT
            gender      char(1)         Sin restrincciones


            **Vamos a crear la bd3 y nueva tabla

            create table user(
                        id int unsigned primary key  auto_increment,
                        name varchar(10) not null unique,
                        age int unsigned check(age>0 and age <= 120),
                        status char(1) default '1',
                        gender char(1)  
            );
            insert into user (name, age, status, gender) values ('TOM', 22, '1', 'M'),
                                                        ('TOMas', 80, '0', 'M'); --id por defecto
            insert into user (name, age, status, gender) values (null, 22, '1', 'M');  --error
            insert into user (name, age, status, gender) values ('TOM', 24, '1', 'M');  --nombre duplicado, ya existe
            insert into user (name, age, status, gender) values ('TOMhx', 24, '1', 'M');
                1,TOM,22,1,M
                2,TOMas,80,0,M
                4,TOMhx,24,1,M  -- ha saltado id3 porque antes da error el segundo TOM, pero se ha guardado
            insert into user (name, age, status, gender) values ('TOM5', -4, '1', 'M');  --error    
            insert into user (name, age, gender) values ('TOM5', 44, 'M');  --correcto


        ***Ejercicio: por ejemplo de grupo 1 empleados y grupo5 jefes, si borramos la grupo58 dept en dept_id no será afectado
            
            create table empleadosy(
                id int auto_increment primary key,
                name varchar(50) not null,
                age int unsigned,
                job varchar(20),
                salary int,
                date date,
                managerid int,
                dept_id int
            );
            insert into empleadosy(name, age, job, salary, date, managerid, dept_id) values
                                ('ana', 30, 'CEO',60000, '2000-01-01', null, 5),
                                ('anas', 35, 'limpieza',5000, '2002-01-01', 1, 1),
                                ('ana1', 40, 'animador',12500, '2040-01-01', 2, 1),
                                ('anas1', 46, 'cocinero',10000, '2006-01-01', 1, 1),
                                ('anax', 57, 'programador',40800, '2008-01-01', 3, 1),
                                ('anay', 61, 'fabricador',140000, '2020-01-01', 2, 1);


            create table dept(
                id int auto_increment primary key,
                name varchar(50) not null
            );
            insert into dept(name) values ('fabrica'),('innovacion'),('gestoria'), ('gerencia'), ('CEO');


            Solucion: 
                alter table empleadosy      modificar tabla
                add constraint fk_empleadosy_dept_id        añadir restriccion
                foreign key (dept_id)       clave que se relaciona con otra tabla
                references dept(id)     conectar con esta tabla el elemento id

                En dept_id a la izq hay una llave azul, qeu indica externo y id una llave amarillo que es la principal
                si eliminamos dept id 5 saldrá error porque está el dato enlazada con otra tabla

            Para eliminar el contacto:
                alter table empleadosy
                drop foreign key kf_empleadosy_dept_id;
                  *ahora ya se puede eliminar dept y no sale error
*/

/*
================================================================================
7.2_ELiminar/Actualiza

    NO ACTION   --> AL actualizar el padre comprueba si hay clave hijos externos, si hay no permite
    RESTRICT    --> Igual que no action, comprueba y prohibe borrar si se está usando
    CASCADE     --> Si borra o actualiza el padre, el hijo tambien automaticameante
    SET NULL    --> Si borra o actualiza el padre, el hijo se pone a null
    SET DEFAULT --> Si borra el padre, el valor de hijo se pone por defecto


        ALTER TABLE empleadosy
            ADD CONSTRAINT fk_empleadosy_dept_id
                FOREIGN KEY (dept_id)
                    REFERENCES dept(id)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE;

        *En dept cambio el id 1 por 8 y en empleadosy se cambia automaticamente
        *SI eliminamos el id 8 ahora, los usuarios de empleadosy cuyo id es 8 se borran



        ALTER TABLE empleadosy
        DROP FOREIGN KEY fk_empleadosy_dept_id;

        ALTER TABLE empleadosy
            ADD CONSTRAINT fk_empleadosy_dept_id
                FOREIGN KEY (dept_id)
                    REFERENCES dept(id)
                    ON UPDATE set null
                    ON DELETE set null;

        *Al eliminar id 8, todos los empleadosy cuyo id es 8 se pone a null
*/

