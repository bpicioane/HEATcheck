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
        
        
        
        
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
    }
    

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoes.shoeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = shoes.shoeArray[indexPath.row].title
        return cell
    }
    
    
}
