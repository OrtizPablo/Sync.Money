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
    
    private enum MoneyFontContext {
        case moneyCell, accountCell
        
        var type: String {
            switch self {
            case .moneyCell: return "SFProDisplay-Semibold"
            case .accountCell: return "SFProDisplay-Bold"
            }
        }
        
        var currency: CGFloat {
            switch self {
            case .moneyCell: return 30
            case .accountCell: return 25
            }
        }
        
        var integer: CGFloat {
            switch self {
            case .moneyCell: return 38
            case .accountCell: return 34
            }
        }
        
        var point: CGFloat {
            switch self {
            case .moneyCell: return 40
            case .accountCell: return 32
            }
        }
        
        var decimals: CGFloat {
            switch self {
            case .moneyCell: return 34
            case .accountCell: return 28
            }
        }
    }
    
    // MARK: - Properties
    
    @IBOutlet private weak var topView: UIView!
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        initTopView()
    }
    
    // MARK: - Private functions
    
    private func initNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        initNavigationTitle()
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_left_bar_button"), style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func initNavigationTitle() {
        let label = UILabel()
        let title = NSMutableAttributedString(
            string: "All Accounts",
            attributes: [
                .foregroundColor: UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1.0),
                .font: UIFont(name: "HelveticaNeue-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .semibold)
            ])
        
        label.attributedText = title
        navigationItem.titleView = label
    }
    
    private func initTableView() {
        let moneyCellNib = UINib(nibName: moneyCell, bundle: nil)
        let accountsCellNib = UINib(nibName: accountsCell, bundle: nil)
        tableView.register(moneyCellNib, forCellReuseIdentifier: moneyCell)
        tableView.register(accountsCellNib, forCellReuseIdentifier: accountsCell)
        
        tableView.separatorStyle = .none
    }
    
    private func initMockData() {
        getSyncAccountsFromJson()
        getBankAccountsFromJson()
    }
    
    private func getSyncAccountsFromJson() {
        if let path = Bundle.main.path(forResource: "SyncAccounts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                syncAccounts = try JSONDecoder().decode([SyncAccount].self, from: data)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func getBankAccountsFromJson() {
        if let path = Bundle.main.path(forResource: "BankAccounts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                bankAccounts = try JSONDecoder().decode([BankAccount].self, from: data)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func initTopView() {
        topView.roundCorners(cornerRadius: 30, corners: [.bottomLeft, .bottomRight])
    }
    
    /// It converts the money String into the specific NSAttributedString
    ///
    /// - Parameter string: money string
    /// - Parameter context: context to apply the correct font and size
    private func convertMoneyStringToAttributedString(string: String, context: MoneyFontContext) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.font, value: UIFont(name: context.type, size: context.currency) ?? UIFont.systemFont(ofSize: context.currency, weight: .semibold), range: NSRange(location: 0, length: 1))
        attributedString.addAttribute(.font, value: UIFont(name: context.type, size: context.integer) ?? UIFont.systemFont(ofSize: context.integer, weight: .semibold), range: NSRange(location: 1, length: string.count - 4))
        attributedString.addAttribute(.font, value: UIFont(name: context.type, size: context.point) ?? UIFont.systemFont(ofSize: context.point, weight: .semibold), range: NSRange(location: string.count-3, length: 1))
        attributedString.addAttribute(.font, value: UIFont(name: context.type, size: context.decimals) ?? UIFont.systemFont(ofSize: context.decimals, weight: .semibold), range: NSRange(location: string.count-2, length: 2))
        return attributedString
    }
    
    /// It converts the account cell title String into the specific NSAttributedString
    ///
    /// - Parameter string: title string
    private func convertAccountCellTitleToAttributedString(string: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .medium), range: NSRange(location: 13, length: string.count - 13))
        return attributedString
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
            cell.amountLabel.attributedText = convertMoneyStringToAttributedString(string: "£1,720.21", context: .moneyCell)
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
                cell.titleLabel.attributedText = convertAccountCellTitleToAttributedString(string: "sync.Accounts (0)")
                cell.collectionView.accountType = .sync
                cell.pageControl.numberOfPages = syncAccounts.count + 1
            } else {
                cell.titleLabel.attributedText = convertAccountCellTitleToAttributedString(string: "Bank Accounts (0)")
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
        if let accountType = collectionView.accountType {
            cell.accountType = accountType
        }
        if case .sync = cell.accountType {
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
                cell.moneyLabel.attributedText = convertMoneyStringToAttributedString(string: "£" + String(syncAccounts[indexPath.row].money), context: .accountCell)
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
                cell.moneyLabel.attributedText = convertMoneyStringToAttributedString(string: "£" + String(bankAccounts[indexPath.row].money), context: .accountCell)
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
