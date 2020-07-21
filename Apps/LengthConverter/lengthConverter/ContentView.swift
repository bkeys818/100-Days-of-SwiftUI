//
//  ContentView.swift
//  lengthConverter
//
//  Created by Benjamin Keys on 4/12/20.
//  Copyright © 2020 Ben Keys. All rights reserved.
//

import SwiftUI

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 10 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

struct ContentView: View {
    // Establish units
    let unitSystems = ["Metric", "Imperial"]
    let metricUnits = ["Kilometers", "Meters", "Centimeters", "Millimeters"]
    let imperialUnits = ["Miles", "Yards", "Feet", "Inches"]
    
    let conversions : [String : Double] = [
        "Kilometers" : 1_000_000.0,
        "Meters" : 1_000.0,
        "Centimeters" : 10.0,
        "Millimeters" : 1.0,
        "Miles" : 24_710.4,
        "Yards" : 14.04,
        "Feet" : 4.68,
        "Inches" : 0.39
    ]
    
    // Convert from metric or imperial
    @State private var systemChoice = 0
    var inputUnitList : [String] { if systemChoice == 0 { return metricUnits } else { return imperialUnits }}
    var outputUnitList : [String] { if systemChoice == 0 { return imperialUnits } else { return metricUnits }}

    // Selected convertion unit
    @State private var inputUnitChoice = 0
    @State private var outputUnitChoice = 0
    
    // User input value (number to be converted)
    @State private var inputMeasurement = ""
    
    // Calculations
    
    var outputMeasurement : String {
        let typedValue : Double = Double(inputMeasurement) ?? 0

        let currentInputUnit : String = inputUnitList[inputUnitChoice]
        let inputConversion : Double = conversions[currentInputUnit] ?? 1_000_000.0

        let currentOutputUnit : String = outputUnitList[outputUnitChoice]
        let outputConversion : Double = conversions[currentOutputUnit] ?? 24_710.4

        let outputValue = (typedValue / inputConversion * outputConversion)
        if outputValue == 0 {return ""}
        return outputValue.removeZerosFromEnd()
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                // Pick unit system
                Section(header: Text("Select the Unit System you would to convert from")) {
                    Picker("InputUnit", selection: $systemChoice) {
                        ForEach(0..<unitSystems.count) {
                            Text("\(self.unitSystems[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                // Pick input unit and type value
                Section(header: Text("Choose input unit and amount")) {
                    Picker("InputUnit", selection: $inputUnitChoice) {
                        ForEach(0..<inputUnitList.count) {
                            Text("\(self.inputUnitList[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Unit Input", text: $inputMeasurement)
                }
                // pick output unit and view result
                Section(header: Text("Choose output unit")) {
                    Picker("OutputUnit", selection: $outputUnitChoice) {
                        ForEach(0..<outputUnitList.count) {
                            Text("\(self.outputUnitList[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Text(outputMeasurement)
                }
            }
            .navigationBarTitle(Text("Length Converter"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
