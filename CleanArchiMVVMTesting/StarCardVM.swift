//
//  StarCardVM.swift
//  StarWarsDemo
//
//  Created by Carlos Caño on 7/1/25.
//

import SwiftUI

@Observable // 1_Se anota la clase de tipo observable, que es lo que me va a permitir que cualquier propiedad variable que haya en la clase cuando se actualice la clase al ponerla en una vista se refresque la vista
final class StarCardVM {
    let repository: DataRepository // 2_Llamamos al protocolo DataRepository, que lo curioso es que tambien es un tipo de dato. Y dentro de la variable va a estar tanto la instancia del Struct de 'Repository' como de 'RepositoryTest', las cuales tienen el protocolo DataRepository.
    
    var cards: [StarCard] // 3_Variable de los datos
    
    // 4_Creamos el inicializador que ponemos que por defecto reciba Repository() (producción) pero se va a poder cambiar en la vista donde se invoca (ContentView.swift) por el de RepositoryTest (desarrollo) de manera muy sencilla y escalable.
    init(repository: DataRepository = Repository()) { // definimos 'repository' si por defecto debe estar en producción (Repository) o test (RepositoryTest)
        
        self.repository = repository // asignamos el valor de 'repository' que hemos pasado por parámetro
        
        //Aqui es donde se hay el do - try - cacth elevado del getData() en el fichero 'Repository.swift' que solo hicimos el try (la forma dos)
        do { // entramos siempre
            cards = try repository.getData() // operación getData()
        } catch { // si da error
            cards = []
        }
    }
}
