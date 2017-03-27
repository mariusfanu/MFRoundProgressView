//
//  ViewController.swift
//  Round Progress View Demo
//
//  Created by Marius Fanu on 27/01/15.
//  Copyright (c) 2015 Marius Fanu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var roundProgressView: MFRoundProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChanged(_ sender: UISlider) {
        roundProgressView.percent = CGFloat(sender.value)
    }

}

