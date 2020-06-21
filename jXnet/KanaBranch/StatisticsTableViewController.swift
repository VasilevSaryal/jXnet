//
//  StatisticsTableViewController.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 18.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit
import CoreData

class StatisticsTableViewController: UITableViewController {
    
    private var startRange: Int! //начальное значение диапозона по ид
    private var endRange: UInt32! //конечное значение диапозона по ид
    private var kanaDB = [KanaData]() //БД значений кана для данного упражнения
    var lessonNumber: Int! //номер урока
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        //self.tableView.rowHeight = 200
        self.initDB()
    }
    
    private func initDB() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let fetchRequest : NSFetchRequest<Kana> = Kana.fetchRequest()
            let range = GradationKana().getKanaRangeForTask(lessonNumber)
            startRange = range.start
            endRange = range.end
            fetchRequest.predicate = NSPredicate(format: "id >= %i && id <= %i", startRange, endRange)
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
            let fetchedResults = try context.fetch(fetchRequest)
            for kana in fetchedResults {
                let currentKana = UserDefaults.standard.bool(forKey: "isHiraganaTheme") ? kana.hiragana : kana.katakana
                let currentDataScore = UserDefaults.standard.bool(forKey: "isHiraganaTheme") ? kana.shortLearnedH : kana.shortLearnedK
                let currentDeepDataScore = UserDefaults.standard.bool(forKey: "isHiraganaTheme") ? kana.deepLearnedH : kana.deepLearnedK
                let currentMnemonics = (UserDefaults.standard.bool(forKey: "isHiraganaTheme") ? kana.mnemonicsH : kana.mnemonicsK) ?? ""
                kanaDB.append(KanaData(id: Int(kana.id), kana: currentKana, russian: kana.russian, english: kana.english, shortLearning: Int(currentDataScore), deepLearning: Int(currentDeepDataScore), mnemonics: currentMnemonics))
            }
        }
        catch {
            print ("fetch task failed", error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kanaDB.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StatisticsTableViewCell
        cell.setConfig(kana: kanaDB[indexPath.row].kana, transcription: kanaDB[indexPath.row].russian, shortLearner: kanaDB[indexPath.row].shortLearning, deepLearned: kanaDB[indexPath.row].deepLearning, mnemonics: kanaDB[indexPath.row].mnemonics)
        cell.selectionStyle = .none
        // Configure the cell...
        let mnemonicsLabel = UILabel()
        if kanaDB[indexPath.row].mnemonics != "" {
            cell.contentView.addSubview(mnemonicsLabel)
            mnemonicsLabel.text = kanaDB[indexPath.row].mnemonics
            mnemonicsLabel.numberOfLines = 0
            mnemonicsLabel.lineBreakMode = .byWordWrapping
            mnemonicsLabel.textAlignment = .justified
            mnemonicsLabel.frame.size.width = UIScreen.main.bounds.width - 40
            mnemonicsLabel.frame.origin = CGPoint(x: 20, y: 65)
            mnemonicsLabel.sizeToFit()
            self.tableView.rowHeight = mnemonicsLabel.frame.size.height + 70
        } else {
            self.tableView.rowHeight = 60
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Мнемоника", handler: { (action, indexPath) in
            let actionTitle = self.kanaDB[indexPath.row].mnemonics == "" ? "Добавить" : "Изменить"
            let alertVC = self.alertService.alert(title: "\(self.kanaDB[indexPath.row].kana!) (\(self.kanaDB[indexPath.row].russian!))", textView: self.kanaDB[indexPath.row].mnemonics, actionTitle: actionTitle, id: self.kanaDB[indexPath.row].id, completion: {
                [weak self] in
                self?.kanaDB.removeAll()
                self?.initDB()
                self?.tableView.reloadData()
            })
            self.present(alertVC, animated: true)
            
        })
        editAction.backgroundColor = UIColor.init(hexFromString: "#DE6FA1")
        
        return [editAction]
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
