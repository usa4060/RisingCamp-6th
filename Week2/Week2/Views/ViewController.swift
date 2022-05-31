//
//  ViewController.swift
//  Week2
//
//  Created by admin on 2022/05/22.
//

import UIKit

class ViewController: UIViewController , SendDataDelegate{
    @IBOutlet weak var starbucksRewardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.isHidden = true
        self.makeLayout()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func creatingAccount(_ sender: UIButton) {
    }

    @IBAction func logInButton(_ sender: Any) {
        print(1)
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {return}
        vc.dataDelegate = self
    }
    
    func makeLayout(){
        starbucksRewardView.layer.borderWidth = 1;
        starbucksRewardView.layer.borderColor = UIColor.white.cgColor;
        starbucksRewardView.layer.shadowColor = UIColor.black.cgColor;
        starbucksRewardView.layer.shadowOffset = CGSize(width: -3, height: 3)
        starbucksRewardView.layer.shadowRadius = 5;
        starbucksRewardView.layer.masksToBounds = false;
        starbucksRewardView.layer.shadowOpacity = 0.1;
        
    }
    
    func SendName(name: String?) {
        print(13)
        nameLabel.isHidden = false
        nameLabel.text = "name"
    }
}

