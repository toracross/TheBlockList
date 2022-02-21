//
//  EmployeeListViewModel.swift
//  TheBlockList
//
//  Created by Wellison Pereira on 2/21/22.
//

import Foundation

public typealias ViewStateUpdated = (_ state: EmployeeListViewModel.State) -> ()

public protocol EmployeeListViewDelegate: AnyObject {
    func viewStateUpdated(state: EmployeeListViewModel.State)
}

/// The view model class represented in the EmployeeListViewController.
public final class EmployeeListViewModel {
    
    public enum State {
        case ready, loading, empty
    }
    
    // MARK: - Public Variables
    
    public private(set) var employees: [Employee] = []
    public private(set) var state: State = .empty
    
    // MARK: - Private Variables
    
    private weak var delegate: EmployeeListViewDelegate?
    
    // MARK: - Lifecycle Events
    
    public init(delegate: EmployeeListViewDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Public Methods
    
    /// Attempts to fetch employees from the network.
    public func fetchEmployees() {
        guard state != .loading else { return }
        
        employees.removeAll()
        state = .loading
        self.delegate?.viewStateUpdated(state: .loading)
        
        EmployeeService.shared.fetchEmployees(endpoint: .employees) { [weak self] employees in
            guard let self = self, !employees.isEmpty else {
                self?.delegate?.viewStateUpdated(state: .empty)
                Error.presentError(error: .emptyList)
                return
            }
        
            self.employees = employees
            self.state = .ready
            self.delegate?.viewStateUpdated(state: .ready)
        }
    }
}
