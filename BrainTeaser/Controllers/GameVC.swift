//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Jan Göbel on 12/06/16.
//  Copyright © 2016 Jan Goebel. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var successIndicatorImageView: UIImageView!
    
    var currentCard: Card!
    var previousCard: Card!
    var timer: NSTimer!
    var startDate: NSDate!
    
    let gameTime = 60.0 //game time in seconds
    var correctCards = 0
    var wrongCards = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        previousCard = currentCard
        self.view.addSubview(currentCard)
    }
    
    @IBAction func yesPressed(sender: CustomButton) {
        if sender.titleLabel?.text == "YES" {
            checkAnswer(true)
        }
        else {
            startTimer()
            titleLabel.text = "Does this card match the previous?"
        }
        showNextCard()
    }
    
    @IBAction func noPressed(sender: CustomButton) {
        checkAnswer(false)
        showNextCard()
    }
    func checkAnswer(guess: Bool) -> Bool {
        let isSame = currentCard.currentShape == previousCard.currentShape
        if guess == isSame {
            correctCards += 1
            indicateCorrectGuess()
        }
        else {
            wrongCards += 1
            indicateWrongGuess()
        }
        return guess == isSame
    }
    func showNextCard() {
        successIndicatorImageView.alpha = 1.0
        if let current = currentCard {
            let cardToRemove = current
            previousCard = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation!, finished: Bool) in
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib() {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noBtn.hidden {
                noBtn.hidden = false
                yesBtn.setTitle("YES", forState: .Normal)
            }
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished: Bool) in
                
            })
            
        }
    }
    func createCardFromNib() -> Card? {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil).first as? Card
    }
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(GameVC.updateTimer), userInfo: nil, repeats: true)
        startDate = NSDate()
    }
    func stopTimer() {
        timer.invalidate()
    }
    func updateTimer() {
        let currentDate = NSDate()
        let timeDifference = currentDate.timeIntervalSinceDate(startDate)
        
        let timeLeft = gameTime - timeDifference
        
        if timeLeft <= 0 {
            stopTimer()
            countdownLabel.text = "1:00"
            yesBtn.setTitle("START", forState: .Normal)
            noBtn.hidden = true
            performSegueWithIdentifier("showScore", sender: self)
        }
        else {
            //update the time label. Truncate the Double by converting it to an Int
            let minutesLeft = Int(timeLeft / 60.0)
            let secondsLeft = Int(timeLeft) % 60
            countdownLabel.text = "\(minutesLeft):\(secondsLeft)"
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let scoreVC = segue.destinationViewController as? ScoreVC {
            scoreVC.correctCards = correctCards
            scoreVC.wrongCards = wrongCards
        }
    }
    func indicateCorrectGuess() {
        
        successIndicatorImageView.image = UIImage(named: "checkmark")
        AnimationEngine.popAnimation(successIndicatorImageView)        
    }
    func indicateWrongGuess() {
        successIndicatorImageView.image = UIImage(named: "wrong")
        AnimationEngine.popAnimation(successIndicatorImageView)
    }
    
}
