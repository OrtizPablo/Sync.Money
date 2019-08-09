//
//  AccountCollectionViewCell.swift
//  Sync.Money
//
//  Created by Pablo Rodriguez on 05/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import UIKit

protocol AccountCollectionViewCellFlowDelegate: AnyObject {
    func didTapAddNewAccountButton()
}

final class AccountCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var flowDelegate: AccountCollectionViewCellFlowDelegate?
    
    var isGeneralCell: Bool = false {
        didSet {
            bankDetailsLabel.isHidden = isGeneralCell
            moneyLabel.isHidden = isGeneralCell
            addNewAccountButton.isHidden = !isGeneralCell
            logoImageViewWidthConstraint.constant = isGeneralCell ? 171.0 : 58
        }
    }
    
    var accountType: AccountType = .sync {
        didSet {
            switch accountType {
            case .sync: setGradientBackground(with: UIColor(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1.0), bottomColor: .white)
            case .bank: setGradientBackground(with: UIColor(red: 243/255.0, green: 249/255.0, blue: 246/255.0, alpha: 1.0), bottomColor: .white)
            }
        }
    }
    
    @IBOutlet private weak var view: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet private weak var logoImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var bankDetailsLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet private weak var addNewAccountButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.white.cgColor
        addNewAccountButton.layer.cornerRadius = 23
        addNewAccountButton.addTarget(self, action: #selector(didTapAddNewAccountButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func didTapAddNewAccountButton() {
        flowDelegate?.didTapAddNewAccountButton()
    }
}
