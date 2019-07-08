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
        self.attLabel.attach(withColor: UIColor.black)

        // with dynamic height
//        let new = CustomLabel()

//        new.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(new)
//        new.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
//        new.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        new.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
//        new.numberOfLines = 0
        
        // with constant
        let new = CustomLabel(frame: CGRect(x: 20, y: 300, width: 300, height: 70))
        //new.numberOfLines = 0
        new.attributedText = NSAttributedString(string: "i am Neelam, I play here")
        let fullString = NSMutableAttributedString(attributedString: new.attributedText!)
        let image1Attachment = NSTextAttachment()
        let img = UIColor.red.image(CGSize(width: 10, height: 10))
        image1Attachment.bounds = CGRect(x: 60.0, y: 0, width: 10, height: 10)
        image1Attachment.image = img
        let str = NSAttributedString(attachment: image1Attachment)
        fullString.append(str)
        new.attributedText = fullString
        self.view.addSubview(new)
        // Do any additional setup after loading the view, typically from a nib.
    }

}

