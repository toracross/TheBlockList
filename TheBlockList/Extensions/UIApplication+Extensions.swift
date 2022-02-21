//
//  UIApplication+Extensions.swift
//  TheBlockList
//
//  Created by Wellison Pereira on 2/21/22.
//

import UIKit

/// An extension of UIApplication that fetches the top view controller from the window stack.
extension UIApplication {
    class func topViewController() -> UIViewController? {
        guard let window = UIApplication.shared.connectedScenes
                            .filter({ $0.activationState == .foregroundActive })
                            .compactMap({ $0 as? UIWindowScene })
                            .first?.windows
                            .filter({ $0.isKeyWindow }).first,
              let rootViewController = window.rootViewController else { return nil }
        
        var topController = rootViewController
        
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        
        return topController
    }
}


