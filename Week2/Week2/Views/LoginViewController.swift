//
//  LoginViewController.swift
//  Week2
//
//  Created by admin on 2022/05/27.
//

import UIKit


protocol SendDataDelegate:AnyObject{
    func SendName(name:String?)
}


class LoginViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var password: UITextField!
    
    weak var dataDelegate : SendDataDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeLayout()
    }
    @IBAction func backHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        print(2)
        dataDelegate?.SendName(name: id.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
    }
    
    func makeLayout(){
        loginView.layer.borderWidth = 1;
        loginView.layer.borderColor = UIColor.white.cgColor;
        loginView.layer.shadowColor = UIColor.black.cgColor;
        loginView.layer.shadowOffset = CGSize(width: -3, height: 3)
        loginView.layer.shadowRadius = 5;
        loginView.layer.masksToBounds = false;
        loginView.layer.shadowOpacity = 0.1;
        
    }
    
}
