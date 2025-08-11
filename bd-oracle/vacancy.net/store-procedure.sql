--1. Parámetros OUT (valor escalar):
CREATE OR REPLACE PROCEDURE get_precio(p_id IN NUMBER, p_precio OUT NUMBER) AS
BEGIN
    SELECT precio INTO p_precio FROM producto WHERE id_producto = p_id;
END;

--2. Parámetros OUT (tabla via cursor):
CREATE OR REPLACE PROCEDURE get_productos(p_cursor OUT SYS_REFCURSOR) AS
BEGIN
    OPEN p_cursor FOR SELECT * FROM producto;
END;

--3. Parámetros IN OUT (referencia):
CREATE OR REPLACE PROCEDURE incrementar(p_valor IN OUT NUMBER) AS
BEGIN
    p_valor := p_valor + 1;
END;

--no es recomendable usar procedimientos desde el cliente ya que los procedures la manera 
--de devolver un valor es mediante out,es decir, por referencia
--ejemplo  
-- Parámetro IN
-- cmd.Parameters.Add("p_id", OracleDbType.Int32).Value = 1;
-- Parámetro OUT
--    cmd.Parameters.Add("p_pr

--** procedimiento reporte ventas usuario **

CREATE OR REPLACE PROCEDURE proc_reporte_ventas_usuarios AS
    CURSOR c_ventas_usuarios IS -- Declarar cursor explicito, estos tipos de cursores son mas versatiles y se declaran aqui o nl cuerpo del procedure
        SELECT u.id_usuario,u.nombre AS nombre_usuario,u.email,
            p.id_producto,p.nombre AS nombre_producto,p.precio,
            v.cantidad,v.total,v.fecha_venta
        FROM usuarios u
        INNER JOIN ventas v ON u.id_usuario = v.id_usuario
        INNER JOIN producto p ON v.id_producto = p.id_producto
        ORDER BY u.nombre, v.fecha_venta;
BEGIN    
    OPEN c_ventas_usuarios;    
    LOOP
        -- Fetch datos del cursor
        FETCH c_ventas_usuarios INTO 
            v_id_usuario, v_nombre_usuario, v_email, 
            v_id_producto, v_nombre_producto, v_precio,
            v_cantidad, v_total, v_fecha_venta;
        
        -- Salir si no hay más registros
        EXIT WHEN c_ventas_usuarios%NOTFOUND;
    END LOOP;
    CLOSE c_ventas_usuarios;
END proc_reporte_ventas_usuarios;


--** procedimiento ventas totales por usuario **
CREATE OR REPLACE PROCEDURE proc_totales_ventas_usuarios AS
    -- Variables para el cursor
    v_id_usuario NUMBER;
    v_nombre_usuario VARCHAR2(100);
    v_email VARCHAR2(150);
    v_total_usuario NUMBER;
    v_cantidad_ventas NUMBER;
    
    -- Variables de control
    v_gran_total NUMBER := 0;
    v_total_usuarios NUMBER := 0;
    
BEGIN
    -- Declarar y abrir cursor en el cuerpo del procedure, es implicito y no es posible usarlo en declares section
    FOR rec IN (
        SELECT 
            u.id_usuario,u.nombre,u.email,SUM(v.total) AS total_ventas,COUNT(v.id_venta) AS cantidad_ventas
        FROM usuarios u
        INNER JOIN ventas v ON u.id_usuario = v.id_usuario
        GROUP BY u.id_usuario, u.nombre, u.email
        ORDER BY SUM(v.total) DESC
    ) LOOP        
        -- Los datos están disponibles como rec.campo
        v_id_usuario := rec.id_usuario;
        v_nombre_usuario := rec.nombre;
        v_email := rec.email;
        v_total_usuario := rec.total_ventas;
        v_cantidad_ventas := rec.cantidad_ventas;        
        
        -- Acumular totales generales
        v_gran_total := v_gran_total + v_total_usuario;
        v_total_usuarios := v_total_usuarios + 1;
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total de Usuarios con Ventas: ' || v_total_usuarios);
    DBMS_OUTPUT.PUT_LINE('Gran Total de Ventas: $' || TO_CHAR(v_gran_total, '999,999.99'));
    
    IF v_total_usuarios > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Promedio por Usuario: $' || TO_CHAR(v_gran_total/v_total_usuarios, '999,999.99'));
    END IF;
    
    -- Cursor adicional inline para mostrar usuarios sin ventas
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('=== USUARIOS SIN VENTAS ===');
    
    FOR rec_sin_ventas IN (
        SELECT u.nombre, u.email 
        FROM usuarios u
        LEFT JOIN ventas v ON u.id_usuario = v.id_usuario
        WHERE v.id_usuario IS NULL
        ORDER BY u.nombre
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('- ' || rec_sin_ventas.nombre || ' (' || rec_sin_ventas.email || ')');
    END LOOP;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron ventas registradas.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END proc_totales_ventas_usuarios;
/

-- Para ejecutar:
-- SET SERVEROUTPUT ON;
-- EXEC proc_totales_ventas_usuarios;
