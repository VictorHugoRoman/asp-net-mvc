** tipos de datos **

Tipos Numéricos:
	NUMBER - Decimales y enteros
	NUMBER(p,s) - Precisión y escala específica
	INTEGER - Enteros
	BINARY_INTEGER - Enteros optimizados
	PLS_INTEGER - Más rápido que INTEGER

Tipos Carácter:
	VARCHAR2(n) - Cadena variable hasta n caracteres, charset de la base (ej: AL32UTF8, WE8ISO8859P1),Datos en idioma local/inglés
	CHAR(n) - Cadena fija de n caracteres
	NVARCHAR2(n) - Unicode variable, Siempre Unicode (UTF-8/UTF-16), Datos multiidioma o símbolos especiales
	NCHAR(n) - Unicode fijo
	CLOB - Texto largo (hasta 4GB)

Tipos Fecha/Hora:
	DATE - Fecha y hora
	TIMESTAMP - Fecha/hora con microsegundos
	INTERVAL - Intervalos de tiempo

Tipos Boolean (solo PL/SQL):
	BOOLEAN - TRUE/FALSE/NULL

Tipos Binarios:
	RAW(n) - Datos binarios pequeños
	BLOB - Datos binarios grandes (hasta 4GB)

Tipos Especiales:
	ROWID - Identificador de fila física
	UROWID - Identificador universal de fila

** EXCEPCIONES **

EXCEPCIONES PREDEFINIDAS COMUNES:
NO_DATA_FOUND:-- Cuando SELECT INTO no encuentra filas
SELECT nombre INTO v_nombre FROM usuario WHERE id = 999; -- Lanza NO_DATA_FOUND si no existe

TOO_MANY_ROWS: -- Cuando SELECT INTO encuentra múltiples filas
SELECT nombre INTO v_nombre FROM usuario WHERE activo = 'Y'; -- Lanza TOO_MANY_ROWS si hay varios usuarios activos

DUP_VAL_ON_INDEX:-- Violación de constraint UNIQUE o PRIMARY KEY
INSERT INTO usuario (id, email) VALUES (1, 'test@test.com'); -- Lanza DUP_VAL_ON_INDEX si id=1 ya existe

VALUE_ERROR:-- Error de conversión de tipos o tamaño
DECLARE 
	v_nombre VARCHAR2(5);
BEGIN
    v_nombre := 'Nombre muy largo'; -- Lanza VALUE_ERROR
END;

ZERO_DIVIDE: -- División por cero
v_resultado := 100 / 0; -- Lanza ZERO_DIVIDE

INVALID_NUMBER:-- Conversión de texto a número inválida
v_numero := TO_NUMBER('ABC'); -- Lanza INVALID_NUMBER

MANEJO DE EXCEPCIONES:
BEGIN
    SELECT precio INTO v_precio FROM producto WHERE id = p_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Producto no encontrado');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Múltiples productos encontrados');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
	OTHERS: captura cualquier excepción no manejada específicamente.
	SQLERRM: devuelve el mensaje de error completo.


**  ATRIBUTOS DE CONTROL **
	son usados en los loop y oracle los administra automaticamente
	Son atributos de cursor (cursor attributes) - propiedades que Oracle mantiene automáticamente para controlar 
	el estado de los cursors.
SINTAXIS:
	sqlcursor_name%atributo --para cursores que declaramos
	SQL%atributo  -- Para cursors implícitos (INSERT, UPDATE, DELETE, SELECT INTO)

PRINCIPALES ATRIBUTOS:
%FOUND: -- TRUE si el último FETCH encontró datos
FETCH c_productos INTO v_producto;
IF c_productos%FOUND THEN
    -- Procesar datos
END IF;
%NOTFOUND: -- TRUE si el último FETCH NO encontró datos
LOOP
    FETCH c_productos INTO v_producto;
    EXIT WHEN c_productos%NOTFOUND;  -- Salir cuando no hay más datos
END LOOP;
%ROWCOUNT: -- Número de filas procesadas hasta ahora
DBMS_OUTPUT.PUT_LINE('Procesadas: ' || c_productos%ROWCOUNT);
%ISOPEN: -- TRUE si el cursor está abierto
IF NOT c_productos%ISOPEN THEN
    OPEN c_productos;
END IF;

EJEMPLOS CON SQL% (cursors implícitos): 

-- Para INSERT/UPDATE/DELETE
UPDATE producto SET precio = precio * 1.1 WHERE categoria = 'Electronics';
IF SQL%ROWCOUNT > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Actualizados: ' || SQL%ROWCOUNT || ' productos');
ELSE
    DBMS_OUTPUT.PUT_LINE('No se actualizó ningún producto');
END IF;

-- Para SELECT INTO
BEGIN
    SELECT nombre INTO v_nombre FROM usuario WHERE id = 1;
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Usuario encontrado: ' || v_nombre);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Usuario no existe');
END;
Son como "sensores" que Oracle actualiza automáticamente para darte información sobre 
el estado de tus consultas.