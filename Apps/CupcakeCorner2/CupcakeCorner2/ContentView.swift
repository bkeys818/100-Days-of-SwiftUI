//
//  ContentView.swift
//  CupcakeCorner2
//
//  Created by Benjamin Keys on 7/21/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    var body: some View {
        NavigationView { 
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any specail request?")
                    }
                    if order.specialRequestEnabled == true {
                        Toggle(isOn: $order.extraFrosting.animation()) {
                            Text("Add extra frosting?")
                        }
                        Toggle(isOn: $order.addSprinkles.animation()) {
                            Text("Add extra sprinkles?")
                        }
                    }
                    
                }
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
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
