//
//  MawLexer.swift
//  Maw
//
//  Created by Andrzej Spiess on 23/11/15.
//  Copyright © 2015 Andrzej Spiess. All rights reserved.
//

/* Types */
typealias Lexeme = String

import Foundation

class MawLexer : SequenceType {
    
    private let _input : String
    private var _pos : Int = 0
    
    init(input : String) {
        self._input = input
            .stringByReplacingOccurrencesOfString("\n", withString: "")
            .stringByReplacingOccurrencesOfString(" ", withString: "")
    }
    
    func generate() -> AnyGenerator<MawToken> {
        
        return anyGenerator { () -> MawToken? in
            
            guard
                self._pos <= self._input.characters.count - 1
                else {
                    return nil
            }
            
            var _charToScan = Lexeme(self._input[self._pos])
            
            /* If digit */
            if let _ = Int(_charToScan) {
                
                var _potMultiDigit = ""
                
                while true {
                    
                    guard
                        let _ = Int(_charToScan)
                        else {
                            break
                    }
                    
                    _potMultiDigit += _charToScan
                    self._pos += 1
                    
                    if self._pos >= self._input.characters.count {
                        break
                    }
                    
                    
                    _charToScan = Lexeme(self._input[self._pos])
                }
                
                return MawToken(type: .NUMBER, value: _potMultiDigit)
            }
            
            /* If op */
            if _charToScan == TokenType.PLUS.rawValue {
                self._pos += 1
                return MawToken(type: .PLUS, value: TokenType.PLUS.rawValue)
            }
            
            if _charToScan == TokenType.MINUS.rawValue {
                self._pos += 1
                return MawToken(type: .MINUS, value: TokenType.MINUS.rawValue)
            }
            
            if _charToScan == TokenType.MULTIPLY.rawValue {
                self._pos += 1
                return MawToken(type: .MULTIPLY, value: TokenType.MULTIPLY.rawValue)
            }
            
            if _charToScan == TokenType.DIVIDE.rawValue {
                self._pos += 1
                return MawToken(type: .DIVIDE, value: TokenType.DIVIDE.rawValue)
            }
            
            fatalError("Token could not be generated. Not supported character on input : \(_charToScan)")
        }
    }
}