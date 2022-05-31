//
//  CreatingAccountViewController.swift
//  Week2
//
//  Created by admin on 2022/05/26.
//

import UIKit

class CreatingAccountViewController: UIViewController {
    
    
    var checkAgree = 0;
    var checkBtn1 = false;
    var checkBtn2 = false;
    var checkBtn3 = false;
    var checkBtn4 = false;
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonlayout()
        checkBtn1 = false;
        checkBtn2 = false;
        checkBtn3 = false;
        checkBtn4 = false;
    
    }

    @IBAction func allAgree(_ sender: Any) {
//        checkBtn1 = !checkBtn1
    }
    @IBAction func agree1(_ sender: Any) {
//        checkBtn2 = !checkBtn2
//        if(!checkBtn2){
//            checkAgree = checkAgree+1;
//            btn2.layer.backgroundColor = UIColor.green.cgColor
//        }else{
//            checkAgree = checkAgree - 1;
//            btn2.layer.backgroundColor = UIColor.white.cgColor
//        }
    }

    @IBAction func agree2(_ sender: Any) {
//        checkBtn3 = !checkBtn3
//        if(!checkBtn3){
//            checkAgree = checkAgree+1;
//            btn3.layer.backgroundColor = UIColor.green.cgColor
//        }else{
//            checkAgree = checkAgree - 1;
//            btn3.layer.backgroundColor = UIColor.white.cgColor
//        }
    }

    @IBAction func agree3(_ sender: Any) {
//        checkBtn4 = !checkBtn4
//        if(!checkBtn4){
//            checkAgree = checkAgree+1;
//            btn4.layer.backgroundColor = UIColor.green.cgColor
//        }else{
//            checkAgree = checkAgree - 1;
//            btn4.layer.backgroundColor = UIColor.white.cgColor
//        }
    }

    @IBAction func tt(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


    func buttonlayout(){
        btn1.layer.borderWidth = 1
        btn1.layer.borderColor = UIColor.lightGray.cgColor
        btn1.layer.cornerRadius = btn1.layer.frame.size.width/2
        
        btn2.layer.borderWidth = 1
        btn2.layer.cornerRadius = btn2.layer.frame.size.width/2
        btn2.layer.borderColor = UIColor.lightGray.cgColor
        
        btn3.layer.borderWidth = 1
        btn3.layer.cornerRadius = btn3.layer.frame.size.width/2
        btn3.layer.borderColor = UIColor.lightGray.cgColor
        
        btn4.layer.borderWidth = 1
        btn4.layer.cornerRadius = btn4.layer.frame.size.width/2
        btn4.layer.borderColor = UIColor.lightGray.cgColor
        
    }
}

