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
        self.navigationController!.navigationBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newGamePressed(sender: UIButton) {
        var gameViewController = GameViewController(nibName:"GameViewController", bundle: nil)
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }

}

