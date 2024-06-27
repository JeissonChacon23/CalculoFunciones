//
//  ContentView.swift
//  CalculoFunciones
//
//  Created by Jeisson Chacón on 27/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var equation: String = ""
    @State private var result: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Derivada de una función")
                .font(.largeTitle)
                .padding()
            
            TextField("Ingresa la ecuación", text: $equation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                self.result = deriveEquation(equation: self.equation)
            }) {
                Text("Derivar")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Text("Resultado: \(result)")
                .padding()
            
            Spacer()
        }
        .padding()
    }
    
    func deriveEquation(equation: String) -> String {
        // Implementa la lógica para derivar la ecuación
        // Aquí estamos asumiendo que la ecuación es un polinomio simple de la forma ax^n
        // Ejemplo: 3x^2 -> 6x
        let terms = equation.split(separator: "+")
        var derivedTerms: [String] = []
        
        for term in terms {
            if term.contains("x") {
                let components = term.split(separator: "x")
                if components.count == 2 {
                    if let coefficient = Double(components[0]), let exponent = Double(components[1].replacingOccurrences(of: "^", with: "")) {
                        let newCoefficient = coefficient * exponent
                        let newExponent = exponent - 1
                        derivedTerms.append("\(newCoefficient)x^\(newExponent)")
                    }
                } else if components.count == 1 {
                    derivedTerms.append("1")
                }
            }
        }
        
        return derivedTerms.joined(separator: " + ")
    }
}



#Preview {
    ContentView()
}

