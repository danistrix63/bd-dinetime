-- Crear la base de datos
CREATE DATABASE dinetime;

-- Usar la base de datos
\c dinetime;

-- Tabla de Usuarios
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rol VARCHAR(20) DEFAULT 'usuario' CHECK (rol IN ('usuario', 'admin', 'restaurante'))
);

-- Tabla de Restaurantes
CREATE TABLE restaurantes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion TEXT NOT NULL,
    telefono VARCHAR(20),
    horario TEXT,
    capacidad INT,
    propietario_id INT REFERENCES usuarios(id) ON DELETE SET NULL
);

-- Tabla de Reservas
CREATE TABLE reservas (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    restaurante_id INT REFERENCES restaurantes(id) ON DELETE CASCADE,
    fecha_reserva TIMESTAMP NOT NULL,
    estado VARCHAR(20) DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'confirmada', 'cancelada'))
);

-- Tabla de Menús
CREATE TABLE menus (
    id SERIAL PRIMARY KEY,
    restaurante_id INT REFERENCES restaurantes(id) ON DELETE CASCADE,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL
);

-- Tabla de Reseñas
CREATE TABLE resenas (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    restaurante_id INT REFERENCES restaurantes(id) ON DELETE CASCADE,
    puntuacion INT CHECK (puntuacion BETWEEN 1 AND 5),
    comentario TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
------------------------------------------------------------------------------
*ELIMINAR*
-- Tabla de Facturación
CREATE TABLE facturacion (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    restaurante_id INT REFERENCES restaurantes(id) ON DELETE CASCADE,
    monto_total DECIMAL(10,2) NOT NULL,
    fecha_factura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago VARCHAR(20) CHECK (metodo_pago IN ('tarjeta', 'efectivo', 'paypal'))
);
