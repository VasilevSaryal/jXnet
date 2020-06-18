//
//  AlertViewController.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 19.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit
import CoreData

class AlertViewController: UIViewController {

    @IBOutlet weak var action: UIButton!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var alertTitle = String()
    var alertTextView = String()
    var alertAction = String()
    var id = Int()
    
    var buttonAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTitle.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        setupView()
         
    }
    
    func setupView() {
        titleLabel.text = alertTitle
        textView.text = alertTextView
        action.setTitle(alertAction, for: .normal)
    }
    
    @IBAction func clickCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func clickAction(_ sender: Any) {
        dismiss(animated: true)
        setMenmonics(id: id)
        buttonAction?()
    }
    
    //edit with search
    func setMenmonics(id: Int) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
        do {
            let fetchRequest : NSFetchRequest<Kana> = Kana.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %i", id)
            let fetchedResults = try context.fetch(fetchRequest)
            
            fetchedResults.first?.mnemonics = textView.text
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        catch {
            print ("fetch task failed", error)
        }
    }
}
