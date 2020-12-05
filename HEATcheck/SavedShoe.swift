//
//  SavedShoe.swift
//  HEATcheck
//
//  Created by Brenden Picioane on 12/5/20.
//

import Foundation
import Firebase

class SavedShoe {
    
    var brand: String
    var retailPrice: Int
    var title: String
    var year: Int
    var media: [String: String]
    var postingUserID: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["brand" : brand, "retailPrice" : retailPrice, "title" : title, "year" : year, "media" : media, "postingUserID" : postingUserID]
    }
    
    init(brand: String, retailPrice: Int, title: String, year: Int, media: [String: String], postingUserID: String, documentID: String) {
        self.brand = brand
        self.retailPrice = retailPrice
        self.title = title
        self.year = year
        self.media = media
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(brand: "", retailPrice: 0, title: "", year: 0, media: ["": ""], postingUserID: "", documentID: "")
    }
    
    convenience init(dictionary: [String : Any]) {
        let brand = dictionary["brand"] as! String? ?? ""
        let retailPrice = dictionary["retailPrice"] as! Int? ?? 0
        let title = dictionary["title"] as! String? ?? ""
        let year = dictionary["year"] as! Int? ?? 0
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        let media = dictionary["media"] as! [String: String]? ?? ["":""]
        self.init(brand: brand, retailPrice: retailPrice, title: title, year: year, media: media, postingUserID: postingUserID, documentID: "")
    }
    
    func saveData(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        guard let postingUserID = Auth.auth().currentUser?.uid else {
            print("L. Don't have a valid posting user ID.")
            return completion(false)
        }
        self.postingUserID = postingUserID
        let dataToSave: [String : Any] = self.dictionary
        print(dataToSave["title"]!)
        if self.documentID == "" {
            var ref: DocumentReference? = nil
            ref = db.collection("users").document(postingUserID).collection("shoes").addDocument(data: dataToSave) { (error) in
                guard error == nil else {
                    print("L. error making doc. \(error!.localizedDescription)")
                    return completion(false)
                }
                self.documentID = ref!.documentID
                print("W. added document \(self.documentID)")
                completion(true)
            }
        }
//        else {
//            let ref = db.collection("users").document(postingUserID).collection("shoes").document(self.documentID)
//            ref.setData(dataToSave) { (error) in
//                guard error == nil else {
//                    print("L. error updating doc. \(error!.localizedDescription)")
//                    return completion(false)
//                }
//                print("W. updated document \(self.documentID)")
//                completion(true)
//            }
//        }
    }
    
}
