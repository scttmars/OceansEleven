//
//  ViewController.swift
//  Ocean's Eleven
//
//  Created by Scott Marsden on 4/29/19.
//  Copyright © 2019 Scott Marsden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func goToRules(_ sender: UIButton) {
        performSegue(withIdentifier: "settingsSegue", sender: self)
    }
}

