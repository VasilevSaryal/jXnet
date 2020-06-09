//
//  LessonTableViewController.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 07.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class LessonTableViewController: UITableViewController, UITabBarControllerDelegate {
    
    var lessonNumber: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Урок \(String(lessonNumber ?? 0))"
        self.tabBarController?.delegate = self
        self.initCourseButtons()
        self.tableView.sectionHeaderHeight = 50
    }
    
    private func initCourseButtons() {
        let diametrCircleButtons = (UIScreen.main.bounds.width - 80) / 2
        let jXnetButton = BigShadowButton(frame: CGRect(x: 20, y: 20, width: diametrCircleButtons, height: diametrCircleButtons))
        jXnetButton.layer.cornerRadius = diametrCircleButtons / 2
        jXnetButton.setTitle("Курс прохождения от jXnet", for: .normal)
        jXnetButton.titleLabel?.lineBreakMode = .byWordWrapping
        jXnetButton.titleLabel?.font = .systemFont(ofSize: (23 * UIScreen.main.bounds.height) / 896)
        jXnetButton.setTitleColor(UIColor.init(hexFromString: "#FF3300"), for: .normal)
        jXnetButton.titleLabel?.textAlignment = .center
        jXnetButton.tag = 9
        jXnetButton.addTarget(nil, action: #selector(clickCourse), for: .touchUpInside)
        
        
        let externButton = BigShadowButton(frame: CGRect(x: 60 + diametrCircleButtons, y: 20, width: diametrCircleButtons, height: diametrCircleButtons))
        externButton.layer.cornerRadius = diametrCircleButtons / 2
        externButton.setTitle("Пройти экстерном", for: .normal)
        externButton.titleLabel?.lineBreakMode = .byWordWrapping
        externButton.titleLabel?.font = .systemFont(ofSize: (23 * UIScreen.main.bounds.height) / 896)
        externButton.setTitleColor(.white, for: .normal)
        externButton.titleLabel?.textAlignment = .center
        externButton.backgroundColor = UIColor.init(hexFromString: "#FF3300")
        externButton.tag = 10
        externButton.addTarget(nil, action: #selector(clickCourse), for: .touchUpInside)
        
        
        self.tableView(self.tableView, cellForRowAt: IndexPath(row: 0, section: 0)).contentView.addSubview(jXnetButton)
        self.tableView(self.tableView, cellForRowAt: IndexPath(row: 0, section: 0)).contentView.addSubview(externButton)
    }

    @objc func clickCourse(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Exercises", sender: sender.tag)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if self.lessonNumber == 4 || self.lessonNumber == 5 {
                return 7
            } else {
                return 8
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0 && indexPath.section == 0) {
            return ((UIScreen.main.bounds.width - 80) / 2 + 40)
        } else {
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width, height: 50))
        label.font = .systemFont(ofSize: (27 * UIScreen.main.bounds.height) / 896)
        if section == 0 {
            label.text = "Курсы прохождения (通る)"
        } else {
            label.text = "Упражнения (演習)"
        }
        label.textAlignment = .left
        view.addSubview(label)
        view.backgroundColor = .init(white: 1, alpha: 0.8)
        return view
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.section == 1 {
            self.performSegue(withIdentifier: "Exercises", sender: indexPath.row + 1)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Exercises" {
            let theDestination = (segue.destination as! ExercisesViewController)
            theDestination.lessonNumber = self.lessonNumber
            let typeTask = sender as? Int
            switch typeTask {
            case 9://Курс от jXnet
                theDestination.courseNumber = 1
                theDestination.typeTask = 1
            case 10://Экстерн
                theDestination.courseNumber = 2
                if Bool.random() {
                    theDestination.typeTask = 2
                } else {
                    if (lessonNumber == 4 || lessonNumber == 5) {
                        theDestination.typeTask = 7
                    } else {
                        theDestination.typeTask = 8
                    }
                }
            default:
                theDestination.typeTask = typeTask
            }
            
        }
    }

}
