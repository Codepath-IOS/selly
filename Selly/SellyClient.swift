//
//  SellyClient.swift
//  Selly
//
//  Created by kimeric on 3/28/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

//import Foundation
import UIKit
import Firebase

class SellyClient {
    static let sharedInstance = SellyClient()
    
    let userRef = Database.database().reference().child("users")
    let itemRef = Database.database().reference().child("items")
    
    func createFacebookUser(user: String, name: String, email: String, photo: String, success: @escaping (User) ->(), failure: @escaping (Error) ->()) {
        
        let newUserRef = self.userRef.child(user)
        let userInfo = ["name": name, "email": email, "uid": user, "photo": photo]
        
        newUserRef.setValue(userInfo, withCompletionBlock: { (error, reference) in
            if let error = error {
                print(error.localizedDescription)
                failure(error)
            } else {
                success(User(userInfo: userInfo))
            }
        })
    }
    
    func getUser(user: String, success: @escaping (User) ->(), failure: @escaping (Error)->()) {
        userRef.child(user).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userInfo = snapshot.value as? [String: Any]{
                success(User(userInfo: userInfo))
            }
        })
    }
    
    func createItem(itemName: String, itemPrice: String, itemCategory: String, itemDescription: String, uidSeller: String, itemPhotos: [String], success: @escaping (Item) ->(), failure: @escaping (Error) ->()) {
        
        let newItemRef = self.itemRef.childByAutoId()
        let itemInfo = ["itemId": newItemRef.key, "itemName": itemName, "itemPrice": itemPrice, "itemCategory": itemCategory, "itemDescription": itemDescription, "uidSeller": uidSeller, "createdTimeStamp": Date().timeIntervalSince1970, "updatedTimeStamp": Date().timeIntervalSince1970, "itemPhotos": itemPhotos] as [String : Any]
        
        newItemRef.setValue(itemInfo) { (error, reference) in
            if let error = error {
                print(error.localizedDescription)
                failure(error)
            } else {
                success(Item(itemInfo: itemInfo))
            }
        }
    }
}

