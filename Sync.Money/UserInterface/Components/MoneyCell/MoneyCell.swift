//
//  MoneyCell.swift
//  Sync.Money
//
//  Created by Pablo Rodriguez on 05/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import UIKit

final class MoneyCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
    }
}
