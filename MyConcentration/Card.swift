//
//  Card.swift
//  MyConcentration
//
//  Created by Peter on 23/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import Foundation

struct Card: Hashable  {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    static func ==(lhs : Card, rhs : Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var hashValue: Int {
        return identifier
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}


extension Card{
    //type properties and functions
    private static var identifierFactory = 0
    private static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
}
