//
//  ExercisesViewController.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 08.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit
import CoreData

class ExercisesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var correctAnswer: Int?//Правильный ответ
    private var incorrectAnswers = [Bool]()//Счетчик ответов пользователя
    private var ask = [Int]()//Вопросы уникальные
    private var step: Float!//Шаг
    private var countQuestion: Int! //Количество вопросов
    private var countAnswer: Int!//Количество вариантов ответа
    private var YesNo: Bool!//ДаНет
    private var count = 0//Счетчик прохождения
    private var checkedAnswers = [String]()//Нужен для вывода table описание правильных ответов
    
    //Вопросы на Label
    var showAsk1: UILabel!
    var showAsk2: UILabel?
    //Ответы на Button
    var showAnswer1: UIButton!
    var showAnswer2: UIButton!
    var showAnswer3: UIButton?
    var showAnswer4: UIButton?
    var showAnswer5: UIButton?
    var showAnswer6: UIButton?
    var showAnswer7: UIButton?
    var showAnswer8: UIButton?
    var showAnswer9: UIButton?
    var showAnswer10: UIButton?
    //Начать заново
    var repeatButton: UIButton!
    //Прогесс прохождения (Линия)
    var progress: UIProgressView!
    //Переменная для обращение к методам рисования элементов в данном view
    private var chooserCorrectAnswer: ChooseCorrectAnswer!
    
    //Таблица результатов
    let resultTable: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = false
        return tv
    }()
    
    //Номер урока
    var lessonNumber: Int!
    //Тип упражнения
    var typeTask: Int!
    //База данных
    private var startRange: Int! //начальное значение диапозона по ид
    private var endRange: UInt32! //конечное значение диапозона по ид
    private var kanaDB = [KanaData]() //БД значений кана для данного упражнения
    
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
                kanaDB.append(KanaData(id: Int(kana.id), kana: currentKana, transcription: kana.transcription))
            }
        }
        catch {
            print ("fetch task failed", error)
        }
        
        switch typeTask {
        case 4:
            self.YesNo = false
            self.countAnswer = 4
        case 5:
            self.YesNo = true
        case 7:
            self.YesNo = false
            self.countAnswer = 6
        case 8:
            self.YesNo = false
            self.countAnswer = 9
        default:
            print("Development..")
            _ = navigationController?.popViewController(animated: true)
            return
        }
        if (self.lessonNumber == 4 || self.lessonNumber == 5) {
            countQuestion = 8
        } else {
            countQuestion = 10
        }
        self.initialParameters()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        initDB()
        //firstAlert()
    }
   
    func initialParameters() -> Void {
        self.view.subviews.forEach { $0.removeFromSuperview() }//Удаление всех элементов
        count = 0
        incorrectAnswers.removeAll()
        ask.removeAll()
        checkedAnswers.removeAll()
        //Инициализация после прогрузки данного ViewController
        chooserCorrectAnswer = ChooseCorrectAnswer.init(self)
        
        progress = UIProgressView()
        progress.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 1)
        progress.progress = 0.0
        step = 1.0 / Float(countQuestion)
        self.view.addSubview(progress)
        
        if (YesNo == true) {
            self.view = chooserCorrectAnswer.drawYesNo()
        }
        else {
            switch countAnswer {
            case 9:
                self.view = chooserCorrectAnswer.drawNineAnswer()
            case 6:
                self.view = chooserCorrectAnswer.drawSixAnswer()
            case 4:
                self.view = chooserCorrectAnswer.drawFourAnswer()
            default:
                print("Что-то пошло не так")
            }
            
        }
        initButtonTags()
        ask = uniqueRandoms(numberOfRandoms: countQuestion, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: nil)
        RandomizeQuize()
    }
    
    func RandomizeQuize(){
        if YesNo == true {
            if Bool.random() {
                showAsk1.text = kanaDB[ask[count]].kana
                if Bool.random() {
                    correctAnswer = 2
                    showAsk2?.text = kanaDB[ask[count]].transcription
                }
                else {
                    correctAnswer = 1
                    showAsk2?.text = kanaDB[uniqueRandoms(numberOfRandoms: 1, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: ask[count])[0]].transcription
                }
            }
            else {
                showAsk1.text = kanaDB[ask[count]].transcription
                if Bool.random() {
                    correctAnswer = 2
                    showAsk2?.text = kanaDB[ask[count]].kana
                }
                else {
                    correctAnswer = 1
                    showAsk2?.text = kanaDB[uniqueRandoms(numberOfRandoms: 1, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: ask[count])[0]].kana
                }
            }
        }
        else {
            var whereWillBeCorrectAnswer: Int!
            var inCorrectAnswerButtons = [Int]()
            var inCorrectAnswers = [Int]()
            switch countAnswer {
            case 4:
                whereWillBeCorrectAnswer = Int.random(in: 0..<4)
                inCorrectAnswerButtons = [1,2,3,4]
                inCorrectAnswerButtons.remove(at: whereWillBeCorrectAnswer)
                inCorrectAnswers = uniqueRandoms(numberOfRandoms: 3, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: ask[count])
            case 6:
                whereWillBeCorrectAnswer = Int.random(in: 0..<6)
                inCorrectAnswerButtons = [1,2,3,4,5,6]
                inCorrectAnswerButtons.remove(at: whereWillBeCorrectAnswer)
                inCorrectAnswers = uniqueRandoms(numberOfRandoms: 5, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: ask[count])
            case 9:
                whereWillBeCorrectAnswer = Int.random(in: 0..<9)
                inCorrectAnswerButtons = [1,2,3,4,5,6,7,8,9]
                inCorrectAnswerButtons.remove(at: whereWillBeCorrectAnswer)
                inCorrectAnswers = uniqueRandoms(numberOfRandoms: 8, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: ask[count])
                
            default:
                break
            }
            self.correctAnswer = whereWillBeCorrectAnswer + 1
            var k = 0
            //Вопрос кана или ромадзи
            if Bool.random() {
                showAsk1.text = kanaDB[ask[count]].kana
                let correctAnswerButton = self.view.viewWithTag(whereWillBeCorrectAnswer + 1) as? BigShadowButton
                correctAnswerButton?.setTitle(kanaDB[ask[count]].transcription, for: .normal)
                for i in inCorrectAnswerButtons{
                    let inCorrectAnswerButton = self.view.viewWithTag(i) as? BigShadowButton
                    inCorrectAnswerButton?.setTitle(kanaDB[inCorrectAnswers[k]].transcription, for: .normal)
                    k += 1
                }
            }
            else {
                showAsk1.text = kanaDB[ask[count]].transcription
                let correctAnswerButton = self.view.viewWithTag(whereWillBeCorrectAnswer + 1) as? BigShadowButton
                correctAnswerButton?.setTitle(kanaDB[ask[count]].kana, for: .normal)
                for i in inCorrectAnswerButtons{
                    let inCorrectAnswerButton = self.view.viewWithTag(i) as? BigShadowButton
                    inCorrectAnswerButton?.setTitle(kanaDB[inCorrectAnswers[k]].kana, for: .normal)
                    k += 1
                }
            }
        }
    }
    
    func initButtonTags() {
        showAnswer1.tag = 1
        showAnswer2.tag = 2
        showAnswer3?.tag = 3
        showAnswer4?.tag = 4
        showAnswer5?.tag = 5
        showAnswer6?.tag = 6
        showAnswer7?.tag = 7
        showAnswer8?.tag = 8
        showAnswer9?.tag = 9
        showAnswer10?.tag = 10
        for i in 1...10 {
            let buttonWithTag = self.view.viewWithTag(i) as? UIButton
            buttonWithTag?.addTarget(nil, action: #selector(clickAnswer), for: .touchUpInside)
        }
    }
    
    @objc func clickAnswer(_ sender: UIButton) {
        progress.progress += step
        if correctAnswer == sender.tag {
            incorrectAnswers.append(false)
        }
        else {
            incorrectAnswers.append(true)
        }
        if count == countQuestion - 1  {
            drawResult()
            return
        }
        
        count += 1
        RandomizeQuize()
    }
    
    //Может перенести отдельно ?
    func drawResult(){
        checkAnswers()
        //RightBar.image = UIImage.init(systemName: "gear")
        //self.tabBarController?.tabBar.isHidden = false
        view.subviews.forEach { $0.removeFromSuperview() }//Удаление всех элементов
        let label = UILabel()
        var correctSum = 0
        for answer in incorrectAnswers {
            if answer == false {correctSum += 1}
        }
        label.text = "Результат: \(correctSum)/\(countQuestion!):"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 27)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.minimumScaleFactor = 0.4
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.navigationController?.navigationBar.bottomAnchor ?? view.topAnchor, constant: 5),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20)
        ])
        let label2 = UILabel()
        label2.text = "Уровень: 0"
        label2.textColor = .black
        label2.font = UIFont.systemFont(ofSize: 21)
        label2.adjustsFontSizeToFitWidth = true
        label2.textAlignment = .left
        label2.minimumScaleFactor = 0.4
        view.addSubview(label2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            label2.heightAnchor.constraint(equalToConstant: 30),
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            label2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(UIScreen.main.bounds.width / 2))
        ])
        let label3 = UILabel()
        label3.frame = CGRect(x: (UIScreen.main.bounds.width / 2) + 10, y: 80, width: (UIScreen.main.bounds.width / 2) - 15, height: 30)
        label3.text = "+253"
        label3.textColor = .blue
        label3.font = UIFont.systemFont(ofSize: 17)
        label3.adjustsFontSizeToFitWidth = true
        label3.textAlignment = .right
        label3.minimumScaleFactor = 0.4
        view.addSubview(label3)
        label3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label3.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            label3.heightAnchor.constraint(equalToConstant: 30),
            label3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (UIScreen.main.bounds.width / 2)),
            label3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
        let progressLevel = UIProgressView()
        progressLevel.frame = CGRect(x: 0, y: 130, width: UIScreen.main.bounds.width, height: 1)
        progressLevel.transform = progressLevel.transform.scaledBy(x: 1, y: 20)
        progressLevel.progress = 0.75
        view.addSubview(progressLevel)
        progressLevel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressLevel.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 10),
            progressLevel.heightAnchor.constraint(equalToConstant: 1),
            progressLevel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            progressLevel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        resultTable.delegate = self
        resultTable.dataSource = self
        resultTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        resultTable.tableFooterView = UIView()
        view.addSubview(resultTable)
        resultTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultTable.topAnchor.constraint(equalTo: progressLevel.bottomAnchor, constant: 10),
            resultTable.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -54),
            resultTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            resultTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        resultTable.reloadData()
        repeatButton = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 54, width: UIScreen.main.bounds.width, height: 54))
        repeatButton.setTitle("Попробовать еще раз", for: .normal)
        repeatButton.setTitleColor(.white, for: .normal)
        repeatButton.backgroundColor = UIColor.init(hexFromString: "#3333CC")
        repeatButton.addTarget(nil, action: #selector(repeatAction), for: .touchUpInside)
        view.addSubview(repeatButton)
        repeatButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repeatButton.topAnchor.constraint(equalTo: resultTable.bottomAnchor, constant: 0),
            repeatButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            repeatButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            repeatButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countQuestion
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = checkedAnswers[indexPath.row]
        if incorrectAnswers[indexPath.row] {
            cell.imageView?.image = UIImage.init(named: "xmark")
            cell.imageView?.tintColor = .red
            cell.backgroundColor = UIColor.init(red: 255, green: 0, blue: 0, alpha: 0.3)
        }
        else {
            cell.imageView?.image = UIImage.init(named: "chevron")
            cell.imageView?.tintColor = .green
            cell.backgroundColor = UIColor.init(red: 0, green: 255, blue: 0, alpha: 0.3)
        }
        return cell
    }
    
    func checkAnswers(){
        for i in 0...countQuestion - 1{
            if incorrectAnswers[i] {
                checkedAnswers.append("Правильный ответ: \(kanaDB[ask[i]].kana ?? "") - \(kanaDB[ask[i]].transcription ?? "")")
            }
            else {
                checkedAnswers.append(" \(kanaDB[ask[i]].kana ?? "") - \(kanaDB[ask[i]].transcription ?? "")")
            }
        }
        
    }
    
    @objc func repeatAction() -> Void {
        initDB()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func uniqueRandoms(numberOfRandoms: Int, minNum: Int, maxNum: UInt32, blackList: Int?) -> [Int] {
        var uniqueNumbers = Set<Int>()
        while uniqueNumbers.count < numberOfRandoms {
            uniqueNumbers.insert(Int(arc4random_uniform(maxNum + 1)) + minNum)
        }
        if let blackList = blackList {
            if uniqueNumbers.contains(blackList) {
                while uniqueNumbers.count < numberOfRandoms+1 {
                    uniqueNumbers.insert(Int(arc4random_uniform(maxNum + 1)) + minNum)
                }
                uniqueNumbers.remove(blackList)
            }
        }
        return uniqueNumbers.shuffled()
    }
}

