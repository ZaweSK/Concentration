//
//  ViewController.swift
//  MyConcentration
//
//  Created by Peter on 23/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairs)


    @IBOutlet var cardButtons: [UIButton]!
    
    private var visibleCardButtons : [UIButton]!{
        return cardButtons?.filter{ !$0.superview!.isHidden }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    private var flipCount: Int = 0 {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        flipCountLabel.text = traitCollection.verticalSizeClass == .compact ? "Flips\n\(flipCount)" : "Flips: \(flipCount)"
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    var numberOfPairs: Int {
        return visibleCardButtons.count / 2
    }
    
    func updateViewFromModel(){
        for (index, button) in visibleCardButtons.enumerated() {
            let card = game.cards[index]
            if card.isFaceUp{
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(card), for: .normal)
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardColor
            }
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = visibleCardButtons.index(of: sender){
            game.chooseCard(atIndex: cardNumber)
            updateViewFromModel()
        }else{
            print("Choosen card not in card buttons")
        }
    }

    
    override func viewDidLoad() {
        if theme == nil {
            emojiChoices = ["👻","🎃","👿","🍬","🙀","💀","🦇","😱","🍎","⚰️","🍭"]
            cardColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            updateViewFromModel()
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.reset()
        emoji = [:]
        emojiChoices = theme!
        updateViewFromModel()
    }
    
    var emojiChoices = [String]()
    var emoji = [Card:String]()
    
    private func emoji(_ card: Card)->String{
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4_random)
        }
        return emoji[card] ?? "?"
    }
    
    var cardColor: UIColor?
    
    var theme: [String]? {
        didSet{
            emojiChoices = theme ?? []
            emoji = [:]
            updateViewFromModel()
        }
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


