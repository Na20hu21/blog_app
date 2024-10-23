# Flutter Blog App

Esta aplicación es un ejemplo de blog desarrollado en Flutter, que utiliza Clean Architecture e implementa el patrón BLoC para la gestión del estado. Los datos de los posts se obtienen de la API pública de [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts), y se presentan en una interfaz con scroll infinito y una TabBar fija.

## Características

- Clean Architecture: El proyecto sigue una estructura de capas (Domain, Data, y Presentation) para facilitar la mantenibilidad y escalabilidad del código.
- BLoC para la gestión del estado: Se utiliza el patrón BLoC (Business Logic Component) para manejar el estado de la aplicación y separar la lógica de negocio de la interfaz de usuario.
- Consumo de API: Los datos se obtienen de una API REST, consumida con el paquete `http`.
- Scroll Infinito: La lista de posts tiene scroll infinito, cargando más contenido conforme el usuario navega hacia abajo.
- Interfaz de Usuario: La UI sigue los principios de Material Design con un `TabBar` y una lista de posts renderizados con el widget `Card`.


