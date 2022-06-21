import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

import UIKit

class InitPageViewController: UIViewController {
    
    @IBOutlet weak var kakaoLoginBtn: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func kakaoLoginBtnTapped(_ sender: UIButton) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            loginWithApp()
        }
        else{
            // 만약, 카카오톡이 깔려있지 않을 경우에는 웹 브라우저로 카카오 로그인함.
            // loginWithWeb()
        }
    }
    
    // 카카오톡 앱으로 로그인
    func loginWithApp() {
        UserApi.shared.loginWithKakaoTalk {(_, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success.")
                
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        guard let nickname = user?.kakaoAccount?.profile?.nickname, let email = user?.kakaoAccount?.email else {return;}
                        
                        let storyboard = UIStoryboard(name: "MyInfo", bundle: nil)
                        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "MyInfoViewController") as? MyInfoViewController else { return }

                        nextVC.tempNick = nickname
                        nextVC.tempEmail = email
                        
                        self.presentToMain()

                    }
                }
            }
        }
    }
    
//
//    // 카카오톡 웹으로 로그인
//    func loginWithWeb() {
//        UserApi.shared.loginWithKakaoAccount {(_, error) in
//            if let error = error {
//                print(error)
//            } else {
//                print("loginWithKakaoAccount() success.")
//
//                UserApi.shared.me {(user, error) in
//                    if let error = error {
//                        print(error)
//                    } else {
//                        guard let nickname = user?.kakaoAccount?.profile?.nickname, let email = user?.kakaoAccount?.email else {return;}
//
//                        let storyboard = UIStoryboard(name: "MyInfo", bundle: nil)
//                        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "MyInfoViewController") as? MyInfoViewController else { return }
//
//
//                        self.presentToMain()
//
//
//                    }
//                }
//            }
//        }
//    }
//
    // 화면 전환 함수
    func presentToMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
        tabbarVC.modalPresentationStyle = .overFullScreen
        self.present(tabbarVC, animated: false, completion: nil)
        
    }
}

