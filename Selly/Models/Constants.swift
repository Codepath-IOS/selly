//
//  Constants.swift
//  Selly
//
//  Created by siddhant on 3/30/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import Foundation
import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
