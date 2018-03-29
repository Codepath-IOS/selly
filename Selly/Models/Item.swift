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
    
    init(itemInfo: [String: Any]) {
        itemId = itemInfo["itemId"] as! String
        itemName = itemInfo["iteamName"] as! String
        itemPrice = itemInfo["itemPrice"] as! String
        itemCategory = itemInfo["itemCategory"] as! String
        itemDescription = itemInfo["itemDescription"] as! String
        uidSeller = itemInfo["uidSeller"] as! String
    }
    
}
