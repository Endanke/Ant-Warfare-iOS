//
//  ViewController.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 09. 29..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newGamePressed(sender: UIButton) {
        Head.shared().gameViewController = GameViewController(nibName:"GameViewController", bundle: nil)
        self.navigationController?.pushViewController(Head.shared().gameViewController!, animated: true)
    }

    @IBAction func settingsPressed(sender: UIButton) {
        Head.shared().settingsViewController = SettingsViewController(nibName:"SettingsViewController", bundle: nil)
        self.navigationController?.pushViewController(Head.shared().settingsViewController!, animated: true)
    }
}

