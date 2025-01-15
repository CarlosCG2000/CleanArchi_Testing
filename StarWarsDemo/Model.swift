//
//  Model.swift
//  StarWarsDemo
//
//  Created by Carlos Caño on 7/1/25.
//

import Foundation // librería básica de Swift que incorpora las cadenas, url, localizaciones, red...

// 1_Vamos a trabajar con deserialización, es decir vamos a coger un archivo almacenado en un fichero json y convertirlo a una instancia: estructura u objeto.
// Contiene los mismo datos (estructura) de un elemento del fichero json ('StarWars' o 'StarWars Text', ya que tienen la misma estructura).
// Se usa el DTO (Data Transform Object), porque yo quiero convertir la estructura del json a otro formato que para que a mi sea más util trabajar en la App.
// Tiene el protocolo 'Codable' para que pueda cargarse la información del json y transformarse en instancias.
struct StarCardDTO: Codable {
    let id: Int
    let nombre: String
    let raza: String
    let descripcion: String
    let planetaOrigen: String // ¡ojo! en el json se encuentra planeta_origen (snake_case) en ve de planetaOrigen (camelCase)
    let epoca: String
    let afiliacion: String // lo quiero en un array de string. Actual formato: 'Alianza Rebelde, Nueva República'
    let habilidades: String // lo quiero en un array de string. Actual formato: 'Uso de la Fuerza, combate con sable de luz, pilotaje'
    let armas: String // lo quiero en un array de string. Actual formato: 'Armadura Mandaloriana, blaster, jetpack'.
    let imagen: String
}

// 3_La transformación de 'StarCardDTO' a 'StarCard'
// Es una extensión de `struct StarCardDTO` (por lo que se podria poner en un fichero aparte)
// Todo lo que se ponga aquí es algo que se va a incluir a lo que se tiene en el `struct StarCardDTO`
extension StarCardDTO {
//  toCard: es una propiedad calculada, que no almacena valores sino que cada vez que se la llama devuelve algo que calcula o transforma en tiempo real (como un patrón setter - getter en Java)
    var toCard: StarCard {
        StarCard(id: id,
                 nombre: nombre,
                 raza: raza,
                 descripcion: descripcion,
                 planetaOrigen: planetaOrigen,
                 epoca: epoca,
                 // Dividir el string `*` en un array de subcadenas separadas por ', ' y que la primera letra de cada elemento me la trasnforme en mayúscula.
                 afiliacion: afiliacion.components(separatedBy: ", ").map(\.capitalized), // *
                 habilidades: habilidades.components(separatedBy: ", ").map(\.capitalized), // *
                 armas: armas.components(separatedBy: ", ").map(\.capitalized), // *
                 imagen: imagen)
    }
}

// 2_Igual que el 'StarCardDTO', pero con la estructura que queremos utilizar en la app (pasando de String a [String] los campos: afiliacion habilidades, armas y tampoco tiene el protocolo es Codable sino los protocolos Identifiable, Hashable
// Protocolo 'Identifiable': va a tener un campo 'id' que sera igualable, es decir único.
// Protocolo 'Hashable': permite tener un valor de hash, un valor de comprobación único. Cuando en todas sus estancias sean iguales es cuando se va a poder comparar por igualdad. Es decir pueden ser dos instancias diferentes pero si tienen todos los mismos valores los compararía como iguales.
struct StarCard: Identifiable, Hashable {
    let id: Int
    let nombre: String
    let raza: String
    let descripcion: String
    let planetaOrigen: String
    let epoca: String
    let afiliacion: [String]
    let habilidades: [String]
    let armas: [String]
    let imagen: String
}

// 4_Instancia de ejemplo para el TEST, siempre recomendable para ver la visualización en la preview.
extension StarCard {
    static let test = StarCard(id: 6629,
                               nombre: "Luke Skywalker",
                               raza: "Humano",
                               descripcion: "Héroe de la Alianza Rebelde y Caballero Jedi. Hijo de Anakin Skywalker y Padmé Amidala.",
                               planetaOrigen: "Tatooine",
                               epoca: "Era del Imperio Galáctico",
                               afiliacion: ["Alianza Rebelde", "Nueva República"],
                               habilidades: ["Uso de la Fuerza", "Combate con sable de luz", "Pilotaje"],
                               armas: ["Sable de luz"],
                               imagen: "lukeskywalker")
}

