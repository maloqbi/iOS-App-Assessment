//
//  CalculatorView.swift
//  iOS-Assessment-Elm
//
//  Created by Mohammed on 18/03/1446 AH.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter first number", text: $viewModel.firstNumber)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
            
            TextField("Enter second number", text: $viewModel.secondNumber)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
            
            Button(action: {
                viewModel.performDivision()
            }) {
                Text("Calculate")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.top, 20)
            
            if let result = viewModel.result {
                Text("Result: \(result)")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding()
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.title)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Calculator")
    }
}
