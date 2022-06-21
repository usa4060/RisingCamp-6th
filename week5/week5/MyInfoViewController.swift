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
    
    var tempNick : String = ""
    var tempEmail : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(tempNick) , \(tempEmail)")
        
        self.nicknameLabel.text = tempNick
        self.emailLabel.text = tempEmail
    }
    

}
