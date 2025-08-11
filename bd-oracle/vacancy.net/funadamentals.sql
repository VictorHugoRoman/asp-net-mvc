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