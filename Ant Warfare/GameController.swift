//
//  GameController.swift
//  Ant Warfare
//
//  Created by Daniel Eke on 2014. 10. 09..
//  Copyright (c) 2014. endanke. All rights reserved.
//

import UIKit

private let _singletonInstance = GameController()

class GameController: NSObject {
    var ants : [Ant] = []
    var enemyCount = 0
    var gameOver = false
    
    class var sharedInstance: GameController {
        return _singletonInstance
    }
    
    override init() {
        super.init()
    }
    
    func newGame(){
        ants.removeAll(keepCapacity: false)
        ants.append(Ant())
        ants.append(Ant())
        ants.append(Ant())
        gameOver = false
    }
    
    func update() {
        checkStatus()
        var i = 0
        enemyCount = 0
        for ant in ants{
            ant.step()
            if(ant.out){
                self.remoteUpdate()
                ant.view!.hidden = true
                self.ants.removeAtIndex(find(ants,ant)!)
            }
            if(!ant.enemy && ant.targetSize != 0){
                for other in ants{
                    if(other.enemy && !other.isEqual(ant) && other.targetSize != 0){
                        if(CGRectContainsPoint(ant.view!.frame, other.view!.center)){
                            antsToFight(ant, enemyAnt: other)
                        }
                    }
                }
            }
            if(ant.targetSize != 0){
                i++
                if(ant.enemy){
                    enemyCount++
                }
            }
        }
        if(i == enemyCount){
            println(ants)
            if(enemyCount > 0){
                MPManager.sharedInstance().sendGameOver()
                gameOver = true
            }
        }
    }
    
    func remoteUpdate(){
        MPManager.sharedInstance().sendOneAntAtY(100)
    }
    
    func antsToFight(myAnt : Ant, enemyAnt : Ant){
        println("contact");
        if(arc4random_uniform(2) == 1 || enemyAnt.strike == 1){
            enemyAnt.targetSize = 0.0
        }else{
            myAnt.targetSize = 0.0
            enemyAnt.strike++
        }
    }
    
    func checkStatus(){
        //if(enemyAnts.count == ants.count){
        // gameover
        //}
    }
    
    func send(to : CGPoint){
        for ant in ants{
            if(ant.randomStep != false){
                ant.randomStep = false
                ant.destination = to
                return;
            }
        }
    }
    
}