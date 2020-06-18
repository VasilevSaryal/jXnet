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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = 60
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
                kanaDB.append(KanaData(id: Int(kana.id), kana: currentKana, transcription: kana.transcription, shortLearning: Int(currentDataScore), deepLearning: Int(currentDeepDataScore)))
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
        cell.setConfig(kana: kanaDB[indexPath.row].kana, transcription: kanaDB[indexPath.row].transcription, shortLearner: kanaDB[indexPath.row].shortLearning, deepLearned: kanaDB[indexPath.row].deepLearning)
        cell.selectionStyle = .none
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
