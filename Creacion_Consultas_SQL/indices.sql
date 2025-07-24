-- Índices sugeridos
CREATE INDEX idx_canton_provincia ON Canton(id_provincia);
CREATE INDEX idx_parroquia_canton ON Parroquia(id_canton);
CREATE INDEX idx_eventoarma_parroquia ON EventoArma(id_parroquia);
CREATE INDEX idx_eventodesaparicion_provincia ON EventoDesaparicion(id_provincia);
CREATE INDEX idx_casosustancia_provincia ON CasoSustancia(id_provincia);

SET SESSION net_read_timeout = 120;
SET SESSION net_write_timeout = 120;