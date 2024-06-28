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
        // Dividir la ecuación en términos separados por '+'
        let terms = equation.replacingOccurrences(of: " ", with: "").split(separator: "+")
        var derivedTerms: [String] = []
        
        for term in terms {
            if let derivedTerm = deriveTerm(term: String(term)) {
                derivedTerms.append(derivedTerm)
            }
        }
        
        return derivedTerms.joined(separator: " + ")
    }
    
    func deriveTerm(term: String) -> String? {
        // Verificar si el término contiene 'x'
        if term.contains("x") {
            let parts = term.split(separator: "x", maxSplits: 1, omittingEmptySubsequences: false)
            var coefficient: Double = 1.0
            var exponent: Double = 1.0
            
            if parts.count > 0 && !parts[0].isEmpty {
                coefficient = Double(parts[0]) ?? 1.0
            }
            
            if parts.count > 1 && !parts[1].isEmpty {
                if parts[1].hasPrefix("^") {
                    exponent = Double(parts[1].dropFirst()) ?? 1.0
                }
            } else if parts.count == 1 {
                exponent = 1.0
            }
            
            // Calcular la nueva derivada
            let newCoefficient = coefficient * exponent
            let newExponent = exponent - 1
            
            if newExponent == 0 {
                return "\(newCoefficient)"
            } else if newExponent == 1 {
                return "\(newCoefficient)x"
            } else {
                return "\(newCoefficient)x^\(newExponent)"
            }
        } else {
            // El término es una constante, su derivada es 0
            return nil
        }
    }
}



#Preview {
    ContentView()
}

