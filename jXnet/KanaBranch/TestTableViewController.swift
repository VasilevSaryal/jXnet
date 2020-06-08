//
//  TestTableViewController.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 08.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit
import CoreData

class TestTableViewController: UITableViewController {
    var kana = [Kana]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.kana.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let kana = self.kana[indexPath.row]

        cell.textLabel?.text = "\(String(describing: kana.value(forKey: "id") as! String)) \(String(describing: kana.value(forKey: "hiragana") as! String)) \(String(describing: kana.value(forKey: "katakana") as! String)) \(String(describing: kana.value(forKey: "transcription") as! String))"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete {
            context.delete(kana[indexPath.row])
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                kana = try context.fetch(Kana.fetchRequest())
            } catch let error as NSError{
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        tableView.reloadData()
    }
    @IBAction func addName(_ sender: Any) {
        let alert = UIAlertController(title: "New name", message: "Enter a new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            let textField = alert.textFields?.first
            self.saveName(name: textField?.text ?? "Void")
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func saveName(name: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let kana = Kana(entity: Kana.entity(), insertInto: context)
        
        kana.setValue(name, forKey: "name")
        
        do {
            try context.save()
            self.kana.append(kana)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let result = try context.fetch(Kana.fetchRequest())
            kana = result as! [Kana]
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    //sort
    func test1() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var kanaDB = [Kana]()
        
        do {
            let fetchRequest : NSFetchRequest<Kana> = Kana.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
            let fetchedResults = try context.fetch(fetchRequest)
            
            for kana in fetchedResults {
                print("sss ", kana.hiragana, kana.id, kana.learnedH)
            }
            
        }
        catch {
            print ("fetch task failed", error)
        }
    }
    
    //edit with search
    func test2() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var kanaDB = [Kana]()
        
        do {
            let fetchRequest : NSFetchRequest<Kana> = Kana.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %i", 2)
            let fetchedResults = try context.fetch(fetchRequest)
            
            fetchedResults.first?.learnedH = 1.0
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            for kana in fetchedResults {
                print("sss ", kana.hiragana, kana.id, kana.learnedH)
            }
            
        }
        catch {
            print ("fetch task failed", error)
        }
    }
}
