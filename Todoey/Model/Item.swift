//
//  Item.swift
//  Todoey
//
//  Created by Aria Bisma Wahyutama on 21/06/19.
//  Copyright © 2019 Aria Bisma Wahyutama. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
