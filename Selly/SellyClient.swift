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
    let itemPhotoRef = Storage.storage().reference().child("itemPhotos")
    let chatRoomRef = Database.database().reference().child("chatRooms")
    
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
        let sellerName: String = (Auth.auth().currentUser?.displayName)!
        //let sellerPhotoURL: URL = (Auth.auth().currentUser?.photoURL)!
        let sellerPhotoUrl: String = (Auth.auth().currentUser?.photoURL)!.absoluteString
        let sellerEmail: String = (Auth.auth().currentUser?.email)!

        let newItemRef = self.itemRef.childByAutoId()
        let itemInfo = ["itemId": newItemRef.key, "itemName": itemName, "itemPrice": itemPrice, "itemCategory": itemCategory, "itemDescription": itemDescription, "uidSeller": uidSeller, "createdTimeStamp": Date().timeIntervalSince1970, "updatedTimeStamp": Date().timeIntervalSince1970, "itemPhotos": itemPhotos, "sellerName": sellerName, "sellerImageURL": sellerPhotoUrl, "sellerEmail": sellerEmail] as [String : Any]
        
        newItemRef.setValue(itemInfo) { (error, reference) in
            if let error = error {
                print(error.localizedDescription)
                failure(error)
            } else {
                success(Item(itemInfo: itemInfo))
            }
        }
    }
    
    func uploadPhoto(itemPhotos: [UIImage], success: @escaping ([String]) ->(), failure: @escaping (Error) ->()) {
        var photoURLs: [String] = []
//        var count = 0
        let myGroup = DispatchGroup()

        for photo in itemPhotos {
//            count += 1
            myGroup.enter()
            itemPhotoRef.child(UUID().uuidString).putData(UIImagePNGRepresentation(photo)!, metadata: nil, completion: { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                    failure(error)
                    return
                } else if let metadata = metadata {
                    let downloadUrl = metadata.downloadURL()!.absoluteString
                    photoURLs.append(downloadUrl)
                    myGroup.leave()

//                    if count == itemPhotos.count {
//                        success(photoURLs)
//                    }
                }
            })
        }
        myGroup.notify(queue: .main) {
            success(photoURLs)
        }
    }
    
//    func getItemsList(itemsList: [String], success: @escaping (Item))
    
    // *TODO : getItem function
    func getItemInfo(items: String, success: @escaping (Item) ->(), failure: @escaping (Error)->()){
        itemRef.child(items).observeSingleEvent(of: .value, with: { (snapshot) in
            if let itemInfo = snapshot.value as? [String: Any]{
                print(itemInfo)
                success(Item(itemInfo: itemInfo))
            }
        })
    }

    //
    func getChatRooms(userId: String, success: @escaping ([ChatRoom]) -> (), failure: @escaping (Error)->()) {
        chatRoomRef.queryEqual(toValue: userId, childKey: "uidBuyer").observeSingleEvent(of: .value, with: { (snapshot) in
            if let chatRoomsInfo = snapshot.value as? [[String: Any]] {
                print(chatRoomsInfo)
            }
        })
    }

    
    
}

