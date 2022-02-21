//
//  TheBlockListTests.swift
//  TheBlockListTests
//
//  Created by Wellison Pereira on 2/21/22.
//

import XCTest
@testable import TheBlockList

class EmployeeListViewModelTests: XCTestCase {

    func testServiceEndpointForEmployees() throws {
        let mockDelegate = EmployeeListMockDelegate()
        let viewModel = EmployeeListViewModel(delegate: mockDelegate)
        viewModel.fetchEmployees()
        
        XCTAssert(mockDelegate.activeState != .empty)
    }

}

class EmployeeListMockDelegate: EmployeeListViewDelegate {
    
    var activeState: EmployeeListViewModel.State = .empty
    
    func viewStateUpdated(state: EmployeeListViewModel.State) {
        activeState = state
    }
}
