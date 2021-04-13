//
//  ContentView.swift
//  we split
//
//  Created by Sebouh Mazloumian on 06.04.21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2

    let tips = [5, 10, 15, 20, 0]

    var total: (perPerson: Float, grandTotal: Float) {
        let peopleCount = Float(numberOfPeople) ?? 0
        let tipSelection = Float(tips[tipPercentage])
        let orderAmount = Float(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        // to not have NaN when dividing on 0
        var perPerson : Float
        if peopleCount <= 0 {
            perPerson = grandTotal / (peopleCount + 1)
        } else {
            perPerson = grandTotal / peopleCount
        }
        
        return (perPerson, grandTotal)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("check amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("how much tip do you want to leave ?")) {
                    Picker("tip percentage", selection: $tipPercentage
                    ) {
                        ForEach(0 ..< tips.count) {
                            Text("\(self.tips[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("per person")) {
                    Text("$\(total.perPerson, specifier: "%.2f")")
                }

                Section(header: Text("total with tips")) {
                    Text("$\(total.grandTotal, specifier: "%.2f")")
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
