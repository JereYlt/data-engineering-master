CREATE OR REPLACE FUNCTION tienda.calcular_descuento(p_total DECIMAL)
RETURNS DECIMAL AS $$
DECLARE
    v_descuento DECIMAL := 0;
BEGIN
    IF p_total >= 2000 THEN
        v_descuento := p_total * 0.15;
    ELSIF p_total >= 500 THEN
        v_descuento := p_total * 0.10;
    ELSIF p_total >= 100 THEN
        v_descuento := p_total * 0.05;
    END IF;
    RETURN v_descuento;
END;
$$ LANGUAGE plpgsql;