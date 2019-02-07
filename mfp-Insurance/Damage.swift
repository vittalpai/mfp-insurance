//
//  Damage.swift
//  mfp-Insurance
//
//  Created by Vittal Pai on 07/02/19.
//  Copyright © 2019 Vittal Pai. All rights reserved.
//

import Foundation

class Damage {
    var type: String
    var cost: Int
    
    init(type: String, cost: Int) {
        self.type = type
        self.cost = cost
    }
}
