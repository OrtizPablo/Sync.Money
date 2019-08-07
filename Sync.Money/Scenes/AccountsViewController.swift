//
//  AccountsViewController.swift
//  Sync.Money
//
//  Created by Pablo Rodriguez on 05/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import UIKit

private let moneyCell = "MoneyCell"
private let accountsCell = "AccountsCell"

final class AccountsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    private var syncAccounts: [SyncAccount] = []
    private var bankAccounts: [BankAccount] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initTableView()
        initMockData()
    }
    
    private func initNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        navigationItem.title = "All Accounts"
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_left_bar_button"), style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func initTableView() {
        let moneyCellNib = UINib(nibName: moneyCell, bundle: nil)
        let accountsCellNib = UINib(nibName: accountsCell, bundle: nil)
        tableView.register(moneyCellNib, forCellReuseIdentifier: moneyCell)
        tableView.register(accountsCellNib, forCellReuseIdentifier: accountsCell)
        
        tableView.separatorStyle = .none
    }
    
    private func initMockData() {
        let syncAccount = SyncAccount(image: UIImage(named: "logo_uk_currency") ?? UIImage(), currency: "GBP", accountName: "sync.Account", accountNumber: 00175579, sortCode: "62-22-07", money: 1720.21)
        let bankAccount = BankAccount(image: UIImage(named: "logo_lloyds") ?? UIImage(), bankName: "Lloyds Bank", accountName: "Classic Account", accountNumber: 00175580, sortCode: "62-22-08", money: 2752.27)
        
        syncAccounts = [syncAccount]
        bankAccounts = [bankAccount]
    }
    
    // MARK: - Actions
    
    @objc private func leftBarButtonItemTapped(){
        print("Left bar button item tapped")
    }
}

// MARK: - UITableViewDataSource

extension AccountsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: moneyCell, for: indexPath) as? MoneyCell  else {
                print("Unable to dequeue MoneyCell")
                return UITableViewCell()
            }
            cell.amountLabel.text = "1,720.21"
            cell.currencyLabel.text = "British Pounds"
            return cell
        } else if indexPath.row == 1 || indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: accountsCell, for: indexPath) as? AccountsCell  else {
                print("Unable to dequeue AccountsCell")
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.collectionView.dataSource = self
            if indexPath.row == 1 {
                cell.titleLabel.text = "sync.Accounts(0)"
                cell.collectionView.accountType = .sync
                cell.pageControl.numberOfPages = syncAccounts.count + 1
            } else {
                cell.titleLabel.text = "Bank Accounts (0)"
                cell.collectionView.accountType = .bank
                cell.pageControl.numberOfPages = bankAccounts.count + 1
            }
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension AccountsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension AccountsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let collectionView = collectionView as? AccountsCollectionView, let type = collectionView.accountType else { return 0 }
        return 1 + (type == .sync ? syncAccounts.count : bankAccounts.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionView = collectionView as? AccountsCollectionView, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionViewCell", for: indexPath) as? AccountCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.flowDelegate = self
        if case .sync? = collectionView.accountType {
            cell.isGeneralCell = indexPath.row == syncAccounts.count ? true : false
            
            if cell.isGeneralCell {
                cell.logoImageView.image = UIImage(named: "logo_currencies")
                cell.currencyLabel.text = "Other"
                cell.accountLabel.text = "sync.Account"
            } else {
                cell.logoImageView.image = syncAccounts[indexPath.row].image
                cell.currencyLabel.text = syncAccounts[indexPath.row].currency
                cell.accountLabel.text = syncAccounts[indexPath.row].accountName
                cell.bankDetailsLabel.text = String(syncAccounts[indexPath.row].accountNumber) + " | " + syncAccounts[indexPath.row].sortCode
                cell.moneyLabel.text = "£ " + String(syncAccounts[indexPath.row].money)
            }
        } else {
            cell.isGeneralCell = indexPath.row == bankAccounts.count ? true : false
            
            if cell.isGeneralCell {
                cell.logoImageView.image = UIImage(named: "logo_banks")
                cell.currencyLabel.text = "Other"
                cell.accountLabel.text = "Bank Account"
            } else {
                cell.logoImageView.image = bankAccounts[indexPath.row].image
                cell.currencyLabel.text = bankAccounts[indexPath.row].bankName
                cell.accountLabel.text = bankAccounts[indexPath.row].accountName
                cell.bankDetailsLabel.text = String(bankAccounts[indexPath.row].accountNumber) + " | " + bankAccounts[indexPath.row].sortCode
                cell.moneyLabel.text = "£ " + String(bankAccounts[indexPath.row].money)
            }
        }
        
        return cell
    }
}

// MARK: - AccountCollectionViewCellFlowDelegate

extension AccountsViewController: AccountCollectionViewCellFlowDelegate {
    
    func didTapAddNewAccountButton() {
        print("Add new account button tapped")
    }
}
