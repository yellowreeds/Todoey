//
//  Category.swift
//  Todoey
//
//  Created by Aria Bisma Wahyutama on 21/06/19.
//  Copyright © 2019 Aria Bisma Wahyutama. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
