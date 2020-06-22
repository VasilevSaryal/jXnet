//
//  AppDelegate.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 07.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        preloadData()
        return true
    }
    
     private func preloadData() {
        
        let preloadedDataKey = "didPreloadData"
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: preloadedDataKey) == false {
                //Preload
                guard let urlPath = Bundle.main.url(forResource: "PreloadedData", withExtension: "plist") else {
                    return
                }
            let backgroundContext = persistentContainer.newBackgroundContext()
            persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
                
                backgroundContext.perform {
                    if let arrayContents = NSDictionary(contentsOf: urlPath) {
                        do {
                            for kana in arrayContents.value(forKey: "Kana") as! NSArray {
                                let kanaObject = Kana(context: backgroundContext)
                                kanaObject.id = Int16((kana as! NSDictionary).value(forKey: "id") as! Int)
                                kanaObject.hiragana = (kana as! NSDictionary).value(forKey: "hiragana") as? String
                                kanaObject.katakana = (kana as! NSDictionary).value(forKey: "katakana") as? String
                                kanaObject.russian = (kana as! NSDictionary).value(forKey: "russian") as? String
                                kanaObject.english = (kana as! NSDictionary).value(forKey: "english") as? String
                                kanaObject.deepLearnedH = 0
                                kanaObject.deepLearnedK = 0
                                kanaObject.shortLearnedH = 0
                                kanaObject.shortLearnedK = 0
                                kanaObject.mnemonicsH = ""
                                kanaObject.mnemonicsK = ""
                            }
                            for kanji in arrayContents.value(forKey: "Kanji") as! NSArray {
                                let kanjiObject = Kanji(context: backgroundContext)
                                kanjiObject.id = Int16((kanji as! NSDictionary).value(forKey: "id") as! Int)
                                kanjiObject.kanji = (kanji as! NSDictionary).value(forKey: "kanji") as? String
                                kanjiObject.kun_yomi = (kanji as! NSDictionary).value(forKey: "kun-yomi") as? String
                                kanjiObject.on_yomi = (kanji as! NSDictionary).value(forKey: "on-yomi") as? String
                                kanjiObject.russian = (kanji as! NSDictionary).value(forKey: "russian") as? String
                                kanjiObject.level = Int16(((kanji as! NSDictionary).value(forKey: "level") as! Int))
                                kanjiObject.key = (kanji as! NSDictionary).value(forKey: "key") as? String
                                kanjiObject.graduation = (kanji as! NSDictionary).value(forKey: "graduation") as? String
                                kanjiObject.isKey = ((kanji as! NSDictionary).value(forKey: "isKey") as? String) == "к"
                                
                                kanjiObject.shortLearned = 0
                                kanjiObject.deepLearned = 0
                                kanjiObject.mnemonics = ""
                            }
                            for word in arrayContents.value(forKey: "Word") as! NSArray {
                                let wordObject = Word(context: backgroundContext)
                                wordObject.id = Int16((word as! NSDictionary).value(forKey: "id") as! Int)
                                wordObject.kanji = (word as! NSDictionary).value(forKey: "kanji") as? String
                                wordObject.kana = (word as! NSDictionary).value(forKey: "kana") as? String
                                wordObject.russian = (word as! NSDictionary).value(forKey: "russian") as? String
                                wordObject.level = Int16(((word as! NSDictionary).value(forKey: "level") as! Int))
                                wordObject.group = (word as! NSDictionary).value(forKey: "group") as? String
                                wordObject.stress = (word as! NSDictionary).value(forKey: "stress") as? String
                                
                                wordObject.shortLearned = 0
                                wordObject.deepLearned = 0
                            }
                            try backgroundContext.save()
                            userDefaults.set(true, forKey: preloadedDataKey)
                            userDefaults.set(false, forKey: "isHiraganaCompleted")
                            userDefaults.set(0, forKey: "hiraganaCompletedLesson")
                            userDefaults.set(false, forKey: "isKatakanaCompleted")
                            userDefaults.set(0, forKey: "katakanaCompletedLesson")
                            userDefaults.set(false, forKey: "isKanjiCompleted")
                            userDefaults.set(0, forKey: "kanjiCompletedLesson")
                            userDefaults.set(false, forKey: "isWordCompleted")
                            userDefaults.set(0, forKey: "wordCompletedLesson")
                            userDefaults.set(false, forKey: "isPhraseCompleted")
                            userDefaults.set(0, forKey: "phraseCompletedLesson")
                            userDefaults.set(1, forKey: "userLevel")
                            userDefaults.set(0, forKey: "userExperience")
                            userDefaults.set(2500, forKey: "stepLevel")
                            userDefaults.set(5000, forKey: "nextLevel")
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            else {
                print("DATA HAS ALREADY BEEN IMPORTED THERE IS NOTHING MORE TO DO HERE.")
            }
        }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "jXnet")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

