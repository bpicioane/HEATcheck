//
//  ShoeDetailViewController.swift
//  HEATcheck
//
//  Created by Brenden Picioane on 12/3/20.
//

import UIKit
import Firebase

class ShoeDetailViewController: UIViewController {
    
    @IBOutlet weak var shoeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var backToHomeButton: UIButton!
    
    
    
    var shoe: Shoe!

    override func viewDidLoad() {
        super.viewDidLoad()
        if (presentingViewController is UINavigationController) {
            backToHomeButton.isHidden = true
        }
        if shoe == nil {
            shoe = Shoe(brand: "", retailPrice: 1, title: "didn't work", year: 1, media: ["":""])
        }
        //print(shoe)
        nameLabel.text = shoe.title.lowercased()
        brandLabel.text = shoe.brand.lowercased()
        yearLabel.text = "\(shoe.year)"
        priceLabel.text = "$\(shoe.retailPrice)"
        
        guard let imageURLString = shoe.media["imageUrl"] ?? "" else {
            print("image url isn't working. L")
            return
        }

        guard let url = URL(string: imageURLString) else {
            print("Couldn't get a valid URL from \(imageURLString)")
            return
        }
                
        do {
            let data = try Data(contentsOf: url)
            var image = UIImage(data: data)
//            let colorMasking: [CGFloat] = [222.0,255.0,222.0,255.0,222.0,255.0]
//            let imageRef = image?.cgImage!.copy(maskingColorComponents: colorMasking)
//            image = UIImage(cgImage: imageRef!) ?? UIImage()
            shoeImageView.image = image
        } catch {
            print("ERROR: error thrown trying to get image from url \(url)")
        }

    }
    
//    func dismissViewControllers() {
//
//        guard let vc = self.presentingViewController else { return }
//
//        while (vc.presentingViewController != nil) {
//            vc.dismiss(animated: true, completion: nil)
//        }
//    }
    
    @IBAction func backToHomeButtonPressed(_ sender: UIButton) {
        //dismissViewControllers()
        if !(presentingViewController is UINavigationController) {
            let savedShoe = SavedShoe()
            savedShoe.brand = shoe.brand
            savedShoe.retailPrice = shoe.retailPrice
            savedShoe.title = shoe.title
            savedShoe.media = shoe.media
            savedShoe.year = shoe.year

            savedShoe.saveData { (success) in
                if success {
                    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                } else {
                    print("save didnt work. L")
                }
            }
        }
    }
}
