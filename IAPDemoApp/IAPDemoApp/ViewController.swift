//
//  ViewController.swift
//  IAPDemoApp
//
//  Created by LEMIN DAHOVICH on 05.03.2023.
//

import UIKit
import Combine
import StoreKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let storeKit = StoreKitStorage()
    var bag = Set<AnyCancellable>()
    var count = 0
    var storeProducts: [Product] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        storeKit.$storeProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] prd in
                self?.count = prd.count
                self?.storeProducts = prd
            self?.tableView.reloadData()
        }
        .store(in: &bag)


    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenericCell", for: indexPath) as! UITableViewCell
        let product = storeProducts[indexPath.row]

        cell.textLabel?.text = product.description
        cell.detailTextLabel?.text = "\(product.price)"
        
        return cell
    }
}

