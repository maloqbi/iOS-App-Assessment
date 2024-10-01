//
//  CalculatorViewModel.swift
//  iOS-Assessment-Elm
//
//  Created by Mohammed on 18/03/1446 AH.
//

import Foundation
import Foundation
import Combine

class CalculatorViewModel: ObservableObject {
    @Published var firstNumber: String = ""
    @Published var secondNumber: String = ""
    @Published var result: String? = nil
    @Published var errorMessage: String? = nil

    func performDivision() {
        
        result = nil
        errorMessage = nil

        
        guard let x = Double(firstNumber), let y = Double(secondNumber) else {
            errorMessage = "Invalid input. Please enter valid numbers."
            return
        }

        
        if y == 0 {
            errorMessage = "Error: Division by zero is not allowed."
        } else {
            let z = x / y
            result = "\(z)"
        }
    }
}
