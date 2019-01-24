//
//  ViewController.swift
//  MyConcentration
//
//  Created by Peter on 23/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairs)


    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    private var flipCount: Int = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    
    var numberOfPairs: Int {
        return cardButtons.count / 2
    }
    
    func updateViewFromModel(){
        for (index, button) in cardButtons.enumerated() {
            let card = game.cards[index]
            if card.isFaceUp{
                button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                button.setTitle(emoji(game.cards[index].identifier), for: .normal)
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(atIndex: cardNumber)
            updateViewFromModel()
        }else{
            print("Choosen card not in card buttons")
        }
    }
    
    override func viewDidLoad() {
        updateViewFromModel()
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.reset()
        emoji = [:]
        emojiChoices = resetEmojiChoices()
        updateViewFromModel()
    }
    
    private func resetEmojiChoices() -> [String]{
        return ["🦝","🐁","🦋","🦒", "🐕", "🐒", "🐖", "🦉", "🕷","🐬"]
    }
    
    lazy var emojiChoices =  resetEmojiChoices()
    var emoji = [Int:String]()
    
    private func emoji(_ cardIdentifier: Int)->String{
        if emoji[cardIdentifier] == nil, emojiChoices.count > 0 {
            emoji[cardIdentifier] = emojiChoices.remove(at: emojiChoices.count.arc4_random)
        }
        return emoji[cardIdentifier] ?? "?"
    }
}

extension Int{
    
    var arc4_random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(self)))
        }else{
            return 0
        }
    }
}


