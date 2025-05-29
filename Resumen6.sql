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
    8_Consultas multiples
        8.1_Relacion entre tablas, descripcion general cosulta multitablas
        8.2_INNER JOIN, OUTER JOIN y SELF JOIN
        8.3_SUBQUERIES y ejemplos
    9_Ejercicios consultas multiples    <<-----------------------------
*/
use bd3;
-- Creamos la tabla empleadosk
create table empleadosk
(
    grado int,
    losssalario int,
    highsalario int
);
insert into empleadosk
values (1, 0, 3000);
insert into empleadosk
values (2, 3001, 5000);
insert into empleadosk
values (3, 5001, 8000);
insert into empleadosk
values (4, 8100, 10000);
insert into empleadosk
values (5, 10001, 12000);
insert into empleadosk
values (6, 12001, 15000);
insert into empleadosk
values (7, 15001, 20000);
insert into empleadosk
values (8, 20001, 30000);


-- 1 Consulta el nombre, edad, puesto y departamento de los empleados.
select e.name, e.age, e.job, d.name
from empleadosy e,
     dept d
where e.dept_id = d.id;

-- 2 Consulta el nombre, edad, puesto y departamento de los empleados menores de 30 años.
select e.name, e.age, e.job, d.name
from empleadosy e
         inner join dept d on e.dept_id = d.id
where e.age < 30;

-- 3 Consulta el ID y el nombre de los departamentos que tienen empleados.
select distinct d.id, d.name
from empleadosy e,
     dept d
where e.dept_id = d.id;

-- 4 Consulta todos los empleados mayores de 40 años, y el nombre de su departamento. Si no tienen departamento asignado, también deben mostrarse.
select e.*, d.name
from empleadosy e
         left join dept d on e.dept_id = d.id
where e.age > 40;

-- 5 Consulta el salario de todos los empleados.
-- empleadosy, empeladosk
-- condicion: entre el max y min salary
select e.name, e.salary, s.grado
from empleadosy e,
     empleadosk s
where e.salary >= s.losssalario
  and e.salary <= s.highsalario;
select e.name, e.salary, s.grado
from empleadosy e,
     empleadosk s
where e.salary between s.losssalario and s.highsalario;


-- 6 Consulta toda la información y el salario del departamento "innovacion".
-- empleadosy, empleadosk, dept
-- condicion  e.salary between s.losssalario and s.highsalario  y   e.dept_id = dept_id
select e.*, s.grado
from empleadosy e,
     dept d,
     empleadosk s
where e.dept_id = d.id
  and (e.salary between s.losssalario and s.highsalario)
  and d.name = 'innovacion';

-- 7 Consulta el salario promedio de los empleados del departamento "innovation".
-- empleadosy dept
select avg(e.salary)
from empleadosy e,
     dept d
where e.dept_id = d.id
  and d.name = 'innovacion';

-- 8 Consulta la información de los empleados con salario MAyOR QUE MANUEL RICO
select salary
from empleadosy
where name = 'Manuel Rico';
select *
from empleadosy
where salary > (select salary from empleadosy where name = 'Manuel Rico');


-- 9 Consulta la información de los empleados cuyo salario es mayor al promedio.
select avg(salary)
from empleadosy;
select *
from empleadosy
where salary > (select avg(salary) from empleadosy);

-- 10 Consulta la información de los empleados cuyo salario es menor que el promedio del departamento.
select avg(salary) from empleadosy e1 where e1.dept_id = 2;

select *
from empleadosy
where salary < (select avg(salary) from empleadosy e1 where e1.dept_id = 2); -- A TODOS

select *
from empleadosy e2
where e2.salary < (select avg(e1.salary) from empleadosy e1 where e2.dept_id = 2); -- AL MISMO DEPARTAMENTO

select *, (select avg(e1.salary) from empleadosy e1 where e1.dept_id = e2.dept_id) 'promedio'
from empleadosy e2
where e2.salary < (select avg(e1.salary) from empleadosy e1 where e1.dept_id = 2); -- promedio de cada persona dependiedno su departamentto

-- 11 Consulta la información de todos los departamentos y el número de empleados por departamento.
select d.id, d.name, (select count(*) from empleadosy e where e.dept_id = d.id) 'numºpersonas' from dept d;


-- 12 Consulta la situación de elección de asignaturas de todos los estudiantes, mostrando el nombre del estudiante, número de estudiante y nombre del curso.
-- estudiante, asignatturas, datos_estudiantes
-- student.id = student_course-student.id, course.id = student_course.courseid
select s.name, s.code, a.name from estudiante s, datos_estudiantes d, asignatura a where s.id = d.idestudiante and d.idasignatura = a.id;
