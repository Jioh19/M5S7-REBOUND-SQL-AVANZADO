-- 1. Listar los clientes sin ventas por medio de una subconsulta.
SELECT rut, nombre 
FROM (
    SELECT cliente.rut, cliente.nombre, venta.folio 
    FROM cliente LEFT JOIN venta ON venta.rut = cliente.rut
    ) AS seleccion  WHERE folio IS NULL;

-- 2. Listar todas ventas con las siguientes columnas: Folio, Fecha, Monto, NombreCliente,
-- RutCliente.
SELECT folio, fecha, monto, nombre, cliente.rut 
    FROM venta LEFT JOIN cliente ON venta.rut = cliente.rut;

-- 3. Clasificar los clientes según la siguiente tabla:
SELECT cliente.rut, cliente.nombre, SUM(monto), EXTRACT(YEAR FROM fecha) as Año
    FROM cliente INNER JOIN venta ON venta.rut = cliente.rut 
        GROUP BY  cliente.rut, EXTRACT(YEAR FROM fecha)
			ORDER BY año;

-- 4. Por medio de una subconsulta, listar las ventas con la marca del vehículo más vendido.
SELECT s.marca AS "Más vendido", COUNT(*) AS "Cantidad", SUM(monto) AS "Total" 
    FROM (SELECT * FROM venta INNER JOIN vehiculo ON venta.idvehiculo = vehiculo.idvehiculo) AS S
        GROUP BY s.marca ORDER BY "Cantidad" DESC LIMIT 1;
