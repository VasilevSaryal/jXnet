//
//  ResultView.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 17.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class ResultView {
    
    var controller: ExercisesViewController!
    
    init(_ viewController: UIViewController) {
        controller = (viewController as! ExercisesViewController)
    }
    
    
    
    
    @objc func repeatAction() -> Void {
        //Будет выполняться не тут, а в том контроллере с таким же именем
    }
    
    @objc func changeResult(sender: UISegmentedControl) -> Void {
        //Будет выполняться не тут, а в том контроллере с таким же именем
    }
}
