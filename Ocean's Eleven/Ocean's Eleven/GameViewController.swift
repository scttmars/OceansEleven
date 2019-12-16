//
//  GameViewController.swift
//  Ocean's Eleven
//
//  Created by Scott Marsden on 4/30/19.
//  Copyright © 2019 Scott Marsden. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var p1DisplayIndex = 0;
    var p2DisplayIndex = 0;
    var twoPlayerGame = true
   
    var p1Deck = setGame.init()
    var p2Deck = setGame.init()
    
    @IBOutlet weak var gameOverLabel: UILabel!
    
    @IBOutlet weak var p1Leading: UILabel!
    @IBOutlet weak var p2Leading: UILabel!
    
    @IBOutlet weak var p1Display: UIImageView!
    @IBOutlet weak var p2Display: UIImageView!
    
    @IBOutlet var p1DiamondLabel: [UILabel]!
    @IBOutlet var p1HeartsLabel: [UILabel]!
    @IBOutlet var p1ClubsLabel: [UILabel]!
    @IBOutlet var p1SpadesLabel: [UILabel]!
    
    
    @IBOutlet var p2DiamondsLabel: [UILabel]!
    @IBOutlet var p2HeartsLabel: [UILabel]!
    @IBOutlet var p2ClubsLabel: [UILabel]!
    @IBOutlet var p2SpadesLabel: [UILabel]!
    
    
    @IBOutlet weak var p1AddButton: UIButton!
    @IBOutlet weak var p1ConcedeButton: UIButton!
    @IBOutlet weak var p2AddButton: UIButton!
    @IBOutlet weak var p2ConcedeButton: UIButton!
    
    @IBOutlet weak var roundCount: UILabel!
    
    @IBOutlet weak var cardsRemainingP1: UILabel!
    @IBOutlet weak var cardsRemaingP2: UILabel!
    
    //Move these variables to other code
    var p1RoundsWon = 0
    var p2RoundsWon = 0
    //Get this from options screen
    var roundToWin: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adds borders to the tables
        for label in p1ClubsLabel {
            label.layer.borderColor = (UIColor.black).cgColor
            label.layer.borderWidth = 1
        }
        for label in p1DiamondLabel {
            label.layer.borderColor = (UIColor.black).cgColor
            label.layer.borderWidth = 1
        }
        for label in p1HeartsLabel {
            label.layer.borderColor = (UIColor.black).cgColor
            label.layer.borderWidth = 1
        }
        for label in p1SpadesLabel {
            label.layer.borderColor = (UIColor.black).cgColor
            label.layer.borderWidth = 1
        }
        
        for label in p2ClubsLabel {
            label.layer.borderColor = (UIColor.black).cgColor
            label.layer.borderWidth = 1
        }
        for label in p2DiamondsLabel {
            label.layer.borderColor = (UIColor.black).cgColor
            label.layer.borderWidth = 1
        }
        for label in p2HeartsLabel {
            label.layer.borderColor = (UIColor.black).cgColor
            label.layer.borderWidth = 1
        }
        for label in p2SpadesLabel {
            label.layer.borderColor = (UIColor.black).cgColor
            label.layer.borderWidth = 1
        }
        
        //Checks to run AI
        if !twoPlayerGame {
            p2AddButton.isHidden = true
            p2ConcedeButton.isHidden = true
        }
        addCardP1()
        addCardP2()
        if !twoPlayerGame && p1Deck.isP1Leading(p1Hand: p1Deck.hand, p2Hand: p2Deck.hand) {
            while p1Deck.isP1Leading(p1Hand: p1Deck.hand, p2Hand: p2Deck.hand) {
                addCardP2()
            }
        }
        
        
        //Add one card to start for each player
        
    }
    
    @IBAction func addCardP1(_ sender: UIButton) {
        
        addCardP1()
    }
    
    
    @IBAction func addCardP2(_ sender: UIButton) {
        
        addCardP2()
        
    }
    
    
    @IBAction func p1Concede(_ sender: UIButton) {
        //Move code outside of this program
        p2Deck.roundWon()
        roundCount.text = String(p1Deck.roundsWon) + " - " + String(p2Deck.roundsWon)
        resetBoard()
        addCardP2()
        addCardP1()
        if !twoPlayerGame && p1Deck.isP1Leading(p1Hand: p1Deck.hand, p2Hand: p2Deck.hand) {
            while p1Deck.isP1Leading(p1Hand: p1Deck.hand, p2Hand: p2Deck.hand) {
                addCardP2()
                if Int.random(in: 1...10) == 10 {
                    p2Concede()
                    break
                }
            }
        }
        
        if p2Deck.gameOver(roundsToWin: roundToWin) || p1Deck.deck.count == 0 {
            p1AddButton.isHidden = true
            p1ConcedeButton.isHidden = true
            p2AddButton.isHidden = true
            p2ConcedeButton.isHidden = true
            gameOverLabel.isHidden = false
        }
        
    }
    @IBAction func p2Concede(_ sender: UIButton) {
        //Move code outside of this program
        p1Deck.roundWon()
        roundCount.text = String(p1Deck.roundsWon) + " - " + String(p2Deck.roundsWon)
        resetBoard()
        addCardP2()
        addCardP1()
        //Move to seperate code
        if p1Deck.gameOver(roundsToWin: roundToWin) || p2Deck.deck.count == 0 {
            p1AddButton.isHidden = true
            p1ConcedeButton.isHidden = true
            p2AddButton.isHidden = true
            p2ConcedeButton.isHidden = true
            gameOverLabel.isHidden = false
        }
    }
    //updates display to add a card to p1
    func addCardP1(){
        if !p1Deck.deck.isEmpty {
            
        
        let card = p1Deck.getLastCard()
        p1Display.image = UIImage(named: card.appearance)
        p1Display.backgroundColor = .white
        print(card.appearance)
        if card.suit == .spades{
            p1SpadesLabel[card.number - 1].text = "X"
            if card.number == 10 {
                p1SpadesLabel[card.number - 1].text = " X"
            }
        }
        if card.suit == .hearts{
            p1HeartsLabel[card.number - 1].text = "X"
            if card.number == 10 {
                p1HeartsLabel[card.number - 1].text = " X"
            }
        }
        if card.suit == .clubs{
            p1ClubsLabel[card.number - 1].text = "X"
            if card.number == 10 {
                p1ClubsLabel[card.number - 1].text = " X"
            }
        }
        if card.suit == .diamonds{
            p1DiamondLabel[card.number - 1].text = "X"
            if card.number == 10 {
                p1DiamondLabel[card.number - 1].text = " X"
            }
            
        }
        p1Deck.removeFromDeck()
        cardsRemainingP1.text = "Cards Remaining: " + String(p1Deck.deck.count)
        
        p1DisplayIndex = p1DisplayIndex + 1
        if p1Deck.deck.count == 0 {
            p1AddButton.isHidden = true
        }
        
        if !twoPlayerGame && p1Deck.isP1Leading(p1Hand: p1Deck.hand, p2Hand: p2Deck.hand) {
            while p1Deck.isP1Leading(p1Hand: p1Deck.hand, p2Hand: p2Deck.hand) {
                addCardP2()
            }
        }
        
        }//checkLead()
    }
    //updates display to add a card to p2
    func addCardP2(){
        if !p1Deck.deck.isEmpty {
        let card = p2Deck.getLastCard()
        
        p2Display.image = UIImage(named: card.appearance)
        p2Display.backgroundColor = .white
        if card.suit == .spades{
            p2SpadesLabel[card.number - 1].text = "X"
            if card.number == 10 {
                p2SpadesLabel[card.number - 1].text = " X"
            }
        }
        if card.suit == .hearts{
            p2HeartsLabel[card.number - 1].text = "X"
            if card.number == 10 {
                p2HeartsLabel[card.number - 1].text = " X"
            }
        }
        if card.suit == .clubs{
            p2ClubsLabel[card.number - 1].text = "X"
            if card.number == 10 {
                p2ClubsLabel[card.number - 1].text = " X"
            }
        }
        if card.suit == .diamonds{
            p2DiamondsLabel[card.number - 1].text = "X"
            if card.number == 10 {
                p2DiamondsLabel[card.number - 1].text = " X"
            }
            
        }
        p2Deck.removeFromDeck()
        cardsRemaingP2.text = "Cards Remaining: " + String(p2Deck.deck.count)
        
        p2DisplayIndex = p2DisplayIndex + 1
        if p2Deck.deck.count == 0 {
            p2AddButton.isHidden = true
        }
        }//checkLead()
    }
    
    //Checks who is leading and displays it to the player
    func checkLead(){
        if p1Deck.isP1Leading(p1Hand: p1Deck.hand, p2Hand: p2Deck.hand){
            p1Leading.text = "Player 1 is leading"
            p2Leading.text = "Player 2"
        }
        else{
            p2Leading.text = "Player 2 is leading"
            p1Leading.text = "Player 1"
        }
    }
    
    //Updates score when p2 concedes
    func p2Concede(){
        
        p1Deck.roundWon()
        roundCount.text = String(p1Deck.roundsWon) + " - " + String(p2Deck.roundsWon)
        resetBoard()
        addCardP2()
        addCardP1()
        if !twoPlayerGame && p1Deck.isP1Leading(p1Hand: p1Deck.hand, p2Hand: p2Deck.hand) {
            while p1Deck.isP1Leading(p1Hand: p1Deck.hand, p2Hand: p2Deck.hand) {
                addCardP2()
            }
        }
        //Move to seperate code
        if p1Deck.gameOver(roundsToWin: roundToWin) || p2Deck.deck.count == 0 {
            p1AddButton.isHidden = true
            p1ConcedeButton.isHidden = true
            p2AddButton.isHidden = true
            p2ConcedeButton.isHidden = true
            gameOverLabel.isHidden = false
        }
    }
    
    @IBAction func quitGame(_ sender: UIButton) {
        
    }
    
    //Resets display between rounds for card table
    func resetBoard() {
        
        for label in p1ClubsLabel{
            label.text = "0"
            if p1ClubsLabel[9] == label {
                label.text = " 0"
            }
            
        }
        for label in p1HeartsLabel{
            label.text = "0"
            if p1HeartsLabel[9] == label {
                label.text = " 0"
            }
            
        }
        for label in p1SpadesLabel{
            label.text = "0"
            if p1SpadesLabel[9] == label {
                label.text = " 0"
            }
            
        }
        for label in p1DiamondLabel{
            label.text = "0"
            if p1DiamondLabel[9] == label {
                label.text = " 0"
            }
            
        }
        
        for label in p2ClubsLabel{
            label.text = "0"
            if p2ClubsLabel[9] == label {
                label.text = " 0"
            }
            
        }
        for label in p2HeartsLabel{
            label.text = "0"
            if p2HeartsLabel[9] == label {
                label.text = " 0"
            }
            
        }
        for label in p2SpadesLabel{
            label.text = "0"
            if p2SpadesLabel[9] == label {
                label.text = " 0"
            }
            
        }
        for label in p2DiamondsLabel{
            label.text = "0"
            if p2DiamondsLabel[9] == label {
                label.text = " 0"
            }
            
        }
        
        p1Leading.text = "Player 1"
        p2Leading.text = "Player 2"
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
