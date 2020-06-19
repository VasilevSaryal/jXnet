//
//  HideKeyboardWhenTappedAround.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 19.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
