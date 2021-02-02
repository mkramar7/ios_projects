//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Marko Kramar on 29/09/2020.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var cupcakeOrder: CupcakeOrder
    
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var reachability: Reachability!
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(decorative: "cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is \(self.cupcakeOrder.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        do {
            try self.reachability = Reachability()
            if (reachability.connection == .unavailable) {
                self.confirmationTitle = "Error - no internet"
                self.confirmationMessage = "Unfortunately, a working Internet connection is needed to place order. Please try again later."
                self.showingConfirmation = true
                return
            }
        } catch {
            print("Could not check for internet connection")
            return
        }
        
        
        guard let encoded = try? JSONEncoder().encode(cupcakeOrder.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        print("Encoded order: \(String(data: encoded, encoding: .utf8)!)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            print("Data retrieved: \(String(data: data, encoding: .utf8)!)")
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
                self.confirmationTitle = "Thank You"
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(cupcakeOrder: CupcakeOrder())
    }
}
