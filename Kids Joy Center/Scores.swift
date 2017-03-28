//
//  Scores.swift
//  Kids Joy Center
//
//  Created by Ben on 3/28/17.
//  Copyright © 2017 Benjamin Leach. All rights reserved.
//

import Foundation

class Scores: NSObject, NSCoding {
    var score = Int()
    var theRest = String()
    
    init(scores: Int, rest: String) {
        score = scores
        theRest = rest
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(score, forKey: "score")
        aCoder.encode(theRest, forKey: "rest")
    }
    required init?(coder aDecoder: NSCoder) {
        score = Int(aDecoder.decodeCInt(forKey: "score"))
        theRest = aDecoder.decodeObject(forKey: "rest") as! String
    }
}
