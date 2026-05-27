--Query 1 – Ventas por semana
SELECT
    DATE_TRUNC('week', fecha)::DATE AS semana_inicio,
    COUNT(DISTINCT pedido_id) AS num_pedidos,
    COUNT(DISTINCT cliente_id) AS clientes_unicos,
    SUM(subtotal) AS ventas_totales,
    ROUND(AVG(subtotal), 2) AS subtotal_promedio
FROM tienda.hechos_ventas
GROUP BY semana_inicio
ORDER BY semana_inicio;


--Query 2 – Top 5 productos por ingresos
SELECT
    pr.nombre AS producto,
    pr.categoria,
    SUM(hv.cantidad) AS unidades_vendidas,
    SUM(hv.subtotal) AS ingresos_totales,
    RANK() OVER (ORDER BY SUM(hv.subtotal) DESC) AS ranking
FROM tienda.hechos_ventas hv
JOIN tienda.productos pr ON hv.producto_id = pr.producto_id
GROUP BY pr.producto_id, pr.nombre, pr.categoria
ORDER BY ingresos_totales DESC
LIMIT 5;


--Query 3 – Análisis RFM sobre hechos_ventas
WITH rfm_base AS (
    SELECT
        cliente_id,
        CURRENT_DATE - MAX(fecha) AS recency_dias,
        COUNT(DISTINCT pedido_id) AS frequency,
        SUM(subtotal) AS monetary
    FROM tienda.hechos_ventas
    GROUP BY cliente_id
),
rfm_scores AS (
    SELECT
        cliente_id,
        recency_dias,
        frequency,
        monetary,
        4 - NTILE(3) OVER (ORDER BY recency_dias DESC) AS r_score,
        NTILE(3) OVER (ORDER BY frequency) AS f_score,
        NTILE(3) OVER (ORDER BY monetary) AS m_score
    FROM rfm_base
)
SELECT
    c.nombre,
    c.ciudad,
    rs.r_score,
    rs.f_score,
    rs.m_score,
    rs.r_score + rs.f_score + rs.m_score AS rfm_total,
    CASE
        WHEN rs.r_score + rs.f_score + rs.m_score >= 8 THEN 'VIP'
        WHEN rs.r_score + rs.f_score + rs.m_score >= 5 THEN 'Regular'
        ELSE 'En Riesgo'
    END AS segmento
FROM rfm_scores rs
JOIN tienda.clientes c ON rs.cliente_id = c.cliente_id
ORDER BY rfm_total DESC;
