
### CRÉDITOS A Apple Coding Academy: https://github.com/applecodingacademy (la única academia de formación especializada en iOS y Swift en España)
## EXPLICACIÓN POR MI DEL PROYECTO
## App en Swift y SwiftUI: Clean Architecture + MVVM + Swift Testing

Dos cosas muy diferentes una es como funciona el framework y otra mmuy distinta es como monto una arquitectura.

Una arquitectura es la forma en la que vas a organizar la aplicación para que sea escalable, sostenible y mantenible en el tiempo.
- Escalable: hoy en dia se deben actualizar las Apps con nuevos requistos de los usuarios, arreglo de bugs, etc ya no existe el termino de software terminado.

Tener en cuenta que Swift es un lenguaje orientado a protocolos, se basa siempre en contratos que tu le dices al sistema que tiene que cumplir e icnluso puede llegar a incorporar ciertas funcionabilidades concretas.

SwiftUI tiene dos formas de funcionar:
- Hasta iOS 16: Observable Object, concepto de MVVM pero adaptado a Apple (su versión). Se cogen los eventos y se traspasaban de un lado a otro, es decir, por un lado tengo la parte del codigo que me da la funcionalidad de la aplicacion (lo que seria la logica de negocio) y por otro lado seria la vista que es lo que ve el usuario. Entonces la conexión entre la logica de  usuario y la vista estaba realizada a través de la librería Combine que proporciona los mecanismos para que las vistas reaccionen automáticamente a los cambios en los datos.

- A partir de iOS 17: @Observable. Sigue funcionando de la misma manera, es decir que la logica de negocio informa a la vista para que esta se refreje pero en vez de usar Combine empezo a utilizar Swift macros (se metio en Swift 5.9) que es una forma más moderna y sencilla de gestionar el estado y la reactividad, reemplazando parcialmente la necesidad de usar Combine para ciertas tareas. Nos permite ampliar la funcionalidad de las aplicaciones y crear un codigo que esta en parte dinamica y en parte normal como una especie de plantilla.

El MVVM que se explica en este proyecto respeta como funciona el framework de apple pero usando conceptos de Clearn Architecture que es el tipo de arquitentura que mas se adapta a cualquier tipo de comportamento, framework, etc.

Lo primero que se tiene que hacer es generar el Modelo: `Model`, es decir los datos. Una aplicación se crea para gestionar datos, sin datos no hay apps. El motivo de porque se realiza una aplicación y la fuente son siempre los datos.

Los datos van a venir a través de dos ficheros Json: `StarWars.json` (32 personajes) y `StarWars Test.json` (4 personajes, va a ser el fichero de prueba con al misma estructura que el anterior pero con menos elementos (personajes)). Estos personajes de StarWars además tienen una serie de imagenes que iremos cargando en `Assets`.

Obviamente de 32 a 4 elementos no tiene sentido, pero si en un futuro en producción tuvieramos 500, pues ya si lo tendria, pero esto es un ejemplo.

Vamos a cargar estos ficheros Json `StarWars.json` en el directorio principal y `StarWars Test.json` dentro de 'Preview Content', aqui es dond e voy a poner el contenido de datos de prueba que no quiero que se suba a la App Store.

1. Fichero: `ContentView.swift`:
Este fichero existe cuando creas la App. Aqui se explica que es un protocolo y lo que conlleva esto.

2. Creación del fichero: `Model.swift`
Es donde se va a definir la estructura de la información (json en este caso, podria ser en otro caso de una Api, BD...).
Creamos el DTO 'StarCardDTO' con la estructura igual al json, la presentación 'StarCard' con la estructura que queremos utilizar en la app, y la extensión para transformar de manera directa del DTO a la presentación.

3. Creación del fichero: `Repository.swift`
Es donde vamos a cargar la información, se encarga de la lógica para tener acceso a la persistencia de la información.
Creamos un protocolo, con una extension, y dos estructuras (una para la producción y otra para el desarrollo)

4. Creación del fichero: `StarCardVM.swift` (View Model)
Se llama al protocolo creado, donde lo interesante que se llama como un tipo el cual puede recibir cualquiera de los datos que llamen a ese protocolo (tanto la estructura de producción como de desarrollo) y después se hace la comprobación de errores (heredada del Repository) para devolver o no los datos finales del json, donde se pone por defecto la estructura de producción, pero luego en el `ContentView.swift` se puede cambiar facilmente.

5. Creación del fichero: `StarCardView.swift`
Es la vista secundarioa que se llama en el `ContentView.swift`

Volvemos al `ContentView.swift`:
Se llamaria al `StarCardVM.swift` y de hay se obtendrian los datos para mostrarlos por pantalla, siempre que se quiera se va a poder cambiar el StarCardVM con el parámetro dentro de desarrollo para que devuelva solo dichos datos en vez de los de defecto que son los de producción. Tanto en el simulador como en la Preview()

6. Le damos a la primera carpeta principal de todas `StarWarsDemo` (el cual es el ejecutable de nuestra aplicación) y hay vemos que es un 'Target', lo que vamos a hacer es crear otro 'Target' que va a ser dentro de 'iOS' un 'Unit Testing Bundle' para hacer testing llamado: `StarWarsDemoTest`.
Aqui esta el testing de la aplicación.

## 🚀 README DEL PROYECTO (de Apple Coding Academy)
VIDEO: `https://www.youtube.com/watch?v=4JlSxaIWRJ0`

La aplicación, desarrollada con **Swift** y **SwiftUI**, explora la implementación de una arquitectura **Clean Architecture** basada en el patrón **MVVM** (Model-View-ViewModel).

## 🏗️ Arquitectura: Clean Architecture sobre MVVM

En este proyecto, se profundiza en la construcción de una app siguiendo los principios de **Clean Architecture** aplicados a **MVVM**. La arquitectura está orientada a la **programación basada en protocolos** y al uso de **patrones de diseño** para mejorar la modularidad, la mantenibilidad y la facilidad de pruebas del código.

### ✨ Características clave:

- **Protocolos y Patrones de Diseño:** Uso del patrón de diseño con dobles en programación orientada a protocolos para desacoplar la lógica de la app de las fuentes de datos, permitiendo tener datos de producción y de preview separados en un mismo protocolo `RepositoryData`.
- **Programación orientada a protocolos:** Se demuestra cómo utilizar protocolos para abstraer la lógica de negocio y separar las responsabilidades, facilitando las pruebas unitarias y el mantenimiento del código.
- **Datos de producción vs. Preview:** Ejemplo claro de cómo tener datos de producción y de preview de manera separada dentro del mismo protocolo, utilizando el patrón de repositorio.

## 🧪 Pruebas: Swift Testing

Durante la demostración, se realizó una introducción básica al uso de la librería **Swift Testing**, mostrando cómo crear y ejecutar pruebas unitarias para validar la funcionalidad de la aplicación y garantizar su correcto funcionamiento en diferentes escenarios.

## 📄 Licencia

Este proyecto se distribuye bajo la licencia **MIT**. Consulta el archivo `LICENSE` para más detalles.
