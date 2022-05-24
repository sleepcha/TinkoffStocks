//
//  ViewController.swift
//  TinkoffStocks
//
//  Created by Jacob Chase on 21/05/21.
//

import UIKit
let forSandbox = "t.uaCWbPU4noTTOfw5_g943pasMFeJae1HkdVP1C7BXZLWgp2wKqFN5_yf7gyZT0ROfGqTfoQxNYJf0F3KyQs_qw"



class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var portfolioTableView: UITableView!
    
    var refreshControl: UIRefreshControl {
        if portfolioTableView.refreshControl == nil {
            portfolioTableView.refreshControl = UIRefreshControl()
            portfolioTableView.refreshControl!.addTarget(self, action: #selector(refreshCurrentPortfolio), for: .valueChanged)
        }
        return portfolioTableView.refreshControl!
    }
    
    var user = BrokerUser(token: forSandbox, isSandbox: true)
    
    var currentAccountId = 0 {
        didSet {
            if let accounts = user.accounts, currentAccountId < accounts.count {
                if currentAccountId != oldValue { updateUserInterface() }
            } else { currentAccountId = oldValue }
        }
    }
    
    var currentAccount: BrokerAccount? {
        if let accounts = user.accounts, currentAccountId < accounts.count { return accounts[currentAccountId] }
        else { return nil }
    }
    
    var currentPortfolio: [[PricedPosition]]? {
        return currentAccount?.portfolio
    }
    
    var gainPeriod: GainPeriod = .today
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.beginRefreshing()
        prepareAccounts()
        //user.broker.populateAccountWithPositions(amount: 10)
    }
    
    private func handleError(_ error: Error) {
        
    }
    
    private func prepareAccounts() {
        user.getAccounts { [weak self] result in
            switch result {
            case let .failure(error): print(error.localizedDescription)
            case .success:
                guard let accounts = self?.user.accounts, accounts.count > 0 else { return }

                for i in 0 ..< accounts.count {
                    accounts[i].updatePortfolio { result in
                        switch result {
                        case let .failure(error): self?.handleError(error)
                        case .success: if i == 0 { self?.updateUserInterface() }
                        }
                    }
                }
            } 
        }
    }
    
    @objc private func refreshCurrentPortfolio(sender: UIRefreshControl) {
        currentAccount?.updatePortfolio { [weak self] _ in self?.updateUserInterface() }
    }
    
    private func updateUserInterface() {
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing { self.refreshControl.endRefreshing() }
            self.collectionView.reloadData()
            self.portfolioTableView.reloadData()
            
        }
    }

    
    private func updateBalanceBlock() {
//        let totalBalanceUSD = MoneyAmount(currency: .USD, value: portfolio
//                                            .compactMap() { $0.getMarketValue?.toUSD?.value }
//                                            .reduce(0) { $0 + $1 }
//        )
//        let totalGainUSD = MoneyAmount(currency: .USD, value: portfolio
//                                        .compactMap() { $0.getGain(for: gainPeriod)?.toUSD?.value }
//                                        .reduce(0) { $0 + $1 }
//        )
        //balanceLabel.stringValue = totalBalanceUSD.formatted
        //gainLabel.attributedStringValue = NSAttributedString(string: totalGainUSD.value.signCharacter + " " + totalGainUSD.formatted, attributes: [.foregroundColor : totalGainUSD.value.signColor])
    }
    
        
    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        currentAccountId = pageControl.currentPage
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = user.accounts?.count ?? 0
        pageControl.numberOfPages = count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accountCell", for: indexPath) as! AccountCollectionViewCell
        cell.configure(with: "\((indexPath.row+1) * 8582) $", "21.04 $ (1.41 %)")
        //cell.accountNameLabel.asText = "\(inoutRUB+inoutUSD)"
        return cell
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.x / collectionView.frame.width)
        pageControl.currentPage = index
        currentAccountId = index
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}


extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        currentPortfolio?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentPortfolio?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let positionCell = tableView.dequeueReusableCell(withIdentifier: "PositionCell") as! PositionCell

        guard let portfolio = currentPortfolio, indexPath.row < portfolio[indexPath.section].count else { return UITableViewCell() }
        let position = portfolio[indexPath.section][indexPath.row]
        let color = (indexPath.row % 2 == 0) ? UIColor.secondarySystemBackground : UIColor.systemBackground
        positionCell.configure(with: position, gainPeriod, color)
           
        return positionCell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? UITableViewHeaderFooterView else { return }
        var content = view.defaultContentConfiguration()
        
        content.text = currentPortfolio?[section].first?.instrumentType.name
        content.textProperties.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        content.textProperties.color = UIColor.label
        view.contentConfiguration = content
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}
