//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Marko Kramar on 28/09/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cupcakeOrder = CupcakeOrder()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $cupcakeOrder.order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $cupcakeOrder.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(cupcakeOrder.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn:  $cupcakeOrder.order.specialRequestEnabled.animation()) {
                        Text("Any special requests")
                    }
                    
                    if cupcakeOrder.order.specialRequestEnabled {
                        Toggle(isOn: $cupcakeOrder.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $cupcakeOrder.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(cupcakeOrder: CupcakeOrder())) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
