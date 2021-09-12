USE UnivPeque;

SELECT * FROM docente;

SELECT nombre FROM docente
WHERE nombre_dpto = "Ingeniería Telemática";

SELECT nombre FROM docente
WHERE nombre_dpto = "Ingeniería Telemática" AND salario > 70000;

SELECT docente.ID,docente.nombre,docente.nombre_dpto,docente.salario,departamento.edificio,departamento.presupuesto FROM docente
    INNER JOIN
        departamento
    on
        docente.nombre_dpto = departamento.nombre_dpto;

SELECT nombre FROM materia 
WHERE creditos = 3;

SELECT id_materia,materia.nombre FROM materia

INNER JOIN
    departamento
on
    materia.nombre_dpto = departamento.nombre_dpto
INNER JOIN 
    alumno_3ciclo
on
    departamento.nombre_dpto = alumno_3ciclo.nombre_dpto

WHERE alumno_3ciclo.ID = 12345;


SELECT alumno_3ciclo.nombre FROM alumno_3ciclo UNION ALL SELECT docente.nombre FROM docente ORDER BY nombre ASC;

SELECT alumno_3ciclo.nombre,alumno_3ciclo.tot_creditos, SUM(materia.creditos) FROM alumno_3ciclo

LEFT JOIN 
    cursa
ON
    cursa.ID = alumno_3ciclo.ID 

INNER JOIN 
    materia
ON
    cursa.id_materia = materia.id_materia

GROUP BY cursa.ID
ORDER BY alumno_3ciclo.nombre ASC;


SELECT DISTINCT alumno_3ciclo.nombre FROM alumno_3ciclo
    INNER JOIN 
        cursa
    on
        cursa.ID = alumno_3ciclo.ID
    INNER JOIN 
        materia
    on 
        materia.id_materia = cursa.id_materia

WHERE materia.nombre_dpto = "Ingeniería Telemática"

ORDER BY alumno_3ciclo.nombre;


SELECT docente.ID FROM docente
WHERE docente.ID NOT IN (SELECT imparte.ID FROM imparte);

SELECT docente.nombre FROM docente
WHERE docente.ID NOT IN (SELECT imparte.ID FROM imparte);


SELECT cursa.id_grupo,COUNT(*) AS contador FROM cursa
GROUP BY cursa.id_materia,cursa.id_grupo
ORDER BY contador ASC;  -- Cambiar para mayor numero o menor



SELECT grupo.id_materia, grupo.id_grupo,COUNT(cursa.ID) AS Num_Alumnos FROM cursa,grupo
WHERE cursa.id_materia = grupo.id_materia
AND cursa.id_grupo = grupo.id_grupo
AND cursa.cuatrimestre = grupo.cuatrimestre
AND cursa.anho = grupo.anho
GROUP BY cursa.id_materia,cursa.id_grupo,cursa.cuatrimestre,cursa.anho
ORDER BY Num_Alumnos DESC
LIMIT 10;






