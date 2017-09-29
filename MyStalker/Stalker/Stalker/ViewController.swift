//
//  ViewController.swift
//  Stalker
//
//  Created by Shimon on 9/29/17.
//  Copyright © 2017 dotrothschild. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var flash: UIImageView!
    @IBOutlet weak var redball: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.flash.center = touches.first!.location(in: self.view)
        UIView.animate(withDuration: 1.5, animations: {
            self.redball.center = touches.first!.location(in: self.view)
        })
        flash.isHidden = false
        redball.isHidden = flash.isHidden        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        moveObjects(touch!)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        flash.isHidden = true
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        flash.isHidden = true
    }
    func moveObjects(_ touch: UITouch) {
        let centerPoint = touch.location(in: self.view)
        flash.center = centerPoint
        redball.center = centerPoint
        
    }
}

