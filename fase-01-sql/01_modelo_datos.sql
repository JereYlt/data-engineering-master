-- 1. Tabla de control del ETL (guarda la última ejecución exitosa)
CREATE TABLE IF NOT EXISTS tienda.etl_control (
    proceso VARCHAR(100) PRIMARY KEY,
    ultima_ejecucion TIMESTAMP,
    ultimo_exito TIMESTAMP,
    filas_procesadas INT,
    estado VARCHAR(20) DEFAULT 'pendiente'
);

-- 2. Tabla de log de auditoría (historial de ejecuciones)
CREATE TABLE IF NOT EXISTS tienda.etl_log (
    log_id SERIAL PRIMARY KEY,
    proceso VARCHAR(100),
    inicio TIMESTAMP,
    fin TIMESTAMP,
    filas_procesadas INT,
    estado VARCHAR(20),
    mensaje TEXT
);

-- 3. Tabla de hechos de ventas (destino del ETL)
CREATE TABLE IF NOT EXISTS tienda.hechos_ventas (
    hecho_id BIGSERIAL PRIMARY KEY,
    fecha DATE,
    cliente_id INT,
    producto_id INT,
    pedido_id INT,
    cantidad INT,
    subtotal DECIMAL(12,2),
    cargado_en TIMESTAMP DEFAULT NOW()
);

-- 4. Insertar la fila inicial en etl_control
INSERT INTO tienda.etl_control (proceso) VALUES ('etl_ventas')
ON CONFLICT (proceso) DO NOTHING;