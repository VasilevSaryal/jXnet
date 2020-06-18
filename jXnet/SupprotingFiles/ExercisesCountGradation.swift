//
//  ExercisesCountGradation.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 16.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import Foundation

class ExercisesCountGradation {
    func twoAnswer(seconds: Float) -> Int {
        if seconds <= 1 {return 20}
        if 2 < seconds && seconds <= 3 {return 19}
        if 3 < seconds && seconds <= 5 {return 18}
        if 5 < seconds && seconds <= 8 {return 17}
        if 8 < seconds && seconds <= 10 {return 16}
        if 10 < seconds && seconds <= 14 {return 15}
        if 14 < seconds && seconds <= 18 {return 14}
        if 18 < seconds && seconds <= 22 {return 13}
        if 22 < seconds && seconds <= 26 {return 12}
        if 27 < seconds && seconds < 30 {return 11}
        if 30 <= seconds {return 10}
        return 0
    }
    
    func fourAnswerYesNoComparsion(seconds: Float) -> Int {
        if seconds <= 2 {return 40}
        if 2 < seconds && seconds <= 4 {return 38}
        if 4 < seconds && seconds <= 5 {return 36}
        if 5 < seconds && seconds <= 8 {return 34}
        if 8 < seconds && seconds <= 10 {return 32}
        if 10 < seconds && seconds <= 14 {return 30}
        if 14 < seconds && seconds <= 18 {return 28}
        if 18 < seconds && seconds <= 22 {return 26}
        if 22 < seconds && seconds <= 26 {return 24}
        if 27 < seconds && seconds < 30 {return 22}
        if 30 <= seconds {return 20}
        return 0
    }
    
    func sixAnswer(seconds: Float) -> Int {
        if seconds <= 3 {return 50}
        if 3 < seconds && seconds <= 5 {return 48}
        if 5 < seconds && seconds <= 6 {return 46}
        if 6 < seconds && seconds <= 8 {return 44}
        if 8 < seconds && seconds <= 10 {return 42}
        if 10 < seconds && seconds <= 14 {return 40}
        if 14 < seconds && seconds <= 18 {return 38}
        if 18 < seconds && seconds <= 22 {return 36}
        if 22 < seconds && seconds <= 26 {return 34}
        if 27 < seconds && seconds < 30 {return 32}
        if 30 <= seconds {return 30}
        return 0
    }
    
    func nineAnswerWriteKana(seconds: Float) -> Int {
        if seconds <= 4 {return 70}
        if 4 < seconds && seconds <= 6 {return 58}
        if 6 < seconds && seconds <= 7 {return 56}
        if 7 < seconds && seconds <= 8 {return 54}
        if 8 < seconds && seconds <= 10 {return 52}
        if 10 < seconds && seconds <= 14 {return 50}
        if 14 < seconds && seconds <= 18 {return 48}
        if 18 < seconds && seconds <= 22 {return 46}
        if 22 < seconds && seconds <= 26 {return 44}
        if 27 < seconds && seconds < 30 {return 42}
        if 30 <= seconds {return 40}
        return 0
    }
    
    func incorrectForAll() -> Int {
        return -30
    }
}
