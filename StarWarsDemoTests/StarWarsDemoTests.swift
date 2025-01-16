//
//  StarWarsDemoTests.swift
//  StarWarsDemoTests
//
//  Created by Carlos Caño on 7/1/25.
//

import Testing
@testable import StarWarsDemo // es mi aplicación StarWarsDemo (import StarWarsDemo), pero añadimos el @testable, para que acceda a todos los componentes de nuestra aplicación y se pueda invocar dichos componentes

extension Tag {
    @Tag static var repository: Self
}

// No son Struct sino Suite los test
@Suite("Prueba del Repository de Star Cards", .tags(.repository)) // puede haber diferentes elementos como para deshabilitar que este en el ipad, etc. Además del elemento etiqueta que ponemos para decir que es un Suite del repositorio nuestro aplicación el test que estamos realizando
struct StarWarsDemoTests {
    
    let repository = RepositoryTest() // 1_cargamos el repositorio

    let viewModel = StarCardVM(repository: RepositoryTest()) //2_cargamos el view model
    
    @Test("Prueba de carga de datos del repositorio")
    func dataLoad() throws {
        let data = try repository.getData() // 1_Hacemos las comprobaciones
        #expect(data.count == 4)
    }
    
    @Test("Prueba de carga de datos del ViewModel")
    func dataLoadVM() throws {
        #expect(viewModel.cards.count == 4) // 2_Hacemos las comprobaciones
    }
}
