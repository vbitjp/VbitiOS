//
//  ViewController.swift
//  SwiftCountUp
//
//  Created by Shinichi Akimoto on 2017/10/27.
//  Copyright © 2017年 Shinichi Akimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var countLabel: UILabel!
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
  @IBAction func plus(_ sender: AnyObject) {
        count = count + 1
        countLabel.text = String(count)
    }
    @IBAction func minus(_ sender: AnyObject) {
        count = count - 1
        countLabel.text = String(count)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

