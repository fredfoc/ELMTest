//
//  ViewController.swift
//  ELMTest
//
//  Created by admin on 05/04/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
}
extension CounterViewController: CounterComponentView {
    
}

