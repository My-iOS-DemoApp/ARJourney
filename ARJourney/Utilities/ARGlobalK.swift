//
//  ARGlobalK.swift
//  ARJourney
//
//  Created by Shuvo on 9/26/17.
//  Copyright © 2017 S.M.Moinuddin (Shuvo). All rights reserved.
//

import Foundation

// For Gloabal variable, constants or typedef

struct CollisionCategory : OptionSet {
    let rawValue: Int
    
    static let bottomPlane  = CollisionCategory(rawValue: 1 << 0)
    static let cube = CollisionCategory(rawValue: 1 << 1)
    static let dropCube = CollisionCategory(rawValue: 1 << 2)
}


