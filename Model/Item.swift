//
//  Item.swift
//  Rembember
//
//  Created by ADMIN on 8/29/19.
//  Copyright © 2019 ADMIN. All rights reserved.
//

import Foundation
import RealmSwift
class Item : Object {
    @objc dynamic  var itemName : String = ""
    @objc dynamic var itemIsChecked : Bool = false
    var parentCateagory = LinkingObjects(fromType: Cateagory.self, property: "items")
}
