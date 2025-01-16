//
//  Repository.swift
//  StarWarsDemo
//
//  Created by Carlos Caño on 7/1/25.
//

import Foundation

// 4_Creamos un protocolo para aislar a un variable la URL, para que se pueda inyectar un valor distinto de URL y poder intercambiar de forma sencilla entre el json de producción y de testing
protocol DataRepository {
    var url: URL { get /*set*/ } // se comenta el set porque solo se va a recuperar una url y no necesitamos asignarla, si no se descomentaria el set
}

// 5_Es una extensión del protocolo creado 'DataRepository' el cual puede recoger las variables de DataRepository y viceversa. Estoy añadiendo esta nueva función al propio protocolo 'DataRepository'.
extension DataRepository {
    
    // 3_Función para devolver los datos en [StarCard] al carga la información del json de [StarCardDto] (a través de la transformación con la extensión de StarCardDto)
    func getData() throws -> [StarCard] {
        let data = try Data(contentsOf: url) // 'Data' es un buffer de bits en memoria que permite pasarle diferentes contructores como 'contentsOf' en caso de la url. Es decir lo que hace es cargar los datos en bruto de la URL en memoria. Hay que añadir el 'try', hay que gestionar los errores, ya que s epuede producir un error grave que haga inestable la aplicación.
        // Se puede gestionar de dos formas:
        
        // 1. A nivel de lanzamiento del error seria poner:
        /**
            do  {
                let data =  Data(contentsOf: url)
            }  catch {
                print("Error obtenido es : \(error)")
            }
         */
        
        // 2. Pero si lo que quiero es que la llamada no sea gestionada aqui, sino mas a delante en otro momento de la aplicación donde yo ya me encargare de ver ese posible error, por ejemplo para comunicarselo a los usuarios a través de una alerta, lo que hago es poner solo el try. De manera que todos los try si dan error va hacer que se propage solo el error y el que llame a 'getData' va a tener que llamarlo con 'try getData', es decir se pasa el error hacia arriba. Es la manera que lo tengo hecho en este caso.
        /** let data = try Data(contentsOf: url)  */
        
        let decoder = JSONDecoder() // creamos el decoficador
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase // convertimos todos los datos para que lo parsee de camelCase a snake_case (recordamos la variable planetaOrigen). Esto es muy util porque se puede realizar tambien para otras parsee como el caso de un fecha del json de tipo cadena a tipo Fecha, etc.
        
        return try decoder.decode([StarCardDTO].self, from: data).map(\.toCard) // se devuelve la llamada al decodicador, donde indicamos el tipo de dato que voy a trasformar del json que he leido [StarCardDTO] y este se mapea llamando a la extensión de transformación de StarCardDTO a StarCard para que nos devolvera el [StarCard]
    }
}

// 6_El struct tiene el protocolo 'DataRepository' el cual tiene los métodos 'url' y 'getData()' (la extensión), la variable 'url' como sucede en los protocolos obliga a implementarla  en el struct al que se llama
struct Repository: DataRepository {
    // 1_
    var url: URL {
        Bundle.main.url(forResource: "StarWars", withExtension: "json")! // esta llamada devuelve la ruta real en el dispositivo donde se encuentra el fichero 'StarWars.json', es un valor opcional, como sabemos que exite añadimos el '!', podriamos poner un ternario o valor nil (?) si no estamos seguros de que existiese el json para devolver ese caso otro valor
    }
}

// 7_El struct tiene el protocolo 'DataRepository' el cual tiene la variable 'url', lo cual hace que sea obligatoria implementarla esa variable en este struct
struct RepositoryTest: DataRepository {
    // 2_
    var url: URL {
        Bundle.main.url(forResource: "StarWars Test", withExtension: "json")! // esta llamada devuelve la ruta real en el dispositivo donde se encuentra el fichero StarWars Test.json, es un valor opcional, como sabemos que exite añadimos el '!', podriamos poner un ternario o valor nil (?) si no estamos seguros de que existiese el json para devolver ese caso otro valor
    }
}
