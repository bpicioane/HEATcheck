//
//  SearchViewController.swift
//  HEATcheck
//
//  Created by Brenden Picioane on 12/2/20.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var name = ""
    
    var shoes = Shoes()

    override func viewWillAppear(_ animated: Bool) {
        var upcShoe = UPC()
        upcShoe.upc = name
        upcShoe.getData {
            print(upcShoe.title)
            self.name = upcShoe.title
//            print(upcShoe.title)
//            print(name)
            DispatchQueue.main.async {
                self.searchField.text = self.name
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchField.text = name
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ShoeDetailViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        //print(shoes.shoeArray[selectedIndexPath.row])
        destination.shoe = shoes.shoeArray[selectedIndexPath.row]
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        shoes.name = searchField.text ?? ""
        print(shoes.name)
        shoes.getData {
            DispatchQueue.main.async {
                if self.shoes.shoeArray.count == 1 || self.shoes.shoeArray.isEmpty {
                    self.shoes.shoeArray = [Shoe(brand: "", retailPrice: 0, title: "no shoes found", year: 2000, media: ["":""])]
                    //self.shoes.shoeArray.append()
                }
                self.tableView.reloadData()
            }
        }
        print("got here")
//        if shoes.shoeArray.isEmpty {
//            shoes.shoeArray.append(Shoe(brand: "", retailPrice: 0, title: "no shoes found", year: 2000, media: ["":""]))
//        }
        //print(shoes.shoeArray[1].title)
        //tableView.reloadData()
    }
    

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoes.shoeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = shoes.shoeArray[indexPath.row].title
        if shoes.shoeArray[indexPath.row].title == "no shoes found" {
            cell.isUserInteractionEnabled = false
            if indexPath.row > 0 {
                cell.textLabel!.text = ""
            }
        } else {
            cell.isUserInteractionEnabled = true
        }
        return cell
    }
    
    
}
