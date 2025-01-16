//
//  ContentView.swift
//  StarWarsDemo
//
//  Created by Carlos Caño on 7/1/25.
//

import SwiftUI

// 1_Esta estructura tiene el protocolo: View
// Es un acuerdo que tiene el Struct con el Protocolo (View) que para cumplirlo tiene que tener ciertos componentes de manera obligatoria, en este caso el 'var body: some View { }'
struct ContentView: View {
    
    @State var vm = StarCardVM() // 3_ @State: indica al sistema que cuando cambie ciertas propiedades provocara que la vista se actualice. En este caso el observable StarCardVM() el cual tiene la variable cards en el momento que esta cambie automaticamente refrescará la pantalla y lo cambiará
    
    // @State var vm = StarCardVM(repository: Repository()) // seria lo mismo que lo puesto arriba, ya que Repository es por defecto el parámetro Repository()
    
    // @State var vm = StarCardVM(repository: RepositoryTest()) // seria si quiero en producción solo mostrar los datos de desarrollo (algo sin sentido porque si acaso esto tendria que ponerse en la Preview() y no en el simulador)
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(vm.cards) { card in
                    StarCardView(card: card) // vista secundaria definida (StarCardView.swift)
                }
            }
            .navigationTitle("Star Wars")
        }
    }
}

// 2_#Preview, esto lo que hace es dar un contexto en el que creo la instancia de 'ContentView' para que se vea en el simulador de la derecha de Xcode.
#Preview {

    ContentView(vm: StarCardVM(repository: RepositoryTest())) // Test, muestra el json de test, con sus datos
    
    // ContentView() // Producción, por defecto se recibe Repository() en el StarCardVM.swift, donde se invoca StarCardVM() en la linea 14
    
    // ContentView(vm: StarCardVM(repository: Repository())) // Producción, igual que ContentView()
}
