//
//  String+Subscript.swift
//  Maw
//
//  Created by Andrzej Spiess on 14/11/15.
//  Copyright © 2015 Andrzej Spiess. All rights reserved.
//

extension String {
    
    subscript(integerIndex: Int) -> Character {
        let index = startIndex.advancedBy(integerIndex)
        
        return self[index]
    }
    
    subscript(integerRange: Range<Int>) -> String {
        let start = startIndex.advancedBy(integerRange.startIndex)
        let end = startIndex.advancedBy(integerRange.endIndex)
        let range = start..<end
        
        return self[range]
    }
}