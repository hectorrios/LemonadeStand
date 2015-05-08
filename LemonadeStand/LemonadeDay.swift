//
//  LemonadeDay.swift
//  LemonadeStand
//
//  Created by Hector Rios on 21/04/15.
//  Copyright (c) 2015 Hector Rios. All rights reserved.
//

import Foundation

class LemonadeDay {
    
    let lemonStartValue = 0
    let iceCubeStartValue = 0
    let budgetStartValue = 10
    
    var lemons = 1
    var iceCubes = 1
    var budget = 10
    var lemonsMixNumber = 0
    var iceCubeMixNumber = 0
    var lemonsPurchased = 0
    var iceCubesPurchased = 0
        
    func resetDay() {
        lemons = lemonStartValue
        iceCubes = iceCubeStartValue;
        budget = budgetStartValue
    }
    
    func resetMixAndItemsPurchased() {
        self.lemonsPurchased = 0
        self.iceCubesPurchased = 0
        self.lemonsMixNumber = 0
        self.iceCubeMixNumber = 0
    }
    
    func generateMixRatio() -> Double {
        //Lemons over ice cubes
        return Double(self.lemonsMixNumber) / Double(self.iceCubeMixNumber)
    }
    
    // MARK: Lemon operations
    
    func purchaseLemon(amount:Int, price: Int) {
        self.lemons += amount
        self.lemonsPurchased += amount
        self.budget -= price
    }
    
    func unpurchaseLemon(amount: Int, price: Int) {
        self.lemons -= amount
        self.budget += price
        self.lemonsPurchased -= amount
    }
    
    func addLemonToMix(amount:Int) {
        self.lemonsMixNumber += amount
        self.lemons -= amount
    }
    
    func removeLemonFromMix(amount:Int) {
        self.lemonsMixNumber -= amount
        self.lemons += amount
    }
    
    // MARK: IceCube operations
    
    func purchaseIceCube(amount:Int, price:Int) {
        self.iceCubes += amount
        self.iceCubesPurchased += amount
        self.budget -= amount
    }
    
    func unPurchaseIceCube(amount:Int, price:Int) {
        self.iceCubes -= amount
        self.iceCubesPurchased -= amount
        self.budget += price
    }
    
    func addIceCubeToMix(amount:Int) {
        self.iceCubeMixNumber += amount
        self.iceCubes -= amount
    }
    
    func removeIceCubeFromMix(amount:Int) {
        self.iceCubeMixNumber -= amount
        self.iceCubes += amount
    }
    
}
