//
//  Employee.swift
//  TheBlockList
//
//  Created by Wellison Pereira on 2/21/22.
//

import Foundation
import UIKit

struct EmployeeList: Codable {
    let employees: [Employee]
}

/// A data type representing an Employee list item.
public struct Employee: Codable {
    
    let uuid: String
    let fullName: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    let team: String
    let employeeType: EmployeeType
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        uuid = try container.decode(String.self, forKey: .uuid)
        fullName = try container.decode(String.self, forKey: .fullName)
        phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        emailAddress = try container.decode(String.self, forKey: .emailAddress)
        biography = try container.decodeIfPresent(String.self, forKey: .biography)
        photoUrlSmall = try container.decodeIfPresent(String.self, forKey: .photoUrlSmall)
        photoUrlLarge = try container.decodeIfPresent(String.self, forKey: .photoUrlLarge)
        team = try container.decode(String.self, forKey: .team)
        employeeType = try container.decode(EmployeeType.self, forKey: .employeeType)
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid, biography, team
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case employeeType = "employee_type"
    }
    
}

extension Employee {
    enum EmployeeType: String, Codable {
        case fullTime = "FULL_TIME"
        case partTime = "PART_TIME"
        case contractor = "CONTRACTOR"
    }
}
