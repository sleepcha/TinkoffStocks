//
//  BrokerUser.swift
//  TinkoffStocks
//
//  Created by Jacob Chase on 9/10/21.
//

import Foundation


class BrokerUser {
    private(set) var broker: Broker
    private(set) var accounts: [BrokerAccount]?
    
    init(token: String, isSandbox: Bool) {
        self.broker = Broker(token: token, isSandbox: isSandbox)
    }
    
    func getAccounts(completion: @escaping ResultHandler<Void>) {
        broker.getUserAccounts { [weak self] result in
            guard let self = self else { return }
            completion(result.map { userAccounts in
                self.accounts = userAccounts.accounts.map { BrokerAccount(account: $0, user: self) }
            })
        }
    }
}
