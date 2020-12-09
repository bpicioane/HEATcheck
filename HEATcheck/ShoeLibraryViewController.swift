//
//  ShoeLibraryViewController.swift
//  HEATcheck
//
//  Created by Brenden Picioane on 12/1/20.
//

import UIKit
import Firebase

class ShoeLibraryViewController: UIViewController {
    
    var shoes: Shoes!
    
    //var shoe: Shoe!
    //var currentUser = Auth.auth().currentUser?.uid
    
    //var shoe = Shoe(brand: "adidas", retailPrice: 250, title: "yeezy", year: 2020, media: ["":""])

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoes = Shoes()
        //shoes.shoeArray.append(shoe)

        tableView.dataSource = self
        tableView.delegate = self
        
        shoes.loadData {
            self.shoes.shoeArray.sort(by: {$0.title.lowercased() < $1.title.lowercased()})
            self.tableView.reloadData()
        }
        
        
//        var yeezy = UPC()
//        yeezy.upc = "0194816598148"
//        yeezy.getData {
//            print(yeezy.title)
//        }
    }
    
    func sortBasedOnSegmentPressed() {
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0:
            shoes.shoeArray.sort(by: {$0.title.lowercased() < $1.title.lowercased()})
        case 1:
            shoes.shoeArray.sort(by: {$0.retailPrice > $1.retailPrice})
        case 2:
            shoes.shoeArray.sort(by: {$0.retailPrice < $1.retailPrice})
        default:
            print("Error")
        }
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailFromLibrary" {
            let destination = segue.destination as! ShoeDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            //print(shoes.shoeArray[selectedIndexPath.row])
            destination.shoe = shoes.shoeArray[selectedIndexPath.row]
        }
    }
    
    @IBAction func sortSegmentPressed(_ sender: UISegmentedControl) {
        sortBasedOnSegmentPressed()
    }
    

}

extension ShoeLibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoes.shoeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = shoes.shoeArray[indexPath.row].title.lowercased()
        cell.detailTextLabel!.text = "$\(shoes.shoeArray[indexPath.row].retailPrice)"
        return cell
    }
    
}
