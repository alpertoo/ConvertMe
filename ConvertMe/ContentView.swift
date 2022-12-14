//
//  ContentView.swift
//  ConvertMe
//
//  Created by Alper Koçer on 29.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var firstUnitType: String = "Celcius"
    @State private var secondUnitType: String = "Fahrenheit"
    @State private var userValue: Double = 100
    @FocusState private var valueIsFocused : Bool
    
    let unitTypes = ["Celcius", "Fahrenheit", "Kelvin"]
    
    var convertedValue: String {
        let valueToCelcius : Double
        let celciusToSelected: Double
        
        switch firstUnitType{
        case "Fahrenheit" :
            valueToCelcius = (((userValue - 32)*5)/9)
        case "Kelvin" :
            valueToCelcius = (userValue - 273.15)
        case "Celcius" :
            valueToCelcius = userValue
        default: valueToCelcius = userValue
        }
        
        switch secondUnitType{
        case "Fahrenheit" :
            celciusToSelected = ((valueToCelcius * 1.8) + 32)
        case "Kelvin" :
            celciusToSelected = (valueToCelcius + 273.15)
        case "Celcius" :
            celciusToSelected = valueToCelcius
        default: celciusToSelected = userValue
        }
        
        let finalValueToString = celciusToSelected.formatted()
        return "\(finalValueToString)"
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                
                Section{
                    Picker("Convert", selection: $firstUnitType){
                        ForEach(unitTypes, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Convert From:")
                }
            
                Section{
                    Picker("To", selection: $secondUnitType){
                        ForEach(unitTypes, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }header: {
                    Text("Convert To:")
                }
                
                Section{
                    TextField("Value", value: $userValue, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($valueIsFocused)
                }header: {
                    Text("Enter the value you want to convert:")
                }
                
                Section{
                    Text(convertedValue)
                }header: {
                    Text("Converted value:")
                }
            }
            .navigationTitle("ConvertMe")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        valueIsFocused = false
                    }
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
