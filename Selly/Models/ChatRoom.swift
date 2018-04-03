//
//  ChatRoom.swift
//  Selly
//
//  Created by kimeric on 4/2/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit

class ChatRoom: NSObject {
    var roomId: String!
    var itemId: String!
//    var itemName: String!
//    var itemPrice: String!
//    var itemCategory: String!
//    var itemDescription: String!
    //var itemPhotoURL : [String]!
    var uidSeller: String!
//    var sellerName: String!
//    var sellerImageURL: String!
//    var sellerEmail: String!
    
    var uidBuyer: String!
    var createdTimeStamp: Double!
    
    
    init(chatRoomInfo: [String: Any]) {
        roomId = chatRoomInfo["roomId"] as! String
        itemId = chatRoomInfo["itemId"] as! String
        uidSeller = chatRoomInfo["uidSeller"] as! String
        uidBuyer = chatRoomInfo["uidBuyer"] as! String
    }
}
