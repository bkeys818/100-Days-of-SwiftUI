//
//  ContentView.swift
//  HabitTracker
//
//  Created by Benjamin Keys on 6/9/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import SwiftUI


struct HabitItem: Identifiable, Codable {
    let title: String
    let description: String
    let timeUnit: String
    let thisOften: Int
    let id = UUID()
    
    enum timeUnit {
        case test
        case this
    }

    var progressTracker: String {
        if self.thisOften == 0 {
            return "Goal Reached!"
        } else if self.thisOften == 1 {
            return "Complete \(self.thisOften) more time this \(self.timeUnit)"
        } else {
            return "Complete \(self.thisOften) more times this \(self.timeUnit)"
        }
    }
    
    
//    init(title: String, description,) {
//        statements
//    }
    
    
}

class Habits: ObservableObject {
    @Published var items = [HabitItem]() {
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
            
            if let decoded = try? decoder.decode([HabitItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = [HabitItem(title: "Example: Brush Teeth", description: "Brush teeth In the morning and at night.", timeUnit: "Day", thisOften: 2)]
    }
}

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var showingAddItem = false

    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items, id: \.id) { item in
                    HStack {
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.progressTracker)
                            }
                        }
                        Spacer()
                        Text("\(item.thisOften)")
                            .font(.title)
                            .padding(.leading)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddItem = true
                }) {
                    Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddItem) {
                    AddItem(habits: self.habits)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
