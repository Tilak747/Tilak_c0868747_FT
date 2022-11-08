//
//  GameModel.swift
//  Tilak_c0868747_FT
//
//  Created by Tilak Acharya on 2022-11-07.
//

import Foundation

struct GameModel{
    var number:Int
    var myChoice:Bool
    var result:Bool
    init(number: Int, myChoice: Bool, result: Bool) {
        self.number = number
        self.myChoice = myChoice
        self.result = result
    }
}
