use armasilicitas;
CREATE TABLE Provincia (
  id_provincia INT PRIMARY KEY,
  nombre VARCHAR(100)
);

CREATE TABLE Canton (
  id_canton INT PRIMARY KEY,
  nombre VARCHAR(100),
  id_provincia INT,
  FOREIGN KEY (id_provincia) REFERENCES Provincia(id_provincia)
);

CREATE TABLE Parroquia (
  id_parroquia INT PRIMARY KEY,
  nombre VARCHAR(100),
  id_canton INT,
  FOREIGN KEY (id_canton) REFERENCES Canton(id_canton)
);

CREATE TABLE TipoArma (
  id_tipo_arma INT PRIMARY KEY AUTO_INCREMENT,
  clase_arma VARCHAR(100),
  calidad_de VARCHAR(100),
  calibre VARCHAR(100),
  fabricacion VARCHAR(100)
);

CREATE TABLE Modalidad (
  id_modalidad INT PRIMARY KEY AUTO_INCREMENT,
  tipo_delito VARCHAR(500),
  delito VARCHAR(500),
  modalidad VARCHAR(500)
);

CREATE TABLE EventoArma (
  id_evento INT PRIMARY KEY AUTO_INCREMENT,
  codigo_iccs TEXT,
  nombre_objeto TEXT,
  cantidad INT,
  tipo_lugar TEXT,
  lugar TEXT,
  fecha_evento DATE,
  hora_evento TIME,
  latitud VARCHAR(50),
  longitud VARCHAR(50),
  id_tipo_arma INT,
  id_modalidad INT,
  id_parroquia INT,
  FOREIGN KEY (id_tipo_arma) REFERENCES TipoArma(id_tipo_arma),
  FOREIGN KEY (id_modalidad) REFERENCES Modalidad(id_modalidad),
  FOREIGN KEY (id_parroquia) REFERENCES Parroquia(id_parroquia)
);

CREATE TABLE CasoSustancia (
  id_caso INT PRIMARY KEY AUTO_INCREMENT,
  numero_caso_institucional VARCHAR(100),
  fecha_aprehension DATE,
  fecha_destruccion DATE,
  peso_bruto DECIMAL(10,2),
  peso_neto DECIMAL(10,2),
  id_provincia INT,
  FOREIGN KEY (id_provincia) REFERENCES Provincia(id_provincia)
);

CREATE TABLE MotivoDesaparicion (
  id_motivo INT PRIMARY KEY AUTO_INCREMENT,
  descripcion VARCHAR(200)
);

CREATE TABLE EventoDesaparicion (
  id_evento INT PRIMARY KEY AUTO_INCREMENT,
  latitud VARCHAR(50),
  longitud VARCHAR(50),
  edad INT,
  sexo VARCHAR(10),
  fecha_desaparicion DATE,
  situacion_actual VARCHAR(100),
  fecha_localizacion DATE,
  id_motivo INT,
  id_provincia INT,
  FOREIGN KEY (id_motivo) REFERENCES MotivoDesaparicion(id_motivo),
  FOREIGN KEY (id_provincia) REFERENCES Provincia(id_provincia)
);

