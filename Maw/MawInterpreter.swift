//
//  MawInterpreter.swift
//  Maw
//
//  Created by Andrzej Spiess on 14/11/15.
//  Copyright © 2015 Andrzej Spiess. All rights reserved.
//

protocol Scanner {
    typealias ScanResult
    
    func scan() -> ScanResult
}

class MawInterpreter : Scanner {
    
    private let _input : String
    private let _gen : MawLexer
    
    init(input : String) {
        self._input = input
        self._gen = MawLexer(input: self._input)
    }
    
    private func valToken(token : MawToken, type : TokenType) -> Void {
        
        guard token.type == type else {
            fatalError("Token type for given lexeme could not be generated.")
        }
    }
    
    private func expr() -> Int {
        /* Construct and assert addition and substract operations
        // Fetch once because generator will be empty after yielding all elements before for previous expression */
        let generatedTokens = Array(_gen)

        // Print generated tokens for debug.
        print(generatedTokens)
        
        /* These expressions have failable initializers. If the operation token does not
        // correspond to the expression type it will fail to create thus giving us info what operation was really requested */
        let algebraicExpr = MawExpressionAlgebraicDecimal(tokens: generatedTokens)
        
        if let algebraic = algebraicExpr {
            return algebraic.eval()
        }
        
        fatalError("Expression was not recognized.")
    }
    
    // MARK: Scanner
    func scan() -> Int {
        return expr()
    }
}