//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Hector Rios on 21/04/15.
//  Copyright (c) 2015 Hector Rios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var haveMoneyLabel: UILabel!
    
    @IBOutlet weak var haveNumerOfLeminsLabel: UILabel!
    
    @IBOutlet weak var haveNumberOfIceCubesLabel: UILabel!
    
    
    @IBOutlet weak var purchasedLemonsLabel: UILabel!
    
    
    @IBOutlet weak var purchaseIceCubesLabel: UILabel!
    
    
    @IBOutlet weak var lemonsMixLabel: UILabel!
    
    
    @IBOutlet weak var iceCubesMixLabel: UILabel!
    
    var lemonadeStand = LemonadeDay()
    var lemonsPurchasedNumber = 0
    var haveMoneyAmount = 10
    let LemonPrice = 2
    let IceCubePrice = 1
    
    // MARK: Lifecycle functins
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.purchasedLemonsLabel.text = "\(self.lemonsPurchasedNumber)"
        self.purchasedLemonsLabel.text = "\(lemonadeStand.lemons - 1)"
        self.haveNumerOfLeminsLabel.text = "\(lemonadeStand.lemons)"
        self.haveMoneyLabel.text = "\(haveMoneyAmount)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: IBActions
    
    
    @IBAction func purchaseLemonAddButtonPressed(sender: UIButton) {
        println("The purchase button was pressed")
        
        //Determine if we have enough money?
        if (self.canBuyIngredient(lemonadeStand.budget, amoutOfIngredient: LemonPrice)) {
            ++lemonadeStand.lemons
            lemonadeStand.budget -= LemonPrice
            self.updateLemonadeStandLabels(lemonadeStand)
        }
        
    }
    
    
    @IBAction func purchaseLemonDeleteButtonPressed(sender: UIButton) {
        
        if (lemonadeStand.lemons > 1) {
            --lemonadeStand.lemons
            lemonadeStand.budget += LemonPrice
            self.updateLemonadeStandLabels(lemonadeStand)
        }
        
    }

    
    @IBAction func purchaseIceCubeAddButtonPressed(sender: UIButton) {
        //Determine if we have enough money
        if (self.canBuyIngredient(lemonadeStand.budget, amoutOfIngredient: 1)) {
            lemonadeStand.iceCubes++
            lemonadeStand.budget -= IceCubePrice
            self.updateLemonadeStandLabels(lemonadeStand)
        }
    }
    
    
    @IBAction func purchaseIceCubeDeleteButtonPressed(sender: UIButton) {
        if (lemonadeStand.iceCubes > 1) {
            --lemonadeStand.iceCubes
            lemonadeStand.budget += IceCubePrice
            self.updateLemonadeStandLabels(lemonadeStand)
        }
    }
    
    
    @IBAction func mixLemonsAddButtonPressed(sender: UIButton) {
        //Add  new Lemon to the Mix. Make sure that you can add 
        //lemons that don't exceed the amount of lemons we have available
        if (lemonadeStand.lemons > 0) {
            ++lemonadeStand.lemonsMixNumber
            --lemonadeStand.lemons
            self.updateLemonadeStandLabels(lemonadeStand)
        }
    }
    
    
    @IBAction func mixLemonsDeleteButtonPressed(sender: UIButton) {
        if (lemonadeStand.lemonsMixNumber - 1 >= 0) {
            --lemonadeStand.lemonsMixNumber
            ++lemonadeStand.lemons
            self.updateLemonadeStandLabels(lemonadeStand)
        }
    }
    
    
    @IBAction func mixIceCubesAddButtonPressed(sender: UIButton) {
        if (lemonadeStand.iceCubes > 0) {
            ++lemonadeStand.iceCubeMixNumber
            --lemonadeStand.iceCubes
            self.updateLemonadeStandLabels(lemonadeStand)
        }
    }
    
    
    @IBAction func mixIceCubesDeleteButtonPressed(sender: UIButton) {
        if (lemonadeStand.iceCubeMixNumber - 1 >= 0) {
            --lemonadeStand.iceCubeMixNumber
            ++lemonadeStand.iceCubes
            self.updateLemonadeStandLabels(lemonadeStand)
        }
    }

    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        
        let mixRatio = lemonadeStand.generateMixRatio()
        println("The mix ratio is \(mixRatio)")
        
        //randon number of customers
        let numCustomers = Int(arc4random_uniform(UInt32(10)))
        
        var customers:[Double] = []
        
        for var i = 0; i < numCustomers; i++ {
            
        }
        
    }
    
    
    // MARK: -- helper methods
    
    func canBuyIngredient(budgetRemaining:Int, amoutOfIngredient:Int) -> Bool {
        return ((budgetRemaining - amoutOfIngredient) >= 0)
    }
    
    func updateLemonadeStandLabels(stand: LemonadeDay) {
        
        //Do the Lemon labels
        self.haveNumerOfLeminsLabel.text = "\(stand.lemons)"
        self.purchasedLemonsLabel.text = "\(stand.lemons - 1)"
        
        //Do the ice cube labels
        self.haveNumberOfIceCubesLabel.text = "\(lemonadeStand.iceCubes)"
        self.purchaseIceCubesLabel.text = "\(stand.iceCubes)"
        
        
        //lemons and icecubes mix number labels
        self.lemonsMixLabel.text = "\(stand.lemonsMixNumber)"
        self.iceCubesMixLabel.text = "\(stand.iceCubeMixNumber)"
        
        self.haveMoneyLabel.text = "\(stand.budget)"
    }
    
}

