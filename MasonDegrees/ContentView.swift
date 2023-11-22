//
//  ContentView.swift
//  MasonDegrees
//
//  Created by Hai Son Cao on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    enum TemperatureUnit: String, CaseIterable {
        case Celcius
        case Fahrenheit
        case Kelvin
        var type: String {self.rawValue}
    }
    
    @FocusState var isInputFocused: Bool
    @State private var inputUnit = TemperatureUnit.Celcius
    @State private var inputDegrees = 0.0
    @State private var outputUnit = TemperatureUnit.Fahrenheit

//    Convert all input units to celcius
    var toCelcius : Double {
        switch inputUnit {
        case .Celcius:
            return inputDegrees
        case .Fahrenheit:
            return (inputDegrees - 32) * (5/9)
        case .Kelvin:
            return inputDegrees - 273.15
        }
    }
    
    private var outputCelcius: Double {
        toCelcius
    }
    private var outputFahrenheit: Double {
        toCelcius * (9/5) + 32
    }
    private var outputKelvin: Double {
        toCelcius + 273.15
    }
    
    func displayOutputTemp(for outputUnit: TemperatureUnit) -> Text {
        switch outputUnit {
        case .Celcius:
            return Text("\(outputCelcius.formatted())°C")
        case .Fahrenheit:
            return Text("\(outputFahrenheit.formatted())°F")
        case .Kelvin:
            return Text("\(outputKelvin.formatted())°K")

        }
        
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
//                Input temperature conversion
                Section("Input") {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(TemperatureUnit.allCases, id: \.rawValue) {
                            Text($0.type)
                                .tag($0)
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
                        ForEach(TemperatureUnit.allCases, id: \.rawValue) {
                            Text($0.type)
                                .tag($0)
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
