//
//  SceneDelegate.swift
//  Week2
//
//  Created by admin on 2022/05/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let tbc = self.window?.rootViewController as? UITabBarController {
            
            tbc.tabBar.tintColor = .systemGreen
            tbc.tabBar.unselectedItemTintColor = .lightGray
            
        }   // Scene을 처음 그려줄 , tabbar의 요소를 설정해야 하기 때문에 SceneDelegate에 정의해줌
        
        
        // Scene함수는 UI창을 선택적으로 구성하고 제공된 UI창에 scene을 연결해준다. (iOS 13~)만약 스토리보드를 사용하는 경우에는 자동으로 window 프로퍼티가 초기화되고 화면에 첨부되게 된다.SceneDelegate는 연결된 scene 또는 session이 새로 생성된 것이라는 것을 의미하지는 않는다.
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // 시스템에 의해서 scene이 해제되면 호출이된다. Scene이 background에 들어간 직후나 session이 삭제되었을 때 호출된다. 다음 번에 해당 scene에 연결되는 경우에 새로 생성되는 자료들과 관련된 모든 자료들을 해제해준다.Session이 반드시 삭제되는 것은 아니므로 scene은 나중에 다시 연결될 수도 있다.
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Scene이 활성화 되었고 현재 사용자 이벤트에 응답하고 있음을 알린다.인터페이스를 로드 한 후 인터페이스가 화면에 표시되기 전에 호출된다
        hidePrivacyProtectionWindow()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
        // Scene이 활성상태를 해제하고 사용자 이벤트에 대한 응답을 중지하려고 함을 알린다.시스템 경고를 표시 할 때와 같은 일시적인 중단을 위해 이 메서드를 호출한다. 이 메서드가 반환 될 때까지 앱은 백그라운드 또는 포그라운드로 다시 전환되기를 기다리는 동안 최소한의 작업을 수행해야 한다.
        showPrivacyProtectionWindow()
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // scene이 foreground에서 실행되고, 사용자에게 표시 될 것임을 delegate에게 알립니다.이 전환은 새로 생성되고 연결된 scene뿐만아니라 background에서 실행 중이고, 시스템 또는 사용자 작업에 의해 background로 가져온 scene 모두에 대해 발생합니다.scene이 화면에 표시되기 위해 foreground에 들어가므로 이 메서드는 항상 sceneDidBecomeActive (_ :) 메서드를 호출합니다.
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Scene이 background에서 실행되고 더 이상 화면에 표시되지 않음을 Delegate에게 알립니다.이 방법을 사용하여, scene의 메모리 사용량을 줄이고, 공유 리소스를 확보하며, scene의 사용자 인터페이스를 정리합니다.이 메서드가 반환 된 직후 UIKit은 앱 전환기에 표시하기 위해 Scene의 인터페이스의 스냅 샷을 찍습니다.
        
    }
    
    
    
    private var privacyProtectionWindow: UIWindow?
    
    private func showPrivacyProtectionWindow() {
        guard let windowScene = self.window?.windowScene else {
            return
        }
        
        privacyProtectionWindow = UIWindow(windowScene: windowScene)
        privacyProtectionWindow?.rootViewController = HideBackgroundViewController()
        privacyProtectionWindow?.windowLevel = .alert + 1
        privacyProtectionWindow?.makeKeyAndVisible()
    }
    
    private func hidePrivacyProtectionWindow() {
        privacyProtectionWindow?.isHidden = true
        privacyProtectionWindow = nil
    }
    
}



