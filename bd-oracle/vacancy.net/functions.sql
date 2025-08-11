CREATE [OR REPLACE] FUNCTION nombre_funcion (p1 [IN] tipo_dato, p2 [IN] tipo_dato) RETURN tipo_retorno
[DETERMINISTIC]
[PIPELINED]
AS | IS
    -- Variables locales
    variable tipo_dato;
BEGIN
    -- Lógica de la función
    RETURN valor;
EXCEPTION
    WHEN excepcion THEN
        -- Manejo de errores
END [nombre_funcion];
COMPONENTES:
1. Parámetros:
    IN (default) - Solo entrada
    Solo IN en funciones (no OUT/IN OUT)
2. RETURN:
    Obligatorio - tipo de dato que retorna
    Debe haber al menos un RETURN valor en el código
3. Cláusulas opcionales:
    DETERMINISTIC - Mismo input = mismo output
    PIPELINED - Para retornar colecciones fila por fila
/
** ejemplos **
CREATE OR REPLACE FUNCTION calcular_iva(p_monto NUMBER) RETURN NUMBER AS
BEGIN
    RETURN p_monto * 0.16;
END;
/.
CREATE OR REPLACE FUNCTION get_categoria_producto(p_id NUMBER) RETURN VARCHAR2 AS
    v_categoria VARCHAR2(100);
BEGIN
    SELECT c.nombre INTO v_categoria
    FROM producto p
    INNER JOIN categoria c ON p.id_categoria = c.id_categoria
    WHERE p.id_producto = p_id;
    
    RETURN v_categoria;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Sin categoría';
END;
/
DETERMINISTIC
-- Sin DETERMINISTIC - Oracle recalcula cada vez
CREATE OR REPLACE FUNCTION calcular_descuento(p_precio NUMBER) RETURN NUMBER AS
BEGIN
    -- Lógica costosa que Oracle ejecutará siempre
    RETURN p_precio * 0.15;
END;

-- Con DETERMINISTIC - Oracle cachea el resultado
CREATE OR REPLACE FUNCTION calcular_descuento_opt(p_precio NUMBER) RETURN NUMBER 
DETERMINISTIC AS
BEGIN
    -- Oracle cachea: mismo precio = mismo descuento
    RETURN p_precio * 0.15;
END;

Uso en consulta:
sql-- Oracle optimiza y cachea resultados con DETERMINISTIC
SELECT nombre, precio, calcular_descuento_opt(precio) as descuento
FROM producto;
/

PIPELINED - Ejemplo:
sql-- Definir tipo de colección
CREATE OR REPLACE TYPE t_producto_row AS OBJECT (
    id NUMBER,
    nombre VARCHAR2(100),
    precio NUMBER
);

CREATE OR REPLACE TYPE t_producto_table AS TABLE OF t_producto_row;

-- Función PIPELINED
CREATE OR REPLACE FUNCTION get_productos_caros(p_precio_min NUMBER) 
RETURN t_producto_table PIPELINED AS
BEGIN
    FOR rec IN (SELECT id_producto, nombre, precio FROM producto WHERE precio > p_precio_min) LOOP
        -- PIPE ROW retorna fila por fila (no toda la colección)
        PIPE ROW(t_producto_row(rec.id_producto, rec.nombre, rec.precio));
    END LOOP;
    RETURN; -- Obligatorio al final
END;
/
Uso como tabla virtual:
sql-- Se usa como una tabla en FROM
SELECT * FROM TABLE(get_productos_caros(500));

-- Join con otras tablas
SELECT p.nombre, c.nombre as categoria
FROM TABLE(get_productos_caros(500)) p
JOIN categoria c ON p.id = c.id_categoria;
Ventajas PIPELINED:

Retorna datos streaming (fila por fila)
Menos memoria que retornar toda la colección
Se puede usar en SQL como tabla