//
//  ViewController.swift
//  CustomUiLabel
//
//  Created by Neelam Verma on 6/29/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var attLabel: CustomLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.attLabel.attach()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

