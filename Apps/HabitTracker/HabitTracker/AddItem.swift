//
//  AddItem.swift
//  HabitTracker
//
//  Created by Benjamin Keys on 6/10/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import SwiftUI


struct timeIntegers {
    
}


struct AddItem: View {
    @Environment(\.presentationMode) var presentationMode
    @State var alertShowing = false
    
    @ObservedObject var habits: Habits
    
    @State var HabitTitle = ""
    @State var HabitDescription = ""
    var timeIncrementList = ["Day", "Week", "Month", "Year"]
    @State private var incrementSelected = 0
    var thisOftenList = 1..<10
    @State private var thisOften = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What is your new habit?")){
                    TextField("Habit Title", text: $HabitTitle)
                    TextField("Habit Description", text: $HabitDescription)
                }
                
                Section(header: Text("How often would you like to complete this activity?")){
                    HStack {
                        Text("How many times?")
                        Picker(selection: $incrementSelected, label: Text("")) {
                            ForEach(1..<10) {
                                Text("\(self.timeIncrementList[$0])")
                            }
                        }
                    }
                    HStack {
                        Text("How often?")
                        Picker(selection: $thisOften, label: Text("")) {
                            ForEach(1 ..< (thisOftenList.count-1)) {
                                Text("\(self.thisOftenList[$0])")
                            }
                        }
                    }
                }
            }
                
            .navigationBarTitle("New Habit")
                
            .navigationBarItems(leading:
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }, trailing:
                Button("Save") {
                    if self.HabitTitle == "" {
                        self.alertShowing = true
                    } else {
                        let item = HabitItem(title: self.HabitTitle, description: self.HabitDescription, timeUnit: self.timeIncrementList[self.incrementSelected], thisOften: self.thisOftenList[self.thisOften])
                        self.habits.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            )
                .alert(isPresented: $alertShowing) {
                    Alert(title: Text("Oops!"), message: Text("Please enter a habit title."), dismissButton: .default(Text("OK")) {
                        })
            }
            
        }
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem(habits: Habits())
    }
}
