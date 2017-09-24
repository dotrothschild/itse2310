//
//  ThirdViewController.swift
//  Tab App
//
//  Created by Shimon on 9/24/17.
//  Copyright © 2017 dotrothschild. All rights reserved.
//

import UIKit

class CatsViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (UIApplication.shared.delegate as! AppDelegate).startVideo(viewCtrl: self, name: "cats")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (UIApplication.shared.delegate as! AppDelegate).stopVideoNotivications(viewCtrl: self)
    }
}
