//
//  HideBackgroundViewController.swift
//  Week2
//
//  Created by admin on 2022/05/28.
//

import UIKit

class HideBackgroundViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        (starbucksImage.frame, _) = view.bounds.divided(atDistance: view.bounds.height, from: .minYEdge)
    }

    private lazy var starbucksImage: UIImageView = {
        let hidden = UIImageView()
        
        hidden.backgroundColor = .systemGreen
        hidden.translatesAutoresizingMaskIntoConstraints = false
        hidden.image = UIImage(named: "hiddenStarbucks.jpeg")
        self.view.addSubview(hidden)
        
        return hidden
    }()
}
