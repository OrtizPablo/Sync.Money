//
//  Account.swift
//  Sync.Money
//
//  Created by Pablo Rodriguez on 06/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import UIKit

protocol Account {
    var image: UIImage { get }
    var accountName: String { get }
    var accountNumber: Int { get }
    var sortCode: String { get }
    var money: Double { get }
}

struct SyncAccount: Account {
    
    let image: UIImage
    let currency: String
    let accountName: String
    let accountNumber: Int
    let sortCode: String
    let money: Double
    
    init(image: UIImage, currency: String, accountName: String, accountNumber: Int, sortCode: String, money: Double) {
        self.image = image
        self.currency = currency
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.sortCode = sortCode
        self.money = money
    }
}

struct BankAccount: Account {
    
    let image: UIImage
    let bankName: String
    let accountName: String
    let accountNumber: Int
    let sortCode: String
    let money: Double
    
    init(image: UIImage, bankName: String, accountName: String, accountNumber: Int, sortCode: String, money: Double) {
        self.image = image
        self.bankName = bankName
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.sortCode = sortCode
        self.money = money
    }
}
