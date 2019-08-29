//
//  Cateagory.swift
//  Rembember
//
//  Created by ADMIN on 8/29/19.
//  Copyright © 2019 ADMIN. All rights reserved.
//

import Foundation
import RealmSwift
class Cateagory : Object {
    @objc dynamic var name : String = ""
    var items = List<Item>()
}
