//
//  Screen.swift
//  MoyaExample
//
//  Created by Thiago Magalhães on 12/06/17.
//  Copyright © 2017 iFactory. All rights reserved.
//

import Foundation
import RealmSwift
import Mapper

class Screen: Object, Mappable {

    dynamic var id: String = ""

    let highlights = List<Highlight>()
    
    required convenience init(map: Mapper) throws {
        
        self.init()
        
        try id = map.from("data.id")
        
        let data: [Highlight] = try map.from("data.highlights")
        
        highlights.append(objectsIn: data)
        
    }
}
