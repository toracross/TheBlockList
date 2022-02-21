//
//  Error.swift
//  TheBlockList
//
//  Created by Wellison Pereira on 2/21/22.
//

import UIKit

typealias ErrorHandler = ((UIAlertAction) -> Void)?

/// A class that displays error messages on the top most view controller.
class Error {

    enum ErrorMessage {
        case custom(title: String, body: String)
        case networkError
        case emptyList

        var details: (title: String, body: String) {
            switch self {
            case .custom(let title, let body):
                return (title: title, body: body)
            case .networkError:
                return (title: "Network Error", body: "An error occured attempting to fetch the employee list, please try again later.")
            case .emptyList:
                return (title: "No Employees Found", body: "There were no employees found in the provided directory.")
            }
        }
    }

    class func presentError(error: ErrorMessage, handler: ErrorHandler = nil) {
        let alert = UIAlertController(title: error.details.title, message: error.details.body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))

        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }

}

