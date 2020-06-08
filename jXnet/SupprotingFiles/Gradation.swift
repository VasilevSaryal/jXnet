//
//  Gradation.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 08.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import Foundation

class GradationKana {
    func getSubSubjectName(_ lesson: Int) -> String {
        switch lesson {
        case 0:
            return "Столбцы 1,2(列1,2)"
        case 1:
            return "Столбцы 3,4(列3,4)"
        case 2:
            return "Столбцы 5,6(列5,6)"
        case 3:
            return "Столбцы 7,8(列7,8)"
        case 4:
            return "Столбцы 9,10,11(列9,10,11)"
        case 5:
            return "Озвончение и оглушение(鳴りとスタン)"
        default:
            return "development..."
        }
    }
    
    func getKanaRangeForTask(_ lesson: Int) -> RangeForGradation {
        switch lesson {
        case 1:
            return RangeForGradation(start: 1, end: 10)
        case 2:
            return RangeForGradation(start: 11, end: 20)
        case 3:
            return RangeForGradation(start: 21, end: 30)
        case 4:
            return RangeForGradation(start: 31, end: 38)
        case 5:
            return RangeForGradation(start: 39, end: 46)
        case 6:
            return RangeForGradation(start: 47, end: 71)
        default:
            return RangeForGradation(start: 0, end: 0)
        }
    }

}
