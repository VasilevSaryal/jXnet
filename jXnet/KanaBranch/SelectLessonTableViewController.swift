//
//  SelectLessonTableViewController.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 07.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class SelectLessonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.clipsToBounds = true
        if UserDefaults.standard.bool(forKey: "isHiraganaTheme") {
            self.title = "Хирагана"
        } else {
            self.title = "Катакана"
        }
        self.tableView.rowHeight = 86
    }
    
    
    @IBAction func info(_ sender: Any) {
        let alert = UIAlertController(title: "Тут будет информация о теме урока", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")
              @unknown default:
                fatalError()
            }}))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SelectLessonTableViewCell
        cell.subject.text = "Урок " + String(indexPath.row + 1) + " (レッスン" + String(indexPath.row + 1) + ")"
        cell.subSubject.text = GradationKana().getSubSubjectName(indexPath.row)
        cell.selectionStyle = .none
        cell.info.tintColor = .systemRed
        if indexPath.row > UserDefaults.standard.integer(forKey: "hiraganaCompletedLesson") {
            cell.proccess.text = "休業"
            cell.view.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
            cell.info.isEnabled = false
        }
        else {
            cell.proccess.text = "開く"
            cell.view.backgroundColor = #colorLiteral(red: 1, green: 0.3222170472, blue: 0.6638055444, alpha: 1)
            cell.info.isEnabled = true
        }
        
        cell.indentationLevel = 54
        cell.info.tag = indexPath.row + 1
        cell.info.addTarget(self, action: #selector(clickInfo), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.row > UserDefaults.standard.integer(forKey: "hiraganaCompletedLesson") {
            let alert = UIAlertController(title: "Необходимо пройти предыдущий урок", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        else {
            self.performSegue(withIdentifier: "SelectExercise", sender: indexPath.row + 1)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectExercise" {
            let theDestination = (segue.destination as! LessonTableViewController)
            theDestination.lessonNumber = sender as? Int
        }
    }
    
    @objc func clickInfo(button: UIButton){
        let alert = UIAlertController(title: "Тут будет информация об уроке", message: "Об уроке №\(button.tag)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")
              @unknown default:
                fatalError()
            }}))
        self.present(alert, animated: true, completion: nil)
    }

}
