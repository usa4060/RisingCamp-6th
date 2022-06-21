import Foundation
import UIKit

struct Data {

    private var someArray = [UIImage]()
    
    init() {
        createImage()
    }
    
    mutating func createImage() {
        if let image = UIImage(named: "망고플레이트_Logo.jpeg") {
            for _ in 0..<40 {
                someArray.append(image)
            }
        }
    }
    
    var imageArray: [UIImage] {
        return someArray
    }

}
