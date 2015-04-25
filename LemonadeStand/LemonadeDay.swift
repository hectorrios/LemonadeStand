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
        
    func resetDay() {
        lemons = lemonStartValue
        iceCubes = iceCubeStartValue;
        budget = budgetStartValue
    }
    
    func generateMixRatio() -> Double {
        //Lemons over ice cubes
        return Double(self.lemonsMixNumber) / Double(self.iceCubeMixNumber)
    }
}
