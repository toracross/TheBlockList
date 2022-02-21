//
//  EmployeeService.swift
//  TheBlockList
//
//  Created by Wellison Pereira on 2/21/22.
//

import Foundation

/// A network class that attempts to fetch a list of employees.
final class EmployeeService {
    
    // MARK: - Endpoint Enum
    
    enum Endpoint: String {
        case employees = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
        case malformed = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
        case empty = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
    }
    
    // MARK: - Singleton Instance
    
    static let shared = EmployeeService()
    
    // MARK: - Public Methods
    
    func fetchEmployees(endpoint: Endpoint, completed: @escaping ([Employee]) -> ()) {
        guard let url = URL(string: endpoint.rawValue) else {
            completed([])
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard error == nil, let data = data else {
                Error.presentError(error: .networkError)
                completed([])
                return
            }
            
            do {
                let employeeList = try JSONDecoder().decode(EmployeeList.self, from: data)
                completed(employeeList.employees)
            } catch {
                completed([])
            }
        }.resume()
    }
}
