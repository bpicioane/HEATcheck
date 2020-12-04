//
//  ShoeDetailViewController.swift
//  HEATcheck
//
//  Created by Brenden Picioane on 12/3/20.
//

import UIKit

class ShoeDetailViewController: UIViewController {
    
    @IBOutlet weak var shoeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    var shoe: Shoe!

    override func viewDidLoad() {
        super.viewDidLoad()
        if shoe == nil {
            shoe = Shoe(brand: "", retailPrice: 1, title: "didn't work", year: 1, media: ["":""])
        }
        //print(shoe)
        nameLabel.text = shoe.title
        brandLabel.text = shoe.brand
        yearLabel.text = "\(shoe.year)"
        priceLabel.text = "$\(shoe.retailPrice)"
        
        guard let imageURLString = shoe.media["imageUrl"] else {
            print("image url isn't working. L")
            return
        }
        
        guard let url = URL(string: imageURLString) else {
            print("Couldn't get a valid URL from \(imageURLString)")
            return
        }
                
        do {
            let data = try Data(contentsOf: url)
            shoeImageView.image = UIImage(data: data)
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
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
    }
    

}
