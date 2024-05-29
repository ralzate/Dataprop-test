# README

Esta es una aplicación simple de bienes raíces construida con Ruby on Rails. Los usuarios pueden crear, editar y eliminar listados de propiedades. Incluye características como buscar propiedades por tipo, rango de precios, dormitorios y baños.

## Modelos

### District
Representa un distrito o área donde se encuentran las propiedades.
Asociaciones: `has_many`

### Property
Representa un listado de propiedad de bienes raíces.
Atributos: property_type, price, currency, address, area, bedrooms, bathrooms, latitude, longitude, description
Asociaciones: `belongs_to :user`, `belongs_to :district`, `has_many_attached :photos`
Enumeraciones: property_type, currency
Métodos: converted_price, property_types_for_select, currencies_for_select, usd_to_clp, clp_to_usd

### User
Representa un usuario de la aplicación.
Asociaciones: `has_many :properties`
Módulos Devise: :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

## Controladores
DistrictsController: Maneja operaciones CRUD para distritos.
PropertiesController: Maneja operaciones CRUD para propiedades.
HomeController: Muestra la página de inicio y listados de propiedades.

## Vistas
properties/: Vistas para acciones relacionadas con propiedades.
districts/: Vistas para acciones relacionadas con distritos.
layouts/: Archivos de diseño de la aplicación.

## Rutas
Ruta raíz: Home#index
Rutas CRUD para propiedades y distritos
Rutas Devise para autenticación de usuario

## Gemas Utilizadas
devise: Para autenticación de usuario
leaflet-rails: Para mapas interactivos
httparty: Para solicitudes HTTP
kaminari: Para paginación
faker: Para generar datos falsos en desarrollo y pruebas

## Instrucciones de Configuración
1. Clona el repositorio: `git clone https://github.com/ralzate/Dataprop-test`
2. Instala las dependencias: `bundle install`
3. Configura la base de datos: `rails db:create db:migrate`
4. Ejecuta el servidor: `rails server`
5. Accede a la aplicación en tu navegador en [http://localhost:3000](http://localhost:3000).