//
//  ViewController.swift
//  Sync.Money
//
//  Created by Pablo Rodriguez on 05/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import UIKit

final class OtherViewController: UIViewController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }

    private func initUI() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
        view.addSubview(label)
        label.center = view.center
        label.text = "Default Screen"
        label.textAlignment = .center
    }

}

