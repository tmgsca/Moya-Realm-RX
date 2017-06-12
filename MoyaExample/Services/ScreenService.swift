//
//  ScreenService.swift
//  MoyaExample
//
//  Created by Thiago Magalhães on 12/06/17.
//  Copyright © 2017 iFactory. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RealmSwift
import RxSwift
import RxRealm
import RxOptional

struct ScreenService {
    
    let provider: RxMoyaProvider<ScreenAPI>
    
    init() {
        
        let endpointClosure = { (target: ScreenAPI) -> Endpoint<ScreenAPI> in
            
            let headers = ["x-api-key": ""]
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint.adding(newHTTPHeaderFields: headers)
        }
        
        self.provider = RxMoyaProvider<ScreenAPI>(endpointClosure: endpointClosure)
    }
    
    func getScreens(_ cityId: Int) -> Observable<List<Highlight>> {
        
        return provider.request(.current(cityId: cityId))
            .debug()
            .mapObjectOptional(type: Screen.self)
            .do(onNext: { screen in
                
                DispatchQueue.global().async {
                    
                    let realm = try! Realm()
                    
                    if let screen = screen {
                        
                        try! realm.write {
                            
                            realm.add(screen)
                        }
                    }
                }
                
            }).map({ (screen) -> List<Highlight> in
                
                return screen!.highlights
            })
    }
    
}
