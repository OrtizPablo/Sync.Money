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
            logoImageViewWidthConstraint.constant = isGeneralCell ? 150.0 : 60
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
        
        setGradientBackground()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.red.cgColor
        addNewAccountButton.layer.cornerRadius = 30
        addNewAccountButton.addTarget(self, action: #selector(didTapAddNewAccountButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func didTapAddNewAccountButton() {
        flowDelegate?.didTapAddNewAccountButton()
    }
    
    // MARK: - Private methods
    
    func setGradientBackground() {
        // TODO: Modify the top and the bottom color
        let topColor = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.frame
        gradientLayer.cornerRadius = 10
        
        view.layer.insertSublayer(gradientLayer, at:0)
    }
}
