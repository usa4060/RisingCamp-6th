//
//  StartViewController.swift
//  Week4
//
//  Created by admin on 2022/06/06.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func startBtnTapped(_ sender: UIButton) {
        guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {return;}
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: false)
    }
    
}
