//
//  ShoeLibraryViewController.swift
//  HEATcheck
//
//  Created by Brenden Picioane on 12/1/20.
//

import UIKit

class ShoeLibraryViewController: UIViewController {
    
    //var shoes: Shoes!
    
    var shoe = Shoe(brand: "adidas", retailPrice: 250, title: "yeezy", year: 2020, media: ["":""])

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
//        var yeezy = UPC()
//        yeezy.upc = "0194816598148"
//        yeezy.getData {
//            print(yeezy.title)
//        }
    }

}

extension ShoeLibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = shoe.title
        cell.detailTextLabel!.text = "$\(shoe.retailPrice)"
        return cell
    }
    
    
}
