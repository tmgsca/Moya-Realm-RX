//
//  Result.swift
//  MoyaExample
//
//  Created by Thiago Magalhães on 12/06/17.
//  Copyright © 2017 iFactory. All rights reserved.
//

import Foundation

enum Result<Value> {
    case Success(Value)
    case Failure(Error)
}
