//
//  ViewController.swift
//  NetworkHealth
//
//  Created by Gabor Racz on 2018/03/12.
//  Copyright © 2018 Wodo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var networkGoodLbl: UILabel!
    @IBOutlet weak var networkBadLbl: UILabel!
    @IBOutlet weak var refreshBtn: UIButton!
    
    let dispose = DisposeBag()
    let reachability = ReachabilityStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshBtn.rx.tap.bind{
            
            self.checkNetwokStatus().subscribeOn(MainScheduler.instance).subscribe({ (status) in
                if(status.element == true){
                    self.networkGoodLbl.isHidden = false
                    self.networkBadLbl.isHidden = true
                }else{
                    self.networkGoodLbl.isHidden = true
                    self.networkBadLbl.isHidden = false
                }
            }).disposed(by: self.dispose)
            
            }.disposed(by: dispose)
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkNetwokStatNotify(notification:)), name: .network, object: nil)
        NotificationCenter.default.post(name: .network, object: nil)
    }
    
    private func checkNetwokStatus() -> Observable<Bool>{
        
        return Observable.create({ (obs) -> Disposable in
            
            if ReachabilityStatus.isConnectedToNetwork(){
                obs.onNext(true)
                
            }else{
                obs.onNext(false)
                obs.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    @objc private func checkNetwokStatNotify(notification:NSNotification){
        
        if ReachabilityStatus.isConnectedToNetwork(){
            print("yar")
        }else{
            print("nay")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Notification.Name{
    
     static let network = Notification.Name("network")
    
}

