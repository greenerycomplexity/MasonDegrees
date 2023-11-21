//
//  ContentView.swift
//  MasonDegrees
//
//  Created by Hai Son Cao on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    let unitOptions = ["Celcius", "Fahrenheit", "Kelvin"]
    
    @FocusState var isInputFocused: Bool
    @State private var inputUnit = "Celcius"
    @State private var inputDegrees = 0.0
    @State private var outputUnit = "Fahrenheit"
    
    private var outputCelcius: Double {
        toCelcius
    }
    private var outputFahrenheit: Double {
        toCelcius * (9/5) + 32
    }
    private var outputKelvin: Double {
        toCelcius + 273.15
    }

//    Convert all input units to celcius
    var toCelcius : Double {
        if inputUnit == "Fahrenheit" {
            return (inputDegrees - 32) * (5/9)
        } else if inputUnit == "Kelvin" {
            return inputDegrees - 273.15
        }
        return inputDegrees
    }
    
    func displayOutputTemp(for outputUnit: String) -> Text {
        if outputUnit == "Celcius" {
            Text("\(outputCelcius.formatted())°C")
        } else if outputUnit == "Fahrenheit" {
            Text("\(outputFahrenheit.formatted())°F")
        } else {
            Text("\(outputKelvin.formatted())°K")
        }
    }
    

    var body: some View {
        NavigationStack {
            Form {
//                Input temperature conversion
                Section("Input") {
                    Picker("Input degree", selection: $inputUnit) {
                        ForEach(unitOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField ("0.0", value: $inputDegrees, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isInputFocused)
                }
                
                
//                Output temperature conversion
                Section("Output") {
                    Picker("0.0", selection: $outputUnit) {
                        ForEach(unitOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    
                   displayOutputTemp(for: outputUnit)
                }
                
            }
            .navigationTitle("Mason Degrees 🌡️")
            .toolbar {
                if isInputFocused {
                    Button ("Done") {
                        isInputFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
