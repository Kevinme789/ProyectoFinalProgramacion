# 🏛️ UNIVERSIDAD TÉCNICA PARTICULAR DE LOJA

## 📊 PROYECTO INTEGRADOR

**DOCENTE:** Ing. Danilo Jaramillo  
**INTEGRANTES:**  
- Anthony Romero  
- Kevin Robles  
- Leandro Saquisari  

📅 **Fecha:** 21/07/2025  
🧪 **Asignatura:** Programación Avanzada  

---

## 📚 Contenido

- [Introducción](#introducción)
- [Repositorio GitHub](#repositorio-github)
- [Datos Base](#datos-base)
- [Datos Complementarios](#datos-complementarios)
- [Diseño lógico relacional](#diseño-lógico-relacional)
- [Diccionario de datos](#diccionario-de-datos)
- [Script SQL](#script-sql)
- [Análisis a realizar](#análisis-a-realizar)
- [Conclusiones](#conclusiones)
- [Bibliografía](#bibliografía)

---

## Introducción

En el ámbito del análisis territorial y de seguridad ciudadana, el estudio de fenómenos delictivos a partir de datos estadísticos resulta clave para la identificación de patrones y zonas críticas. Este documento representa un esfuerzo exploratorio orientado a generar alertas territoriales y aportar evidencia útil para el diseño de políticas públicas en materia de seguridad.

---

## Repositorio GitHub

📎 [Ver repositorio](https://github.com/Kevinme789/ProyectoFinalProgramacion.git)

---

## Datos Base

Información sobre decomiso y registro de armas de fuego en Ecuador. Variables:

- `codigo_iccs`, `subtipo_objeto_robado`, `nombre_objeto`, `cantidad`, `calibre`, `clase_arma`, `calidad_de`, `fabricacion`
- `fecha_evento`, `hora_evento`, `tipo_lugar`, `lugar`, `latitud`, `longitud`
- `codigo_zona`, `codigo_distrito`, `codigo_circuito`, `codigo_subcircuito`
- `nombre_zona`, `nombre_distrito`, `nombre_circuito`, `nombre_subcircuito`
- `codigo_provincia`, `codigo_canton`, `codigo_parroquia`
- `tipo_delito`, `delito`, `modalidad`

---

## Datos Complementarios

- Parroquias/Cantones/Provincias: [Tabla SRI](https://www.sri.gob.ec/o/sri-portlet-biblioteca-alfresco-internet/descargar/7fdfeda2-ce54-4778-b1d3-c22d461bcdfc/Anexos%20y%20Tablas%20para%20Municipios.xlsx)
- Personas desaparecidas: [Datos Abiertos](https://www.datosabiertos.gob.ec/dataset/personas-desaparecidas)
- Sustancias destruidas: [Datos Abiertos](https://datosabiertos.gob.ec/dataset/sustancias-sujetas-a-fiscalizacion-depositadas)

---

## Diseño lógico relacional

Estructura jerárquica mediante claves foráneas entre provincias, cantones y parroquias. Otras tablas como `TipoArma`, `Modalidad`, `EventoArma`, `CasoSustancia` y `EventoDesaparicion` permiten mantener integridad referencial.

---

## Diccionario de datos

### Provincia
- `id_provincia` (PK)
- `nombre`

### Cantón
- `id_canton` (PK)
- `nombre`
- `id_provincia` (FK)

### Parroquia
- `id_parroquia` (PK)
- `nombre`
- `id_canton` (FK)

### TipoArma
- `id_tipo_arma`, `clase_arma`, `calidad_de`, `calibre`, `fabricacion`

### Modalidad
- `id_modalidad`, `tipo_delito`, `delito`, `modalidad`

### EventoArma
- `id_evento`, `codigo_iccs`, `nombre_objeto`, `cantidad`, `tipo_lugar`, `lugar`, `fecha_evento`, `hora_evento`, `latitud`, `longitud`, `id_tipo_arma` (FK), `id_modalidad` (FK), `id_parroquia` (FK)

### CasoSustancia
- `id_caso`, `numero_caso_institucional`, `fecha_aprehension`, `fecha_destruccion`, `peso_bruto`, `peso_neto`, `id_provincia` (FK)

### MotivoDesaparicion
- `id_motivo`, `descripcion`

### EventoDesaparicion
- `id_evento`, `latitud`, `longitud`, `edad`, `sexo`, `fecha_desaparicion`, `situacion_actual`, `fecha_localizacion`, `id_motivo` (FK), `id_provincia` (FK)

---

## Script SQL

Creación de Tablas.  
📎 [Ver script SQL](https://github.com/Kevinme789/ProyectoFinalProgramacion/blob/main/Creacion_Consultas_SQL/CREACION%20DE%20TABLAS.sql)

Consultas.  
📎 [Ver script SQL](https://github.com/Kevinme789/ProyectoFinalProgramacion/blob/main/Creacion_Consultas_SQL/Consultas.sql)

Indices.  
📎 [Ver script SQL](https://github.com/Kevinme789/ProyectoFinalProgramacion/blob/main/Creacion_Consultas_SQL/indices.sql)

---


## Análisis a realizar

### Consulta 1
**Modalidades delictivas más comunes en provincias con más de 10.000 desapariciones.**  
🧠 Destaca **Guayas** y **Pichincha** por frecuencia de delitos como **asalto** y **saca pintas**.

<img width="569" height="301" alt="image" src="https://github.com/user-attachments/assets/215549b4-fe08-4dce-a502-7993c940792f" />


### Consulta 2
**Provincias con más de 1000 armas ilícitas y más de 1000 sustancias destruidas.**  
📌 Guayas, Esmeraldas, Pichincha y El Oro sobresalen.

<img width="542" height="223" alt="image" src="https://github.com/user-attachments/assets/f81b2ab1-d1fe-4db2-ae28-e7e5452acb9e" />

### Consulta 3
**Coincidencia de sustancias destruidas y armas ilícitas.**  
📍 Guayas (armas), Pichincha (sustancias).

<img width="566" height="293" alt="image" src="https://github.com/user-attachments/assets/41ef3b38-6140-4447-b7f1-7db68bb9d7a9" />


### Consulta 4
**Armas ilícitas en cantones con más de 10.000 desapariciones.**  
🏙️ Quito lidera con diferencia notable.

<img width="564" height="254" alt="image" src="https://github.com/user-attachments/assets/003cf623-72d0-40fc-9524-4e2f1d0e464d" />


### Consulta 5
**Coordenadas de armas ilícitas y desapariciones en la misma provincia.**  
📍 Azuay presenta coincidencia geográfica de ambos eventos.

<img width="544" height="253" alt="image" src="https://github.com/user-attachments/assets/093c62b9-6864-4e76-931d-da65b9f57f7c" />

---

## Conclusiones

- **Guayas y Pichincha** son zonas críticas.
- Coincidencia espacial de eventos permite focalizar políticas públicas.
- Es necesario fortalecer el registro de datos en provincias con clasificaciones poco precisas.
- Las herramientas georreferenciadas ofrecen gran potencial para análisis criminales.

---

## Bibliografía

- Cordero, P. (2020). [Cómo instalar Ubuntu en VirtualBox](https://osl.ugr.es/2020/09/29/como-instalar-ubuntu-en-virtual-box/)
- [Apache Zeppelin – Cloudera](https://es.cloudera.com/products/open-source/apache-hadoop/apache-zeppelin.html)
- [Ubuntu – Acerca de](https://ubuntu.com/about)

