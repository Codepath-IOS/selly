//
//  User.swift
//  Selly
//
//  Created by kimeric on 3/28/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit

class User: NSObject {
    var uid: String!
    var name: String!
    var email: String!
    var photo: String!
    
    init(userInfo: [String: Any]) {
        uid = userInfo["uid"] as! String
        name = userInfo["name"] as! String
        email = userInfo["email"] as! String
        photo = userInfo["photo"] as! String
    }
}
