//
//  TheBlockListTests.swift
//  TheBlockListTests
//
//  Created by Wellison Pereira on 2/21/22.
//

import XCTest
@testable import TheBlockList

class EmployeeServiceTests: XCTestCase {

    func testServiceEndpointForEmployees() throws {
        let foundEmployeesExpectation = expectation(description: "The endpoint was succesfully queried, and employees were retrieved from the endpoint.")
        
        EmployeeService.shared.fetchEmployees(endpoint: .employees) { employees in
            if !employees.isEmpty {
                foundEmployeesExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testServiceEndpointForMalformed() throws {
        let foundEmployeesExpectation = expectation(description: "The endpoint was succesfully queried, but the data was malformed and not stored.")
        
        EmployeeService.shared.fetchEmployees(endpoint: .malformed) { employees in
            if employees.isEmpty {
                foundEmployeesExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testServiceEndpointForEmpty() throws {
        let foundEmployeesExpectation = expectation(description: "The endpoint was successfully queried, but the employee list was empty.")
        
        EmployeeService.shared.fetchEmployees(endpoint: .empty) { employees in
            if employees.isEmpty {
                foundEmployeesExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
