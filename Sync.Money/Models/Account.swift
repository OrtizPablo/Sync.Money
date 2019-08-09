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
    var accountNumber: String { get }
    var sortCode: String { get }
    var money: Double { get }
}

struct SyncAccount: Account {
    
    let image: UIImage
    let currency: String
    let accountName: String
    let accountNumber: String
    let sortCode: String
    let money: Double
    
    init(imageName: String, currency: String, accountName: String, accountNumber: String, sortCode: String, money: Double) {
        image = UIImage(named: imageName) ?? UIImage()
        self.currency = currency
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.sortCode = sortCode
        self.money = money
    }
}

extension SyncAccount: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case imageName
        case currency
        case accountName
        case accountNumber
        case sortCode
        case money
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imageName = try container.decode(String.self, forKey: .imageName)
        let currency = try container.decode(String.self, forKey: .currency)
        let accountName = try container.decode(String.self, forKey: .accountName)
        let accountNumber = try container.decode(String.self, forKey: .accountNumber)
        let sortCode = try container.decode(String.self, forKey: .sortCode)
        let money = try container.decode(Double.self, forKey: .money)
        self.init(imageName: imageName, currency: currency, accountName: accountName, accountNumber: accountNumber, sortCode: sortCode, money: money)
    }
}

struct BankAccount: Account {
    
    let image: UIImage
    let bankName: String
    let accountName: String
    let accountNumber: String
    let sortCode: String
    let money: Double
    
    init(imageName: String, bankName: String, accountName: String, accountNumber: String, sortCode: String, money: Double) {
        image = UIImage(named: imageName) ?? UIImage()
        self.bankName = bankName
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.sortCode = sortCode
        self.money = money
    }
}

extension BankAccount: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case imageName
        case bankName
        case accountName
        case accountNumber
        case sortCode
        case money
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imageName = try container.decode(String.self, forKey: .imageName)
        let bankName = try container.decode(String.self, forKey: .bankName)
        let accountName = try container.decode(String.self, forKey: .accountName)
        let accountNumber = try container.decode(String.self, forKey: .accountNumber)
        let sortCode = try container.decode(String.self, forKey: .sortCode)
        let money = try container.decode(Double.self, forKey: .money)
        self.init(imageName: imageName, bankName: bankName, accountName: accountName, accountNumber: accountNumber, sortCode: sortCode, money: money)
    }
}
