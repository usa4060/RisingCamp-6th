//
//  MyInfoViewController.swift
//  week5
//
//  Created by admin on 2022/06/20.
//

import UIKit

class MyInfoViewController: UIViewController {

    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var N = "12"
    var E = "12"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setData(_ nickName : String, _ email : String){
        N = nickName
        E = email
    }

}
