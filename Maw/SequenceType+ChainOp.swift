//
//  SequenceType+ChainOp.swift
//  Maw
//
//  Created by Andrzej Spiess on 23/11/15.
//  Copyright © 2015 Andrzej Spiess. All rights reserved.
//

import Foundation

extension SequenceType where Generator.Element : MawToken {
    
    /* Custom chaining in case we need to support different kind of types like complex numbers etc. */
    func chainOp(initialValue : Int, chain : (MawToken -> (Int, Int) -> Int)) -> Int {
        
        var result : Int = initialValue
        var op : ((Int, Int) -> Int)?
        
        for el in self {
            
            if el.type != .NUMBER {
                op = chain(el)
            } else {
                
                if let _op = op {
                    result = _op(result, Int(el.value)!)
                    op = nil
                } else {
                    result += Int(el.value)!
                }
            }
            
        }
        
        return result
    }
    
}