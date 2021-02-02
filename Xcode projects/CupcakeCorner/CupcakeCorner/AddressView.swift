//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Marko Kramar on 29/09/2020.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var cupcakeOrder: CupcakeOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $cupcakeOrder.order.name)
                TextField("Street Address", text: $cupcakeOrder.order.streetAddress)
                TextField("City", text: $cupcakeOrder.order.city)
                TextField("Zip", text: $cupcakeOrder.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(cupcakeOrder: CupcakeOrder())) {
                    Text("Check out")
                }
            }.disabled(cupcakeOrder.order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(cupcakeOrder: CupcakeOrder())
    }
}

