--categorias
INSERT INTO
    categoria
VALUES
    (
        1,
        'Electrónicos',
        'Productos electrónicos y tecnología'
    );

INSERT INTO
    categoria
VALUES
    (2, 'Ropa', 'Prendas de vestir y accesorios');

INSERT INTO
    categoria
VALUES
    (
        3,
        'Hogar',
        'Artículos para el hogar y decoración'
    );

--productos por categoria
-- Productos Electrónicos (id_categoria = 1)
INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Smartphone Samsung', 599.99, 25, 1);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Laptop HP', 899.50, 15, 1);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Tablet iPad', 449.99, 30, 1);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Auriculares Sony', 129.99, 50, 1);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Smart TV 55"', 699.99, 10, 1);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Cámara Canon', 799.99, 8, 1);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Consola PlayStation', 499.99, 20, 1);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Smartwatch Apple', 349.99, 35, 1);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Parlante Bluetooth', 89.99, 40, 1);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Mouse Gaming', 59.99, 60, 1);

COMMIT;

-- Productos Ropa (id_categoria = 2)
INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Camiseta Polo', 29.99, 100, 2);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Jeans Levis', 79.99, 50, 2);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Chaqueta Nike', 129.99, 30, 2);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Zapatos Adidas', 99.99, 40, 2);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Vestido Casual', 49.99, 25, 2);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Camisa Formal', 39.99, 35, 2);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Pantalón Chino', 59.99, 45, 2);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Blusa Elegante', 34.99, 55, 2);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Shorts Deportivos', 24.99, 70, 2);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Abrigo Invierno', 149.99, 15, 2);

-- Productos Hogar (id_categoria = 3)
INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Sofá 3 Plazas', 599.99, 12, 3);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Mesa Comedor', 399.99, 8, 3);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Lámpara LED', 79.99, 25, 3);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Alfombra Persa', 199.99, 20, 3);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Espejo Decorativo', 89.99, 30, 3);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Cojines Decorativos', 19.99, 80, 3);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Cortinas Blackout', 49.99, 35, 3);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Jarrón Cerámico', 34.99, 45, 3);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Cuadro Abstracto', 129.99, 22, 3);

INSERT INTO
    producto (nombre, precio, stock, id_categoria)
VALUES
    ('Estantería Madera', 159.99, 18, 3);

--usuarios
INSERT
    ALL INTO usuarios (ID_USUARIO, nombre, email, password, rol)
VALUES
    (
        1,
        'Juan Pérez',
        'admin@empresa.com',
        'admin123',
        'ADMIN'
    ) INTO usuarios (ID_USUARIO, nombre, email, password, rol)
VALUES
    (
        2,
        'María García',
        'vendedor@empresa.com',
        'vend123',
        'VENDEDOR'
    ) INTO usuarios (ID_USUARIO, nombre, email, password, rol)
VALUES
    (
        3,
        'Renato Ibarra',
        'vendedor2@empresa.com',
        'vend123',
        'VENDEDOR'
    ) INTO usuarios (ID_USUARIO, nombre, email, password, rol)
VALUES
    (
        4,
        'Carlos López',
        'cliente@email.com',
        'cliente123',
        'CLIENTE'
    )
SELECT
    *
FROM
    dual;

--Ventas
INSERT INTO
    ventas (id_producto, cantidad, id_usuario, total)
VALUES
    (1, 2, 1, 1199.98);