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
    static func instantiateFromNib(_ nibName: String?) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboardName: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyboardName ?? String(describing: self), bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as! Self
    }
    
    static func instantiateFromNib(_ nibName: String? = nil) -> Self {
        let nibName = nibName ?? String(describing: self)
        let nib = UINib(nibName: nibName, bundle: nil)
        guard let viewController = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("Cannot instantiate view controller from \(nibName).xib")
        }
        return viewController
    }   
}

extension UIViewController: Storyboarded {}


extension ReactorBased where Self: Storyboarded & UIViewController {
    static func instantiate<Reactor> (withReactor reactor: Reactor, isNib: Bool = false) -> Self {
        let vc = if isNib {
            Self.instantiateFromNib()
        } else {
            Self.instantiate()
        }
        
        vc.reactor = reactor as? Self.Reactor
        return vc
    }
}
