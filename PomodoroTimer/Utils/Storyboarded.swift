//
//  StoryboardExtensions.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/20/24.
//

import Foundation
import UIKit


protocol Storyboard {
    static func instantiate(_ storyboardName: String?) -> Self
}

extension Storyboard where Self: UIViewController {
    static func
}
