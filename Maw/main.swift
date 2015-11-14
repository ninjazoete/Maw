//
//  main.swift
//  Maw
//
//  Created by Andrzej Spiess on 14/11/15.
//  Copyright © 2015 Andrzej Spiess. All rights reserved.
//

import Foundation

var keyboard = NSFileHandle.fileHandleWithStandardInput()

while true {

    print(">>", terminator : "")
    var inputData = keyboard.availableData
    let input = NSString(data: inputData, encoding:NSUTF8StringEncoding) as? String
    
    if let input = input {
        
        let interpreter = MawInterpreter(input: input)
        print(interpreter.scan())
    }
}
