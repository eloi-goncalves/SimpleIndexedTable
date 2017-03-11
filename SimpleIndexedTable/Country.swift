//
//  CountriesModel.swift
//  CountrysTable
//
//  Created by Eloi Andre Goncalves on 11/03/17.
//  Copyright © 2017 Eloi Andre Goncalves. All rights reserved.
//

import UIKit

class Country: NSObject {
    
    
    var name      : String!
    var code      : String!
    var firstLetter : String!
    
//    var dial_code  : String!
    
    
    init(JSONNSDictionary : NSDictionary) {
        super.init()
        
        let JSONDictionary: Dictionary =  JSONNSDictionary as! [String:AnyObject]
        
        self.setValuesForKeys(JSONDictionary)
    }
    
    
    init (name : String, code : String, firstLetter : String) {
    
        self.name = name
        self.code = code
        self.firstLetter = firstLetter
    }
    
    
}
