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
    6_Funciones 
        6.1_funciones strings
        6.2_funciones numericas
        6.3_funciones fecha
        6.4 funciones flujo control
    7_Restricciones
        7.1_Restricciones enlaces externos
        7.2_ELiminar/Actualizar
    8_Consultas multiples       <<-----------------------------
        8.1_Relacion entre tablas, descripcion general cosulta multitablas
        8.2_INNER JOIN, OUTER JOIN y SELF JOIN
        8.3_SUBQUERIES y ejemplos
*/

/*
====================================================================================================
8.1_Relacion entre tablas, descripcion general cosulta multitablas

        1 a N  / N a 1   ==>   un grupo(1) puede tener muchos empleados(N), 
                               mientras que una persona solo puede estar en un grupo
        N a N   ==>   un alumno puede tener ,mucahs asignaturas y
                      una asignatura puede tener muchos alumnos
                      lo podemos manejar con 2 claves externas, uno elid del alumno y el id de la asignatura
            
                create table estudiante(
                    id int auto_increment primary key,
                    name varchar(10),
                    code varchar(10)
                );
                insert into estudiante values(null, 'aaa', '10001'), (null, 'bbb', '10002'),
                                        (null, 'ccc', '10003'), (null, 'ddd', '10004');

                create table asignatura(
                    id int auto_increment primary key,
                    name varchar(10)
                );
                insert into asignatura values(null, 'Castellano'), (null, 'mates'),
                                            (null, 'ingles'), (null, 'redes');

                create table datos_estudiantes (
                    id int auto_increment primary key,
                    idestudiante int not null,
                    idasignatura int not null,
                    constraint fk_idasignatura foreign key (idasignatura) references asignatura (id),
                    constraint fk_idestudiante foreign key (idestudiante) references estudiante (id)
                );
                insert into datos_estudiantes values (null, 1, 1), (null,1,2),
                                                    (null, 1,3), (null, 2,2),
                                                    (null, 2,3), (null, 3,4);
        
        1 a 1   ==>   dividir una tabla, usar UNIQUE en una de las tablas

                create table planeta(
                    id int auto_increment primary key,
                    name varchar(20),
                    color varchar(20),
                    temperatura int
                );
                create table planeta_datos (
                    id int auto_increment primary key,
                    edad int unsigned,
                    vida char(1),
                    idplaneta int unique,
                    constraint fk_idplaneta foreign key (idplaneta) references planeta (id)
                );
                insert into planeta values (null, 'tierra', 'azul', 25), (null, 'marte', 'rojo', -20),
                                        (null, 'saturno', 'marron', -200), (null, 'uranio', 'azul', -250);
                insert into planeta_datos values(null, 33000, 's', 1),
                                                (null, 20900, 'n', 2),
                                                (null, 100000, 'n', 3),
                                                (null, 188888, 'n', 4);

        Consulta multitablas:
            Tenemos tabla empleadosy con 17, y dept con 7, 17*7 = 119 lineas de datos
                select * from empleadosy, dept;
            Solución: select *from empleadosy, dept where managerid = dept_id;


*/



