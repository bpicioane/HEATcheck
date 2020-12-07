//
//  Shoes.swift
//  HEATcheck
//
//  Created by Brenden Picioane on 12/1/20.
//

import Foundation
import Firebase

class Shoes {
    
    var name = ""
    var shoeArray: [Shoe] = []
    var db: Firestore!
    
    private struct Returned: Codable {
        var results: [Shoe]
    }
    
    init() {
        db = Firestore.firestore()
    }
    
    var urlString = "https://api.thesneakerdatabase.com/v1/sneakers?limit=10&sort=retailPrice:desc&name="
    
    func getData(completed: @escaping () -> ()) {
        guard let url = URL(string: "\(urlString)\(name.replacingOccurrences(of: " ", with: "%20"))") else {
            print("L. Something went wrong with the URL.")
            completed()
            return
        }
        print("\(urlString)\(name.replacingOccurrences(of: " ", with: "%20"))")
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("L. url session broke. ")
            }
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.shoeArray = returned.results
//                if returned.code == "OK" {
//                    print("this was returned: \(returned)")
//                    self.title = returned.items[0].title
//                } else {
//                    print("Barcode not in API.")
//                }
            } catch {
                print("L. JSON error. \(error.localizedDescription)")
                //self.shoeArray.append(Shoe(brand: "", retailPrice: 0, title: "no shoes found", year: 2000, media: ["":""]))
            }
            completed()
        }
        task.resume()
    }
    
    func loadData(completed: @escaping () -> ()) {
        guard let postingUserID = Auth.auth().currentUser?.uid else {
            print("L. Don't have a valid posting user ID.")
            return completed()
        }
        db.collection("users").document(postingUserID).collection("shoes").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("L. Couldn't add snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.shoeArray = []
            for document in querySnapshot!.documents {
                let shoe = SavedShoe(dictionary: document.data())
                shoe.documentID = document.documentID
                self.shoeArray.append(Shoe(brand: shoe.brand, retailPrice: shoe.retailPrice, title: shoe.title, year: shoe.year, media: shoe.media))
            }
            completed()
        }
    }
    
    
}
