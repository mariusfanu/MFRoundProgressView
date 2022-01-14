//
//  ViewController.swift
//  Round Progress View Demo
//
//  Created by Marius Fanu on 27/01/15.
//  Copyright (c) 2015 Marius Fanu. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var roundProgressView: MFRoundProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func valueChanged(_ sender: UISlider) {
        roundProgressView.percent = CGFloat(sender.value)
    }

}

