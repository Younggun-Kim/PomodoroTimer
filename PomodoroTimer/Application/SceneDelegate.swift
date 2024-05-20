//
//  SceneDelegate.swift
//  PomodoroTimer
//
//  Created by 김영건 on 5/16/24.
//

import UIKit
import RxSwift
import RxFlow


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let disposeBag = DisposeBag()
    var coordinator = FlowCoordinator()
    var appService = AppServices()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Scene 캡처
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 2. window scene을 가져오는 windowScene을 생성자를 사용해서 UIWindow를 생성
        let window = UIWindow(windowScene: windowScene)
        
        // 3. viewe 계층을 프로그래밍 방식으로 만들기
        let splashVC = SplashViewController.instantiate("SplashViewController")
        let appNav = UINavigationController(rootViewController: splashVC)
        let rootVC = appNav
        
        // 4. ViewController로 window의 root view controller를 설정
        window.rootViewController = rootVC
        
        // 5. window 설정.
        self.window = window
        self.window?.makeKeyAndVisible()
        
//        let appFlow = AppFlow(services: appService)
//        Flows.use(appFlow, when: .created) { root in
//            print(root)
//            self.window?.rootViewController = root
//            self.window?.makeKeyAndVisible()
//        }
//        
//        self.coordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
//            print("will navigate to flow=\(flow) and step=\(step)")
//        }).disposed(by: self.disposeBag)
//        
//        self.coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
//            print("did navigate to flow=\(flow) and step=\(step)")
//        }).disposed(by: self.disposeBag)
//        
//        self.coordinator.coordinate(flow: appFlow, with: AppStepper())
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

