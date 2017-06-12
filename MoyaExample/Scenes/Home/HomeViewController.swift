//
//  HomeViewController.swift
//  MoyaExample
//
//  Created by Thiago Magalhães on 10/06/17.
//  Copyright © 2017 iFactory. All rights reserved.
//

import UIKit
import RxSwift
import RxRealm
import RxRealmDataSources
import RxDataSources

class HomeViewController: BaseViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    
    public let viewModel = HomeViewModel()
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupNoResultViewStateListener()
        
        setupLoadingViewStateListener()
        
        setupTableView()
    
        viewModel.loadHighlightsFromService()
    }
    
    //MARK: Lifecycle
    
    private func setupTableView() {
        
        let dataSource = RxTableViewRealmDataSource<Highlight>(cellIdentifier: "cell", cellType: UITableViewCell.self) { (cell, indexPath, highlight) in
            
            cell.textLabel?.text = "\(highlight.order)"
        }
        
        viewModel.highlightsObservable.bindTo(self.tableView.rx.realmChanges(dataSource)).addDisposableTo(bag)
    }
    
    private func setupNoResultViewStateListener() {
    
        let count = viewModel.tableViewInfo.count.asObservable()
        let isLoading = viewModel.tableViewInfo.isLoading.asObservable()
        let error = viewModel.error.asObservable()
        
        Observable.of([count, isLoading, error]).map { behaviors -> (Bool, Error?) in
            
            let count = try (behaviors[0] as! BehaviorSubject<Int>).value()
            
            let isLoading = try (behaviors[1] as! BehaviorSubject<Bool>).value()
            
            let error = try (behaviors[2] as! BehaviorSubject<Error?>).value()
            
            return (count == 0 && !isLoading, error)
            
            }.filter { (shouldShowNoResultView, error) -> Bool in
                
                return shouldShowNoResultView
                
            }.map({ (_, error) -> Error? in
                
                return error
                
            }).subscribeOn(MainScheduler.instance).subscribe(onNext: { error in
                
                print("Show no result view, error = \(String(describing: error?.localizedDescription))")
                
            }).addDisposableTo(bag)
    }
    
    private func setupLoadingViewStateListener() {
    
        let count = viewModel.tableViewInfo.count.asObservable()
        let isLoading = viewModel.tableViewInfo.isLoading.asObservable()
        
        Observable.of([count, isLoading]).map { behaviors -> (Int, Bool) in
            
            let count = try (behaviors[0] as! BehaviorSubject<Int>).value()
            
            let isLoading = try (behaviors[1] as! BehaviorSubject<Bool>).value()
            
            return (count, isLoading)
        
        }.filter({ (_, isLoading) -> Bool in
            
            return isLoading
            
        }).subscribe(onNext: { (count, isLoading) in
            
            if count == 0 {
                
                // Displays loading view above table view
            }
            
        }).addDisposableTo(bag)
    
    
        viewModel.tableViewInfo.isLoading.asObservable().asObservable().subscribe(onNext: { isLoading in
            
             UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
            
        }).addDisposableTo(bag)
    }
}
