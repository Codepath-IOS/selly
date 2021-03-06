//
//  Item.swift
//  Selly
//
//  Created by kimeric on 3/28/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit

class Item: NSObject {
    var itemId: String!
    var itemName: String!
    var itemPrice: String!
    var itemCategory: String!
    var itemDescription: String!
    var uidSeller: String!
    var createdTimeStamp: Double!
    var updatedTimeStamp: Double!
    //var itemPhotoURL : [String]!
    var sellerName: String!
    var sellerImageURL: String!
    var sellerEmail: String!
    
    init(itemInfo: [String: Any]) {
        itemId = itemInfo["itemId"] as! String
        itemName = itemInfo["itemName"] as! String
        itemPrice = itemInfo["itemPrice"] as! String
        itemCategory = itemInfo["itemCategory"] as! String
        itemDescription = itemInfo["itemDescription"] as! String
        uidSeller = itemInfo["uidSeller"] as! String
        sellerName = itemInfo["sellerName"] as! String
        sellerImageURL = itemInfo["sellerImageURL"] as! String
        sellerEmail = itemInfo["sellerEmail"] as! String
      //  itemPhotoURL = itemInfo["itemPhotoURL"] as! [String]
    }
   
    
}
