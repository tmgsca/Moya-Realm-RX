//
//  Highlight.swift
//  MoyaExample
//
//  Created by Thiago Magalhães on 12/06/17.
//  Copyright © 2017 iFactory. All rights reserved.
//

import Foundation
import RealmSwift
import Mapper

class Highlight: Object, Mappable {
    
    dynamic var order: Int = 0
    
    required convenience init(map: Mapper) throws {
        
        self.init()
        
        try self.order = map.from("order")
    }
}
