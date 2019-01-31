//
//  Concentration.swift
//  MyConcentration
//
//  Created by Peter on 23/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import Foundation

struct Concentration{
    
    var cards = [Card]()
    
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter{cards[$0].isFaceUp == true }.oneAndOnly
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    // nefunguje vyberanie kariet

    mutating func chooseCard(atIndex index: Int){
        if index == indexOfOneAndOnlyFaceUpCard {
            cards[index].isFaceUp = false
            return
        }
        
        if !cards[index].isMatched{
            if let alreadyFlippedCardIndex = indexOfOneAndOnlyFaceUpCard, alreadyFlippedCardIndex != index{
                if cards[alreadyFlippedCardIndex] == cards[index]{
                    cards[alreadyFlippedCardIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else{
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
    mutating func reset(){
        cards = cards.map{
            var mutableCard = $0
            mutableCard.isFaceUp = false
            mutableCard.isMatched = false
            return mutableCard
        }
    }
}

extension Array{
    var oneAndOnly: Element?{
        return self.count == 1 ? self.first : nil
    }
}
