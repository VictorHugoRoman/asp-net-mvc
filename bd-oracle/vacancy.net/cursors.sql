sintaxis 1
-- 1. DECLARACIÓN
CURSOR nombre_cursor [(parámetros)] IS
    SELECT columnas FROM tabla WHERE condicion;

-- 2. VARIABLE para almacenar datos
variable tipo_dato;

-- 3. OPERACIONES
OPEN nombre_cursor;         -- Abrir cursor
FETCH nombre_cursor INTO variable;  -- Obtener fila
CLOSE nombre_cursor;        -- Cerrar cursor

** EJECUCION **

1. DECLARACIÓN - Define la consulta:
    CURSOR c_productos IS
        SELECT id_producto, nombre, precio FROM producto WHERE activo = 'Y';

2. OPEN - Ejecuta la consulta:
    OPEN c_productos;

3. FETCH - Obtiene una fila:
    FETCH c_productos INTO v_id, v_nombre, v_precio; --Mueve puntero a siguiente fila
    Si no hay más filas %NOTFOUND = TRUE, funcionalidad de oracle
    
    ATRIBUTOS DE CONTROL:
    %FOUND - Encontró datos en último FETCH
    %NOTFOUND - No encontró datos
    %ROWCOUNT - Número de filas procesadas
    %ISOPEN - Cursor está abierto

4. CLOSE - Libera memoria:
    CLOSE c_productos;

** Ejemplo completo: **

DECLARE
    CURSOR c_productos IS SELECT nombre, precio FROM producto;
    v_nombre VARCHAR2(100);
    v_precio NUMBER;
BEGIN
    OPEN c_productos;                                -- 1. Abrir
    LOOP
        FETCH c_productos INTO v_nombre, v_precio;  -- 2. Obtener fila
        EXIT WHEN c_productos%NOTFOUND;             -- 3. ¿Hay datos?
        DBMS_OUTPUT.PUT_LINE(v_nombre || ': $' || v_precio);  -- 4. Procesar
    END LOOP;
    CLOSE c_productos;                               -- 5. Cerrar
END;