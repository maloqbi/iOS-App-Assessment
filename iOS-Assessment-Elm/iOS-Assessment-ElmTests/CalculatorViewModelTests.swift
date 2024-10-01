//
//  CalculatorViewModelTests.swift
//  iOS-Assessment-Elm
//
//  Created by Mohammed on 18/03/1446 AH.
//

import Foundation
import XCTest
@testable import iOS_Assessment_Elm

class CalculatorViewModelTests: XCTestCase {
    
    var viewModel: CalculatorViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CalculatorViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    
    func testInitialState() {
        XCTAssertEqual(viewModel.firstNumber, "")
        XCTAssertEqual(viewModel.secondNumber, "")
        XCTAssertNil(viewModel.result)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    
    func testValidDivision() {
        viewModel.firstNumber = "10"
        viewModel.secondNumber = "2"
        
        viewModel.performDivision()
        
        XCTAssertEqual(viewModel.result, "5.0")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    
    func testDivisionByZero() {
        viewModel.firstNumber = "10"
        viewModel.secondNumber = "0"
        
        viewModel.performDivision()
        
        XCTAssertEqual(viewModel.errorMessage, "Error: Division by zero is not allowed.")
        XCTAssertNil(viewModel.result)
    }
    
    
    func testInvalidInput() {
        viewModel.firstNumber = "abc"
        viewModel.secondNumber = "2"
        
        viewModel.performDivision()
        
        XCTAssertEqual(viewModel.errorMessage, "Invalid input. Please enter valid numbers.")
        XCTAssertNil(viewModel.result)
    }
    
    
    func testInvalidInputBothNumbers() {
        viewModel.firstNumber = "abc"
        viewModel.secondNumber = "xyz"
        
        viewModel.performDivision()
        
        XCTAssertEqual(viewModel.errorMessage, "Invalid input. Please enter valid numbers.")
        XCTAssertNil(viewModel.result)
    }
    
    
    func testResetAfterInvalidInput() {
        viewModel.firstNumber = "abc"
        viewModel.secondNumber = "xyz"
        viewModel.performDivision()
        
        XCTAssertEqual(viewModel.errorMessage, "Invalid input. Please enter valid numbers.")
        
        
        viewModel.firstNumber = "10"
        viewModel.secondNumber = "2"
        viewModel.performDivision()
        
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.result, "5.0")
    }
}
