//
//  StoryboardExtensions.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/20/24.
//

import Foundation
import UIKit
import ReactorKit
import Reusable


protocol Storyboarded {
    static func instantiate(_ storyboardName: String?) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboardName: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyboardName ?? String(describing: self), bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as! Self
    }
}

extension UIViewController: Storyboarded {}


extension View where Self: Storyboarded & UIViewController {
    static func instantiate<Reactor> (withReactor reactor: Reactor) -> Self {
        let vc = Self.instantiate()
        vc.reactor = reactor as? Self.Reactor
        return vc
    }
}
