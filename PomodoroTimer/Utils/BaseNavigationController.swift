//
//  BaseNavigationController.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/21/24.
//

import Foundation
import UIKit


class BaseNavigationController: UINavigationController {
    /// 네비게이션 타이틀
    var navigationTitle = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setConfig()
    }
    
    private func setConfig() {
        self.navigationItem.title = navigationTitle
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundImage = nil
        
        let compactAppearance = standardAppearance.copy()
        compactAppearance.backgroundImage = nil
        
        self.navigationBar.do {
            $0.barStyle = .default
            $0.backgroundColor = .white
            $0.isTranslucent = false
            $0.standardAppearance = standardAppearance
            $0.scrollEdgeAppearance = standardAppearance
            $0.compactAppearance = compactAppearance
            $0.compactScrollEdgeAppearance = compactAppearance
        }
    }
}
