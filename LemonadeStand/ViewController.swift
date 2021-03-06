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
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var lemonadeStand = LemonadeDay()
    var lemonsPurchasedNumber = 0
    var haveMoneyAmount = 10
    let LemonPrice = 2
    let IceCubePrice = 1
    
    //Array of Tuples where each tuple has an image (UIImage) and a description of the weather (description)
    let weatherImages = [(image: UIImage(named: "Cold"), description: "cold") , (image: UIImage(named: "Mild"), description: "mild"), (image: UIImage(named: "Warm"), description: "warm")]
    
    // MARK: Lifecycle functins
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.purchasedLemonsLabel.text = "\(self.lemonsPurchasedNumber)"
        self.updateMainView(lemonadeStand)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: IBActions
    
    
    @IBAction func purchaseLemonAddButtonPressed(sender: UIButton) {
//        println("The purchase button was pressed")
        
        //Determine if we have enough money?
        if (self.canBuyIngredient(lemonadeStand.budget, amoutOfIngredient: LemonPrice)) {
            lemonadeStand.purchaseLemon(1, price: LemonPrice)
            self.updateMainView(lemonadeStand)
        } else {
            showAlertWithText(header: "Out of Budget", message: "No more money left to buy lemons")
        }
        
    }
    
    
    @IBAction func purchaseLemonDeleteButtonPressed(sender: UIButton) {
        
        if (lemonadeStand.lemonsPurchased > 0) {
            lemonadeStand.unpurchaseLemon(1, price: LemonPrice)
            self.updateMainView(lemonadeStand)
        } else {
            self.showAlertWithText(message: "You don't have anything to return")
        }
        
    }

    
    @IBAction func purchaseIceCubeAddButtonPressed(sender: UIButton) {
        //Determine if we have enough money
        if (self.canBuyIngredient(lemonadeStand.budget, amoutOfIngredient: 1)) {
            lemonadeStand.purchaseIceCube(1, price: IceCubePrice)
            self.updateMainView(lemonadeStand)
        } else {
            showAlertWithText(header: "Out of Budget", message: "No more money left to buy ice cubes")
        }
    }
    
    
    @IBAction func purchaseIceCubeDeleteButtonPressed(sender: UIButton) {
        if (lemonadeStand.iceCubesPurchased > 0) {
            lemonadeStand.unPurchaseIceCube(1, price: IceCubePrice)
            self.updateMainView(lemonadeStand)
        } else {
            self.showAlertWithText(message: "You don't have anything to return")
        }
    }
    
    
    @IBAction func mixLemonsAddButtonPressed(sender: UIButton) {
        //Add  new Lemon to the Mix. Make sure that you can add 
        //lemons that don't exceed the amount of lemons we have available
        if (lemonadeStand.lemons > 0) {
            lemonadeStand.lemonsPurchased = 0
            lemonadeStand.addLemonToMix(1)
            self.updateMainView(lemonadeStand)
        } else {
            showAlertWithText(message: "You don't have enough inventory")
        }
    }
    
    
    @IBAction func mixLemonsDeleteButtonPressed(sender: UIButton) {
        if (lemonadeStand.lemonsMixNumber > 0) {
            lemonadeStand.lemonsPurchased = 0
            lemonadeStand.removeLemonFromMix(1)
            self.updateMainView(lemonadeStand)
        } else {
            showAlertWithText(message: "You have nothing to un-mix")
        }
    }
    
    
    @IBAction func mixIceCubesAddButtonPressed(sender: UIButton) {
        if (lemonadeStand.iceCubes > 0) {
            lemonadeStand.addIceCubeToMix(1)
            lemonadeStand.iceCubesPurchased = 0
            self.updateMainView(lemonadeStand)
        } else {
            showAlertWithText(message: "You don't have enough inventory")
        }
    }
    
    
    @IBAction func mixIceCubesDeleteButtonPressed(sender: UIButton) {
        if (lemonadeStand.iceCubeMixNumber > 0) {
            lemonadeStand.removeIceCubeFromMix(1)
            lemonadeStand.iceCubesPurchased = 0
            self.updateMainView(lemonadeStand)
        } else {
            showAlertWithText(message: "You have nothing to un-mix")
        }
    }

    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        
        //fetch the random weather
        let weatherTuple = self.getWeatherImage()
        
        // set the weather image
        self.weatherImageView.image = weatherTuple.image
        
        //randon number of customers
        var numCustomers = Int(arc4random_uniform(UInt32(11)))
        println("Number of customers generated is: \(numCustomers)")
        
        numCustomers = self.recalculateCustomerNumByWeather(numCustomers, weather: weatherTuple.description)
        println("Number of recalculate customers is: \(numCustomers)")
        
        println("Number of customers generated is: \(numCustomers)")
        
        //check to see that Lemons and Icecubes have been added to the Mix for today
        if (lemonadeStand.lemonsMixNumber == 0 || lemonadeStand.iceCubeMixNumber == 0) {
            showAlertWithText(message: "You have to add some lemons and ice cubes to the Mix")
        } else {
            let mixRatio = lemonadeStand.generateMixRatio()
            println("The mix ratio is \(mixRatio)")
            
            
            for x in 0...numCustomers {
                let customerPreference = self.generateRandomCustomerPreference()
                
                if customerPreference < 0.4 && mixRatio > 1.0 {
                    //Get paid a dollar and print something out
                    lemonadeStand.budget += 1
                    println("Customer Preference \(customerPreference) for mix ratio \(mixRatio) Paid")
                } else if (customerPreference >= 0.4 && customerPreference <= 0.6 && mixRatio == 1) {
                    lemonadeStand.budget += 1
                    
                    println("Customer Preference \(customerPreference) for mix ratio \(mixRatio) Paid")
                } else if customerPreference > 0.6 && mixRatio < 1.0 {
                    lemonadeStand.budget += 1
                    println("Customer Preference \(customerPreference) for mix ratio \(mixRatio) Paid")
                } else {
                    println("Customer Preference \(customerPreference) for mix ratio \(mixRatio) Not Paid")
                }
                
                //            //compare tastePreference to range
                //            switch customerPreference {
                //            case 0...0.4:
                //                println("In first range")
                //            case 0.4...0.6:
                //                println("In second range")
                //            default:
                //                println("Everything above 0.6")
                //            }
                
                //compare mix ratio
                //            if mixRatio > 1 { //Acidic Lemonade
                //                println("Acidic Lemonade")
                //            } else if mixRatio == 1 { //Equal proportioned Lemonade
                //                println("Equal proportioned Lemonade")
                //            } else { //diluted lemomade
                //                println("Diluted Lemonade")
                //            }
                
                self.updateMainView(lemonadeStand)
                
            }
            
            //reset the lemonade mix values and items purchased
            lemonadeStand.resetMixAndItemsPurchased()
            
            self.updateMainView(lemonadeStand)
            
        }
        
        
    }
    
    
    // MARK: -- helper methods
    
    func canBuyIngredient(budgetRemaining:Int, amoutOfIngredient:Int) -> Bool {
        return ((budgetRemaining - amoutOfIngredient) >= 0)
    }
    
    func updateMainView(stand: LemonadeDay) {
        
        //Do the Lemon labels
        self.haveMoneyLabel.text = "$\(stand.budget)"
        self.haveNumerOfLeminsLabel.text = "\(stand.lemons) Lemon(s)"
        self.purchasedLemonsLabel.text = "\(stand.lemonsPurchased)"
        
        //Do the ice cube labels
        self.haveNumberOfIceCubesLabel.text = "\(lemonadeStand.iceCubes) IceCube(s)"
        self.purchaseIceCubesLabel.text = "\(stand.iceCubesPurchased)"
        
        
        //lemons and icecubes mix number labels
        self.lemonsMixLabel.text = "\(stand.lemonsMixNumber)"
        self.iceCubesMixLabel.text = "\(stand.iceCubeMixNumber)"
        
        //set the Weather Image View
        //self.weatherImageView.image = UIImage(named: "LemonadeStandImages/cold.png")
        
    }
    
    func generateRandomCustomerPreference() -> Double {
        
        return Double(arc4random_uniform(UInt32(101))) /  Double(100)
    }
    
    func showAlertWithText(header:String = "Warning",message:String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func getWeatherImage() -> (image: UIImage?, description: String) {
        //generate a random integer between 0 and the size of the weather images array
        let index = Int (arc4random_uniform(UInt32(weatherImages.count)))
        return self.weatherImages[index]
    }
    
    func recalculateCustomerNumByWeather(numCustomers:Int, weather:String) -> Int {
        
        var recalculatedCustomerNum: Int
        
        switch weather {
        case "warm":
            recalculatedCustomerNum = numCustomers + 4
        case "mild":
            recalculatedCustomerNum = numCustomers
        default:
            if (numCustomers < 3) {
                recalculatedCustomerNum = 0
            } else {
                recalculatedCustomerNum = numCustomers - 3
            }
        }
        
        return recalculatedCustomerNum
    }
    
}