/*
====================================================================================================
8.2_INNER JOIN, OUTER JOIN y SELF JOIN

    INNER JOIN: A n B
        implícita:  SELECT ? FROM TABLA1, TABLA2 WHERE ??;
        explícita:  SELECT ? FROM TABLA1 [INNER] JOIN TABLA2 ON condicion;

        COnsultar los nombres de empleados, y sus departamentos
            select empleadosy.name, dept.name from empleadosy, dept where empleadosy.dept_id = dept.id;
            select e.name, d.name from empleadosy e, dept d where e.dept_id = d.id;
        COnsultar los nombres de empleados, y sus departamentos mediante interseccion
            select e.name, d.name from empleadosy e inner join dept d on e.dept_id = d.id
    
    OUTER JOIN:  
        A U (AnB): SELECT ? FROM tabla1 LEFT [OUTER] JOIN tabla2 ON condicion;
        B U (ANB): SELECT ? FROM tabla1 RIGTH [OUTER] JOIN tabla2 ON condicion;

        COnsultar todos los datos de empleados izq
            select e.*, d.name from empleadosy e left outer join dept d on e.dept_id = d.id;
        COnsultar todos los datos de empleados derc
            select d.*, e.* from empleadosy e right outer join dept d on e.dept_id = d.id;

    SELF JOIN: 
        UNION: SELECT FROM tabla1 t1 JOIN tabla1 t2 ON condicion;
        UNINION ALL:

        Consultar el managerid de los empleados y el nombre
            SELECT * FROM empleadosy t1, empleadosy t2 where t1.managerid = t2.id; -- osea conectar estos 2 variables en 1
                t1.name(emp)    t2.name(boss)
                Ana Ruiz,       Luis Gómez
                Carlos Díaz,    Luis Gómez
                María López,    Luis Gómez
                Pedro Sánchez,  María López
        Consultar todos los empleados y el nombre de sus empleados aunque no tengan
                select t1.name '员工', t2.name '领导' from empleadosy t1 left join empleadosy t2 on t1.managerid = t2.id;

    UNION/UNION ALL: consulta combinada
        SELECT ? FROM tabla1
        UNION[ALL]
        SELECT ? FROM tabla2

        COnsultar cuyo salario menor de 5000 y edad mayor de 50 anos
            select * from empleadosy where salary < 5000
            union all
            select * from empleadosy where age > 50; *osea unir 2 tablas de condicones
    */


/*
====================================================================================================
8.3_SUBQUERIES y ejemplos

    SUBCONSULTA: SELECT * FROM t1 WHERE columna1 = (SELECT columna1 FROM t2);

    Resultado de subconsulta:
        - COnsulta escalar --> devuelve un valor
        - Consulta columna --> devuelve una columna (IN, NOT IN, ANY(cualquiera), SOME, ALL)
        - Consulta fila --͎> devuelve fila
        - Consulta tabla --> devuelve filas y columans

        COnsultar  empleados payasos(dept_id 1)
            Select id from dept where name = 'payaso';
            select * from empleadosy where dept_id = 1;
            convertirse en ---> select * from empleadosy where dept_id = (Select id from dept where name = 'payaso');

        COnsultar empleados despues de la entrada de Manuel Rico
               select * from empleadosy where date > (select date from empleadosy where name = 'Manuel Rico');

        COnsulta empleados de payasos y fabrica
            select from dept where name = 'payaso' or name='fabrica';
            select * from empleadosy where dept_id in (1,6);
            --->select * from empleadosy where dept_id in (select id from dept where name = 'payaso' or name='fabrica');

        COnsultar todos los empleados cuyo salario sea mas alto que los de innovacion
            select id from dept where name = 'innovacion'
            select salary from empleadosy where dept_id = 2
            select * from empleadosy where salary > all (select salary from empleadosy where dept_id = (select id from dept where name = 'innovacion'));

        Consultar personas que tenga mas salario que una persona aleatoria de innovation
            select salary feom empleadosy  where dept_id = (select id from dept where name = 'gestoria');  --busca salrio de todos gestoria
            select * from empleadosy where salary > any (select salary from empleadosy  where dept_id = (select id from dept where name = 'gestoria'));  --busca salrio de todos imnnovation);

        Consultar salario y jefe iguales a Luis Gómez
            select * from empleadosy where (salary, managerid) = (select salary, managerid from empleadosy where name = 'Luis Gómez');


        Consultar empleados yque tengan el mismo puesto y salario que Lucia Torres y Raúl vera
            select * from empleadosy where (salary, job) in (select salary, job from empleadosy where name = 'Raúl Vera' or name = 'Pedro Sánchez');

        Consultar empleados y sus departamentos que entres despues de 2022-01-01;
            select e.*, d.* from (select * from empleadosy where date > '2022-01-01') e left join dept d on e.dept_id = d.id;
            *Añade cosas de tabla dept

*/              


 