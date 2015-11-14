//
//  MawExpression.swift
//  Maw
//
//  Created by Andrzej Spiess on 14/11/15.
//  Copyright © 2015 Andrzej Spiess. All rights reserved.
//

private protocol _MawExpression {
    func valExprTokens(tokens : [MawToken]) -> Bool
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
        fatalError("Have to be overriden")
    }
    
}

class MawExpressionAddition : MawExpressionBase<Int> {
    
    override init?(tokens: [MawToken]) {
        super.init(tokens: tokens)
    }
    
    override func eval() -> Int {
        
        guard
            let left = _tokens.first,
            let right = _tokens.last,
            let leftValue = Int(left.value),
            let rightValue = Int(right.value)
        else {
            fatalError("There is not enough tokens to do addition")
        }
        
        return leftValue + rightValue
    }
    
    private override func valExprTokens(tokens: [MawToken]) -> Bool {
        guard
            tokens.count == 3 &&
            tokens[1].type == .PLUS
            else {
                return false
        }
        
        return true
    }
}

class MawExpressionSubtraction : MawExpressionBase<Int> {
    
    override init?(tokens: [MawToken]) {
        super.init(tokens: tokens)
    }
    
    override func eval() -> Int {
        
        guard
            let left = _tokens.first,
            let right = _tokens.last,
            let leftValue = Int(left.value),
            let rightValue = Int(right.value)
            else {
                fatalError("There is not enough tokens to do subtraction")
        }
        
        return leftValue - rightValue
    }
    
    private override func valExprTokens(tokens: [MawToken]) -> Bool {
        
        guard
            tokens.count == 3 &&
            tokens[1].type == .MINUS
        else {
            return false
        }
        
        return true
    }
}