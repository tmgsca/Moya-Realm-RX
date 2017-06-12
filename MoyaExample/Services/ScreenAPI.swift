//
//  ScreenService.swift
//  MoyaExample
//
//  Created by Thiago Magalhães on 11/06/17.
//  Copyright © 2017 iFactory. All rights reserved.
//

import Foundation
import Moya

enum ScreenAPI {
    
    case current(cityId: Int)
}

extension ScreenAPI: TargetType {
    
    /// The target's base `URL`.
    var baseURL: URL {
        
        return URL(string: "")!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        
        switch self {
            
        case .current(let cityId):
            
            return "/\(cityId)"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        
        switch self {
            
        case .current:
            
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String : Any]? {
        
        return nil
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        
        return JSONEncoding.default
    }
    
    var task: Task {
        
        return .request
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        
        switch self {
            
        case .current:
            
            return "".data(using: .utf8)!
        }
    }
}
