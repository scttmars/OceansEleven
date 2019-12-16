//
//  OptionsViewController.swift
//  Ocean's Eleven
//
//  Created by Scott Marsden on 4/30/19.
//  Copyright © 2019 Scott Marsden. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    var roundsToWin = 3
    @IBOutlet weak var numberOfPlayers: UISegmentedControl!
    
    @IBOutlet weak var roundCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func roundStepper(_ sender: UIStepper) {
        roundCount.text = String(Int(sender.value))
        roundsToWin = Int(sender.value)
    }
    
    
    //passes values from settings to the game view controller 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameViewController
        {
            let vc = segue.destination as? GameViewController
            vc?.roundToWin = roundsToWin
            if numberOfPlayers.titleForSegment(at: numberOfPlayers.selectedSegmentIndex) == "2" {
                vc?.twoPlayerGame = true
            }
            else {
                vc?.twoPlayerGame = false
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
