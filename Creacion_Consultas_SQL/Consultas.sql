-- Coordenadas de armas ilícitas y desapariciones en la misma provincia
SELECT 
    p.nombre AS provincia,
    ea.latitud AS lat_arma,
    ea.longitud AS long_arma,
    ed.latitud AS lat_desaparecido,
    ed.longitud AS long_desaparecido
FROM Provincia p
JOIN Canton c ON c.id_provincia = p.id_provincia
JOIN Parroquia prq ON prq.id_canton = c.id_canton
JOIN EventoArma ea ON ea.id_parroquia = prq.id_parroquia
JOIN EventoDesaparicion ed ON ed.id_provincia = p.id_provincia
WHERE ea.latitud IS NOT NULL AND ea.longitud IS NOT NULL
  AND ed.latitud IS NOT NULL AND ed.longitud IS NOT NULL
LIMIT 50;

--  Cantidad de armas ilícitas relacionadas a cantones donde hubo más de 10000 desapariciones
WITH CantonesConDesapariciones AS (
    SELECT 
        c.id_canton,
        COUNT(*) AS desapariciones
    FROM EventoDesaparicion ed
    JOIN Provincia p ON ed.id_provincia = p.id_provincia
    JOIN Canton c ON c.id_provincia = p.id_provincia
    GROUP BY c.id_canton
    HAVING desapariciones > 10000
)
SELECT 
    c.nombre AS canton,
    COUNT(DISTINCT ea.id_evento) AS armas_ilicitas
FROM EventoArma ea
JOIN Parroquia prq ON ea.id_parroquia = prq.id_parroquia
JOIN Canton c ON prq.id_canton = c.id_canton
WHERE c.id_canton IN (SELECT id_canton FROM CantonesConDesapariciones)
GROUP BY c.nombre
ORDER BY armas_ilicitas DESC;

-- Modalidades delictivas más comunes en provincias con más de 10.000 desapariciones (solo si se repiten más de 10 veces)
WITH DesaparicionesPorProvincia AS (
    SELECT 
        id_provincia,
        COUNT(*) AS cantidad_desapariciones
    FROM EventoDesaparicion
    GROUP BY id_provincia
),
ProvinciasTop AS (
    SELECT id_provincia
    FROM DesaparicionesPorProvincia
    WHERE cantidad_desapariciones > 10000
),
ModalidadesFiltradas AS (
    SELECT 
        p.nombre AS provincia,
        m.modalidad,
        COUNT(*) AS cantidad
    FROM EventoArma ea
    JOIN Modalidad m ON ea.id_modalidad = m.id_modalidad
    JOIN Parroquia prq ON ea.id_parroquia = prq.id_parroquia
    JOIN Canton c ON prq.id_canton = c.id_canton
    JOIN Provincia p ON c.id_provincia = p.id_provincia
    WHERE 
        p.id_provincia IN (SELECT id_provincia FROM ProvinciasTop)
        AND m.modalidad <> 'SIN_DATO'
    GROUP BY p.nombre, m.modalidad
)
SELECT *
FROM ModalidadesFiltradas
WHERE cantidad > 10
ORDER BY cantidad DESC;
-- Provincias donde coincide la presencia de sustancias destruidas y armas ilícitas (con cantidades)
WITH ArmasPorProvincia AS (
    SELECT c.id_provincia, COUNT(*) AS total_armas
    FROM EventoArma ea
    JOIN Parroquia prq ON ea.id_parroquia = prq.id_parroquia
    JOIN Canton c ON prq.id_canton = c.id_canton
    GROUP BY c.id_provincia
),
SustanciasPorProvincia AS (
    SELECT id_provincia, COUNT(*) AS total_sustancias
    FROM CasoSustancia
    GROUP BY id_provincia
),
Coinciden AS (
    SELECT a.id_provincia, a.total_armas, s.total_sustancias
    FROM ArmasPorProvincia a
    JOIN SustanciasPorProvincia s ON a.id_provincia = s.id_provincia
)
SELECT p.nombre AS provincia, c.total_armas, c.total_sustancias
FROM Coinciden c
JOIN Provincia p ON p.id_provincia = c.id_provincia
ORDER BY c.total_armas DESC, c.total_sustancias DESC;
-- Provincias con más de 1000 armas ilícitas y más de 1000 sustancias destruidas.
WITH ArmasPorProvincia AS (
    SELECT 
        c.id_provincia,
        COUNT(DISTINCT ea.id_evento) AS armas_ilicitas
    FROM EventoArma ea
    JOIN Parroquia prq ON ea.id_parroquia = prq.id_parroquia
    JOIN Canton c ON prq.id_canton = c.id_canton
    GROUP BY c.id_provincia
),
SustanciasPorProvincia AS (
    SELECT 
        id_provincia,
        COUNT(DISTINCT id_caso) AS sustancias_destruidas
    FROM CasoSustancia
    GROUP BY id_provincia
)
SELECT 
    p.nombre AS provincia,
    a.armas_ilicitas,
    s.sustancias_destruidas
FROM Provincia p
JOIN ArmasPorProvincia a ON p.id_provincia = a.id_provincia
JOIN SustanciasPorProvincia s ON p.id_provincia = s.id_provincia
WHERE a.armas_ilicitas > 1000 AND s.sustancias_destruidas > 1000
ORDER BY a.armas_ilicitas DESC, s.sustancias_destruidas DESC;