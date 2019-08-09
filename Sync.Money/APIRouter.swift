//
//  APIRouter.swift
//  Sync.Money
//
//  Created by Pablo Rodriguez on 09/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import Foundation

final class APIRouter {
    
    func loadSyncAccounts() -> [SyncAccount] {
        var syncAccounts: [SyncAccount] = []
        if let path = Bundle.main.path(forResource: "SyncAccounts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                syncAccounts = try JSONDecoder().decode([SyncAccount].self, from: data)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        return syncAccounts
    }
    
    func loadBankAccounts() -> [BankAccount] {
        var bankAccounts: [BankAccount] = []
        if let path = Bundle.main.path(forResource: "BankAccounts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                bankAccounts = try JSONDecoder().decode([BankAccount].self, from: data)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        return bankAccounts
    }
}
