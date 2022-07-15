//
//  FindResCollectionViewCell.swift
//  week5
//
//  Created by admin on 2022/06/21.
//

import UIKit

class FindResCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var resName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        self.backgroundColor = .white
    }
    
    func setData(_ data: Datum) {
        phoneNumber.text = data.phoneNum
        address.text = data.address1 ?? " "
        resName.text = data.resName
        
        
//        let url = URL(string: image.imageURL)
//        DispatchQueue.global().async {
//            let data = try? Data(contentsOf: url!)
//            DispatchQueue.main.async {
//                self.imageView.image = UIImage(data: data!)
//            }
//        }
    }
}
