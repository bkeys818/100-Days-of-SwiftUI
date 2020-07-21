//
//  ContentView.swift
//  iExpense
//
//  Created by Benjamin Keys on 5/12/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import SwiftUI

struct ExpenseItem : Identifiable, Codable {
    let id = UUID()
    let name : String
    let type : String
    let amount : Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            } else {
                fatalError()
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = [ExpenseItem(name: "Error", type: "No data decoded", amount: 0)]
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("\(item.amount)")
                            .amountStyle(for: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct AmountStyle : ViewModifier {
    var amount : Int
    func body (content: Content) -> some View {
        if amount >= 100 {
            return content.foregroundColor(.red)
        } else if amount < 10 {
            return content.foregroundColor(.green)
        } else {
            return content.foregroundColor(.orange)
        }
    }
}
extension View {
    func amountStyle(for amount : Int) -> some View {
        self.modifier(AmountStyle(amount: amount))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
