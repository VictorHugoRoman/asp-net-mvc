** triggers para validar proceso ventas **

CREATE OR REPLACE TRIGGER DEV_ADMIN.users_only_sales
	BEFORE INSERT ON VENTAS
	FOR EACH ROW
DECLARE	count_user NUMBER :=0;
BEGIN
	SELECT COUNT(*) INTO count_user
	FROM USUARIOS u
	WHERE u.id_usuario = :NEW.id_usuario AND u.rol = 'VENDEDOR';
	
	IF count_user < 1 THEN
		RAISE_APPLICATION_ERROR(-20005, 'Usuario no valido');
	END IF;
END;
/
CREATE OR REPLACE TRIGGER trg_descontar_stock
   AFTER INSERT ON VENTAS
   FOR EACH ROW
BEGIN
   UPDATE PRODUCTO p
   SET p.stock = p.stock - :NEW.cantidad
   WHERE p.id_producto = :NEW.id_producto;
   
   -- Validar stock no negativo
   IF SQL%ROWCOUNT = 0 THEN
       RAISE_APPLICATION_ERROR(-20001, 'Producto no encontrado');
   END IF;
END;
/
;
CREATE OR REPLACE TRIGGER trg_validar_stock
    BEFORE INSERT ON VENTAS
    FOR EACH ROW
DECLARE
    v_stock NUMBER;
BEGIN
    SELECT p.stock INTO v_stock 
    FROM producto p 
    WHERE p.id_producto = :NEW.id_producto;
    
    IF v_stock < :NEW.cantidad THEN
        RAISE_APPLICATION_ERROR(-20002, 'Stock insuficiente');
    END IF;
END;
/
--no lleva FOR EACH ROW se ejecuta un vez terminada la accion, por lo tanto 
--no tiene acceso al objeto NEW
CREATE OR REPLACE TRIGGER audit_eliminacion_empleados
AFTER DELETE ON PRODUCTO  -- Se ejecuta 1 vez tras la sentencia DELETE
DECLARE
  v_usuario VARCHAR2(100);
BEGIN
  SELECT USER INTO v_usuario FROM DUAL;
  INSERT INTO AUDITORIA_PRODUCTOS (accion, usuario, fecha)
  VALUES ('DELETE masivo', v_usuario, SYSDATE);
END;
/
--uso del WHEN, solo funcion con FOR EACH ROW
CREATE OR REPLACE TRIGGER valida_salario
BEFORE UPDATE OF salario ON EMPLEADOS  -- Solo si se modifica la columna "salario"
FOR EACH ROW  -- Por fila
WHEN (NEW.salario > 10000)  -- Condición
BEGIN
  IF :NEW.salario > 20000 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Salario no puede exceder 20,000');
  END IF;
END;
/