//
//  AccountsCell.swift
//  Sync.Money
//
//  Created by Pablo Rodriguez on 05/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import UIKit

final class AccountsCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: AccountsCollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
        
        let accountCollectionViewCellNib = UINib(nibName: "AccountCollectionViewCell", bundle: nil)
        collectionView.register(accountCollectionViewCellNib, forCellWithReuseIdentifier: "AccountCollectionViewCell")
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDelegate

extension AccountsCell: UICollectionViewDelegate {}

// MARK: - UIScrollViewDelegate

extension AccountsCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

enum AccountType {
    case sync, bank
}

final class AccountsCollectionView: UICollectionView {
    
    var accountType: AccountType?
}
