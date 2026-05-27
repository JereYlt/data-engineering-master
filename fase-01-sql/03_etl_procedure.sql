CREATE OR REPLACE PROCEDURE tienda.etl_cargar_ventas()
LANGUAGE plpgsql
AS $$
DECLARE
    v_inicio TIMESTAMP := NOW();
    v_ultima_carga TIMESTAMP;
    v_filas INT := 0;
BEGIN
    -- Obtener la fecha de la última carga exitosa
    SELECT COALESCE(ultimo_exito, '2020-01-01'::TIMESTAMP)
    INTO v_ultima_carga
    FROM tienda.etl_control
    WHERE proceso = 'etl_ventas';

    RAISE NOTICE 'ETL iniciado. Cargando datos desde: %', v_ultima_carga;

    -- Insertar solo los pedidos nuevos y no duplicados
    INSERT INTO tienda.hechos_ventas
        (fecha, cliente_id, producto_id, pedido_id, cantidad, subtotal)
    SELECT
        p.fecha::DATE,
        p.cliente_id,
        dp.producto_id,
        p.pedido_id,
        dp.cantidad,
        dp.cantidad * dp.precio_unit AS subtotal
    FROM tienda.pedidos p
    JOIN tienda.detalle_pedidos dp ON p.pedido_id = dp.pedido_id
    WHERE p.estado = 'completado'
      AND p.fecha > v_ultima_carga
      AND NOT EXISTS (
          SELECT 1
          FROM tienda.hechos_ventas hv
          WHERE hv.pedido_id = p.pedido_id
            AND hv.producto_id = dp.producto_id
      );

    GET DIAGNOSTICS v_filas = ROW_COUNT;

    -- Actualizar tabla de control
    UPDATE tienda.etl_control
    SET
        ultima_ejecucion = NOW(),
        ultimo_exito = NOW(),
        filas_procesadas = v_filas,
        estado = 'exitoso'
    WHERE proceso = 'etl_ventas';

    -- Registrar ejecución en el log
    INSERT INTO tienda.etl_log
        (proceso, inicio, fin, filas_procesadas, estado, mensaje)
    VALUES (
        'etl_ventas',
        v_inicio,
        NOW(),
        v_filas,
        'exitoso',
        FORMAT('Procesados %s registros. Desde: %s. Duración: %s ms',
               v_filas,
               v_ultima_carga,
               EXTRACT(MILLISECONDS FROM NOW() - v_inicio))
    );

    RAISE NOTICE 'ETL completado. % filas insertadas.', v_filas;

EXCEPTION WHEN OTHERS THEN
    -- Registrar error
    INSERT INTO tienda.etl_log
        (proceso, inicio, fin, filas_procesadas, estado, mensaje)
    VALUES (
        'etl_ventas',
        v_inicio,
        NOW(),
        0,
        'error',
        FORMAT('Error: %s', SQLERRM)
    );

    UPDATE tienda.etl_control
    SET
        ultima_ejecucion = NOW(),
        estado = 'error'
    WHERE proceso = 'etl_ventas';

    RAISE EXCEPTION 'ETL fallido. Ver etl_log. Error: %', SQLERRM;
END;
$$;