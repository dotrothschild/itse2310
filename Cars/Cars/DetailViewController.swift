//
//  DetailViewController.swift
//  Cars
//
//  Created by Shimon on 9/19/17.
//  Copyright © 2017 dotrothschild. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var style: UILabel!
    @IBOutlet weak var mpg: UILabel!
    @IBOutlet weak var accel: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var price: UILabel!
    fileprivate var timer: Timer!
    // Property for selected car
    var carIndex: Int? {
        didSet {
            self.configureView() // Update the view.
        }
    }
    func configureView() {
        // Update the user interface for the detail item.
        // Update the detail section for the car selected.
        if let index = self.carIndex {
            // Extract the selected car record
            var car = cars[index]
            // Make sure our outlets have been established before attempting to access them
            if name != nil {
                // Stop Timer since we're leaving the initial detail
                if self.photo.isAnimating {
                    self.photo.stopAnimating()
                    timer.invalidate()
                    timer = nil
                }
                name.text = car["name"] as! String!
                style.text = car["type"] as! String!
                mpg.text = car["mpg"] as! String!
                accel.text = car["accel"] as! String!
                speed.text = car["speed"] as! String!
                price.text = NumberFormatter.localizedString(from: car["price"]! as! NSNumber,
                                                             number: .currencyAccounting)
                // Check if Photo should be loaded from Bundle or DocumentsDirectory
                let file = car["photo"] as! String!
                photo.image = UIImage(named: file!)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Insert Animated GIF for Wrecker image
        let animations = [UIImage(named: "wrecker1.png")!, UIImage(named: "wrecker2.png")!,
                          UIImage(named: "wrecker3.png")!, UIImage(named: "wrecker4.png")!, UIImage(named:
                            "wrecker5.png")!, UIImage(named: "wrecker6.png")!]
        self.photo.animationImages = animations
        self.photo.animationDuration = 0.3
        self.photo.animationRepeatCount = 2
        self.photo.startAnimating()
        // Animation Loop Timer
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(DetailViewController.loop), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    func loop() {
        self.photo.startAnimating()
    }

}

