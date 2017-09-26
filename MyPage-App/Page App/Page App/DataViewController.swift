//
//  DataViewController.swift
//  Page App
//
//  Created by Shimon on 9/25/17.
//  Copyright © 2017 dotrothschild. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!    
    @IBOutlet weak var imageView: UIImageView!
    
    var dataObject: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = ModelController.getCurrentImageDescription() // original dataObject
        self.imageView.image = UIImage(named: dataObject)
    }


}

