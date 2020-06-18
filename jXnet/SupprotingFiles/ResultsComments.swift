//
//  ResultsComments.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 17.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import Foundation

class ResultsComments {
    func getComment(percent: Int, score: Int) -> String {
        if percent == 100 {
            if score < 250 {return Bool.random() ? "Поразительная точность, так держать!" : "Все правильно!"}
            if 250 <= score && score < 300 {return Bool.random() ? "Поразительный результат!" : "У вас определенный талант к этому!"}
            if score >= 300 {return Bool.random() ? "Наилучший результат!" : Bool.random() ? "Вы случаем не гений?" : "В Японии вас примут за своего!"}
        } else {
            if 80 <= percent && percent < 100 {return Bool.random() ? "Молодец!" : "Хороший результат!"}
            if 60 <= percent && percent < 80 {return Bool.random() ? "Не плохо!" : "Можно лучше!"}
            if percent < 60 {return Bool.random() ? "Все впереди!" : Bool.random() ? "Сосредоточься!" : "Действуй!"}
        }
        return ""
    }
}
