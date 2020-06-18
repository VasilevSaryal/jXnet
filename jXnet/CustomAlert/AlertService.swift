//
//  AlertService.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 19.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class AlertService {
    func alert(title: String, textView: String, actionTitle: String, id: Int, completion: @escaping () -> Void) -> AlertViewController {
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        alertVC.alertTitle = title
        alertVC.alertTextView = textView
        alertVC.alertAction = actionTitle
        alertVC.id = id
        alertVC.buttonAction = completion
        return alertVC
    }
}
