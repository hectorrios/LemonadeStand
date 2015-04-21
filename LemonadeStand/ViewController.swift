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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: IBActions
    
    
    @IBAction func purchaseLemonAddButtonPressed(sender: UIButton) {
    }
    
    
    @IBAction func purchaseLemonDeleteButtonPressed(sender: UIButton) {
    }

    
    @IBAction func purchaseIceCubeAddButtonPressed(sender: UIButton) {
    }
    
    
    @IBAction func purchaseIceCubeDeleteButtonPressed(sender: UIButton) {
    }
    
    
    @IBAction func mixLemonsAddButtonPressed(sender: UIButton) {
    }
    
    
    @IBAction func mixLemonsDeleteButtonPressed(sender: UIButton) {
    }
    
    
    @IBAction func mixIceCubesAddButtonPressed(sender: UIButton) {
    }
    
    
    @IBAction func mixIceCubesDeleteButtonPressed(sender: UIButton) {
    }

    
    @IBAction func startDayButtonPressed(sender: UIButton) {
    }
    
    
}

