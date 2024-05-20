//
//  StoryboardExtensions.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/20/24.
//

import Foundation
import UIKit


protocol Storyboarded {
    static func instantiate(_ storyboardName: String?) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboardName: String?) -> Self {
        let storyboard = UIStoryboard(name: storyboardName ?? String(describing: self), bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as! Self
    }
}

extension UIViewController: Storyboarded {}
