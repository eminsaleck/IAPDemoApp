//
//  StoreKitStorage.swift
//  IAPDemoApp
//
//  Created by LEMIN DAHOVICH on 05.03.2023.
//

import Foundation
import StoreKit

final class StoreKitStorage {
    
    @Published var storeProducts: [Product] = []
    @Published var purchased: [Product] = []
    
    public let productDict: [String: String]
    
    init() {
        if let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
           let plist = FileManager.default.contents(atPath: plistPath) {
            productDict = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String: String]) ?? [:]
        } else {
            productDict = [:]
        }
        
        Task {
            await requestProducts()
        }
    }
    
    func requestProducts() async {
        do {
            storeProducts = try await Product.products(for: productDict.values)
        } catch {
            print("Failed - error retrieving \(error)")
        }
    }
}
