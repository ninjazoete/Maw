//
//  MawExpression.swift
//  Maw
//
//  Created by Andrzej Spiess on 14/11/15.
//  Copyright © 2015 Andrzej Spiess. All rights reserved.
//

private protocol _MawExpression {
    func valExprTokens(tokens : [MawToken]) -> Bool
    func valExprTokensOpType(tokens : [MawToken]) -> Bool
    func valExprTokensOpPos(tokens : [MawToken]) -> Bool
}

protocol MawExpression {
    typealias ExprResultType
    
    func eval() -> ExprResultType
}

class MawExpressionBase<T> : _MawExpression, MawExpression {
    
    private let _tokens : [MawToken]
    
    init?(tokens : [MawToken]) {
        _tokens = tokens
        
        if !valExprTokens(_tokens) {
            return nil
        }
    }
    
    func eval() -> T {
        fatalError("Have to be overriden")
    }
    
    private func valExprTokens(tokens : [MawToken]) -> Bool {
        let validType = valExprTokensOpType(tokens)
        let validPos = valExprTokensOpPos(tokens)
        
        return validType && validPos
    }
    
    private func valExprTokensOpType(tokens: [MawToken]) -> Bool {
        fatalError("Have to be overriden")
    }
    
    private func valExprTokensOpPos(tokens: [MawToken]) -> Bool {
        fatalError("Have to be overriden")
    }
    
}

/* Expression that can evaluate algebraic operations with an output of Int type */
class MawExpressionAlgebraicDecimal : MawExpressionBase<Int> {
    
    override init?(tokens: [MawToken]) {
        super.init(tokens: tokens)
    }
    
    override func eval() -> Int {
        
        /* Supported operations for certain token types */
        /* Explicitly passed so we can customize it and support more exotic additions, subtractions and so on */
        return _tokens.chainOp(0, chain: { (token) -> (Int, Int) -> Int in

            if token.type == .PLUS {
                return (+)
            }
            
            if token.type == .MINUS {
                return (-)
            }
            
            if token.type == .MULTIPLY {
                return (*)
            }
            
            if token.type == .DIVIDE {
                return (/)
            }
            
            fatalError("Token type operation is not supported")
        })
    }
    
    private override func valExprTokensOpType(tokens : [MawToken]) -> Bool {
        /* Get all tokens that are no NUMBER */
        for op in tokens.filter({ $0.type != .NUMBER }) {
            
            /* We accept for algebraic expression only those types of op tokens */
            if op.type != .MINUS && op.type != .PLUS && op.type != .MULTIPLY && op.type != .DIVIDE {
                /* Sorry but this is not valid algebraic expression */
                return false
            }
        }
        
        return true
    }
    
    private override func valExprTokensOpPos(tokens : [MawToken]) -> Bool {
        
        /* Validate that on each odd place there is a op */
        for var i = 0; i < tokens.count; i = i + 1 {
            if i % 2 != 0 {
                if tokens[i].type == .NUMBER {
                    return false
                }
            }
        }
        
        return true
    }
}