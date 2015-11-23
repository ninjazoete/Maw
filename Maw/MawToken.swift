//
//  MawToken.swift
//  Maw
//
//  Created by Andrzej Spiess on 14/11/15.
//  Copyright © 2015 Andrzej Spiess. All rights reserved.
//

enum TokenType : String {
    case MINUS = "-"
    case PLUS = "+"
    case NUMBER
    case EOE
}

class MawToken {
    
    let type : TokenType
    let value : String
    
    init(type : TokenType, value : String) {
        self.type = type
        self.value = value
    }
}

extension MawToken : CustomStringConvertible {
    
    var description: String {
        return "MAWTOKEN(\(self.type), \(self.value))\n"
    }
    
}