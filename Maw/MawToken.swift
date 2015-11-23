//
//  MawToken.swift
//  Maw
//
//  Created by Andrzej Spiess on 14/11/15.
//  Copyright © 2015 Andrzej Spiess. All rights reserved.
//

protocol Number { }

extension Int : Number { }
extension Float : Number { }

enum TokenType : String {
    case MINUS = "-"
    case PLUS = "+"
    case MULTIPLY = "*"
    case DIVIDE = "/"
    case NUMBER
    case EOE
}

class MawToken {
    
    let type : TokenType
    let value : Lexeme
    
    init(type : TokenType, value : Lexeme) {
        self.type = type
        self.value = value
    }
}

extension MawToken : CustomStringConvertible {
    
    var description: String {
        return "MAWTOKEN(\(self.type), \(self.value))\n"
    }
    
}