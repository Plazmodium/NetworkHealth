//
//  ViewController.swift
//  NetworkHealth
//
//  Created by Gabor Racz on 2018/03/12.
//  Copyright © 2018 Wodo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var networkGoodLbl: UILabel!
    @IBOutlet weak var networkBadLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkNetwokStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func checkNetwokStatus(){
        
        if ReachabilityStatus.isConnectedToNetwork(){
            networkGoodLbl.isHidden = false
            networkBadLbl.isHidden = true
        }else{
            networkGoodLbl.isHidden = true
            networkBadLbl.isHidden = false
        }
    }
}

