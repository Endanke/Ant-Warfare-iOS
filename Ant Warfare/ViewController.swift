//
//  ViewController.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 09. 29..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

let kClientID = "687435287561-j2u22v5lutbgr881tcq2b19ucjc155as.apps.googleusercontent.com";

class ViewController: UIViewController, GPGStatusDelegate, MPLobbyDelegate {
    
    var silentlySigningIn : Bool?
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.hidden = true
        GPGManager.sharedInstance().statusDelegate = self
        MPManager.sharedInstance().lobbyDelegate = self
        silentlySigningIn = GPGManager.sharedInstance().signInWithClientID(kClientID, silently: true)
        self.refreshInterfaceBasedOnSignIn()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        var gameViewController = GameViewController(nibName:"GameViewController", bundle: nil)
//        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newGamePressed(sender: UIButton) {
        // For now, just a quick two player match
        MPManager.sharedInstance().startQuickMatchGameWithTotalPlayers(2)
    }
    
    @IBAction func signInButtonPressed(sender: UIButton) {
        GPGManager.sharedInstance().signInWithClientID(kClientID, silently: false)
    }
    
    // MARK: Game delegate functions
    
    func multiPlayerGameWasCanceled() {
        if(self.presentedViewController != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func readyToStartMultiPlayerGame() {
        if(!self.navigationController!.viewControllers.last!.isEqual(self)){
            return;
        }
        var gameViewController = GameViewController(nibName:"GameViewController", bundle: nil)

        if(self.presentedViewController != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            self.navigationController?.pushViewController(gameViewController, animated: true)
        }else{
            self.navigationController?.pushViewController(gameViewController, animated: true)
            println("rightpresent")
        }
    }
 
    // MARK: Sign in functions
    
    func didFinishGamesSignInWithError(error: NSError!) {
        if (error != nil) {
            println(error.localizedDescription)
        } else {
            println("signed in!")
        }
        silentlySigningIn = false
        self.refreshInterfaceBasedOnSignIn()
    }
    
    func didFinishGamesSignOutWithError(error: NSError!) {
        if (error != nil) {
            println(error.localizedDescription)
        } else {
            println("signed out!")
        }
        silentlySigningIn = false
        self.refreshInterfaceBasedOnSignIn()
    }
    
    func refreshInterfaceBasedOnSignIn(){
        var signedInToGameServices = GPGManager.sharedInstance().signedIn
        signInButton.enabled = !silentlySigningIn!
        signInButton.enabled = !signedInToGameServices
    }
    
}

