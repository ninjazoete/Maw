//
//  MawInterpreter.swift
//  Maw
//
//  Created by Andrzej Spiess on 14/11/15.
//  Copyright © 2015 Andrzej Spiess. All rights reserved.
//

import Foundation

protocol Scanner {
    typealias ScanResult
    
    func scan() -> ScanResult
}

class MawInterpreter : Scanner {
    
    class MawTokenSequence : SequenceType {
        
        private let _input : String
        private var _pos : Int = 0
        
        init(input : String) {
            self._input = input.stringByReplacingOccurrencesOfString("\n", withString: "")
        }
        
        func generate() -> AnyGenerator<MawToken> {
            
            return anyGenerator { () -> MawToken? in
                
                guard
                    self._pos <= self._input.characters.count - 1
                    else {
                        return nil
                }
                
                var _charToScan = String(self._input[self._pos])
                
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
                        
                        if self._pos + 1 >= self._input.characters.count - 1 {
                            break
                        }
                        
                        
                        _charToScan = String(self._input[self._pos])
                    }
                    
                    return MawToken(type: .INTEGER, value: _potMultiDigit)
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
                
                fatalError("Token could not be generated. Not supported character on input : \(_charToScan)")
            }
        }
    }
    
    private let _input : String
    private let _gen : MawTokenSequence
    
    init(input : String) {
        self._input = input
        self._gen = MawTokenSequence(input: self._input)
    }
    
    private func valToken(token : MawToken, type : TokenType) -> Void {
        
        guard token.type == type else {
            fatalError("Token is not valid for supported expressions")
        }
    }
    
    private func expr() -> Int {
        /* Construct and assert addition and substract operations
        // Fetch once because generator will be empty after yielding all elements before for previous expression */
        let generatedTokens = Array(_gen)
        
        /* These expressions have failable initializers. If the operation token does not
        // correspond to the expression type it will fail to create thus giving us info what operation was really requested */
        let additionExpr = MawExpressionAddition(tokens: generatedTokens)
        let substractExpr = MawExpressionSubstraction(tokens: generatedTokens)
        
        if let additionExpr = additionExpr {
            return additionExpr.eval()
        }
        
        if let substractExpr = substractExpr {
            return substractExpr.eval()
        }
        
        fatalError("Expression was not recognized")
    }
    
    // MARK: Scanner
    func scan() -> Int {
        return expr()
    }
}