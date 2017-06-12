//
//  HomeViewModel.swift
//  MoyaExample
//
//  Created by Thiago Magalhães on 10/06/17.
//  Copyright © 2017 iFactory. All rights reserved.
//

import Foundation
import RxSwift
import RxRealm
import RealmSwift

class HomeViewModel: ViewModel {
    
    //MARK: Structs
    
    struct TableViewInfo {
        
        var count = Variable<Int>(0)
        
        var isLoading = Variable<Bool>(false)
    }
    
    //MARK: Properties
    
    private var bag = DisposeBag()
    
    var tableViewInfo = TableViewInfo()
    
    var error = Variable<Error?>(nil)
    
    func loadHighlightsFromService() {
        
        tableViewInfo.isLoading.value = true
        
        ScreenService().getScreens(2000).flatMapLatest { result -> Observable<List<Highlight>> in
            
            return Observable.just(result)
            
            }.subscribe(onNext: { result in
                
                self.error.value = nil
                
                self.tableViewInfo.count.value = result.count
                
                self.tableViewInfo.isLoading.value = false
                
            }, onError: { error in
                
                self.error.value = error
                
                self.tableViewInfo.isLoading.value = false
                
            }).addDisposableTo(bag)
    }
    
    var highlightsObservable: Observable<(AnyRealmCollection<Highlight>, RealmChangeset?)> {
        
        let realm = try! Realm()
        
        return Observable.changesetFrom(realm.objects(Highlight.self).sorted(byKeyPath: "order", ascending: true))
            .share()
            .do(onNext: { result in
                
            self.tableViewInfo.count.value = result.0.count
        })
    }
}
