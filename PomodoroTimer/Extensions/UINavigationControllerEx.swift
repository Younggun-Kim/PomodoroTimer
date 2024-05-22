//
//  UINavigationControllerEx.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/21/24.
//

import Foundation
import UIKit


extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool) {
        if let vc = viewControllers.filter({ $0.isKind(of: ofClass) }).first {
            print("find find - ",vc)
            popToViewController(vc, animated: animated)
        }
    }
}
