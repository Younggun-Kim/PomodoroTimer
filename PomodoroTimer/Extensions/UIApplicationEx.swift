//
//  UIApplicationEx.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/21/24.
//

import Foundation
import UIKit


extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.connectedScenes
                                    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                                    .first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    static var keyWindow:  UIWindow? {
        let scenes = UIApplication.shared.connectedScenes
//        getting windowScene from scenes
        let windowScene = scenes.first as? UIWindowScene
//        getting window from windowScene
        let window = windowScene?.windows.first

        return window
    }
}
