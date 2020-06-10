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
    private var firstAnswer = 0//Тег первой кнопки только для сопоставления
    private var pairInt = [TwoInteger]()//Пара правильного ответа только для сопоставления и прохождение курса от jXnet
    private var lastAsk = [Int]()//Костыль временный нужен для заключительного вопроса в курсе от jXnet
    private var correctAnswerForComparsion = 0// Костыль запись правильного ответа для сопоставления
    private var step: Float!//Шаг
    private var countQuestion: Int! //Количество вопросов
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
    var showAnswer11: UIButton?
    var showAnswer12: UIButton?
    //Начать заново
    var repeatButton: UIButton!
    //Прогесс прохождения (Линия)
    var progress: UIProgressView!
    //Перекрывания экрана используются для неправильного нажатия
    let fullScreenView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return view
    }()
    //Переменные для обращение к методам рисования элементов в данном view
    private var chooserCorrectAnswer: ChooseCorrectAnswer!
    private var showKana: ShowKana!
    private var comparsionTask: ComparsionTask!
    private var handwritingView: HandwritingView!
    
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
    //Номер курса. 0 если это не курс
    var courseNumber = 0
    //База данных
    private var startRange: Int! //начальное значение диапозона по ид
    private var endRange: UInt32! //конечное значение диапозона по ид
    private var kanaDB = [KanaData]() //БД значений кана для данного упражнения
    
    //Переменные только для рукописного ввода
    var drawableView: DrawableView!
    
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
        self.initialParameters()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initDB()
        //firstAlert()
    }
    
    func initialParameters() -> Void {
        self.view.subviews.forEach { $0.removeFromSuperview() }//Удаление всех элементов
        
        pairInt = []
        if (self.lessonNumber == 4 || self.lessonNumber == 5) {
            countQuestion = 8
        } else {
            countQuestion = 10
        }
        count = 0
        incorrectAnswers.removeAll()
        ask.removeAll()
        checkedAnswers.removeAll()
        
        progress = UIProgressView()
        progress.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 1)
        progress.progress = 0.0
        step = 1.0 / Float(countQuestion)
        self.view.addSubview(progress)
        
        if courseNumber == 1 {
            //Инициализация после прогрузки данного ViewController
            showKana = ShowKana.init(self)
            handwritingView = HandwritingView.init(self)
            chooserCorrectAnswer = ChooseCorrectAnswer.init(self)
            comparsionTask = ComparsionTask.init(self)
        }
        
        if courseNumber == 2 {
            //Инициализация после прогрузки данного ViewController
            handwritingView = HandwritingView.init(self)
            chooserCorrectAnswer = ChooseCorrectAnswer.init(self)
        }
        
        switch typeTask {
        case 1:
            //Инициализация после прогрузки данного ViewController
            if courseNumber == 0 {showKana = ShowKana.init(self)}
            self.view = showKana.showKana()
            countQuestion = kanaDB.count
        case 2:
            //Инициализация после прогрузки данного ViewController
            if courseNumber == 0 {handwritingView = HandwritingView.init(self)}
            self.view = handwritingView.drawStandartSheet()
            ask = uniqueRandoms(numberOfRandoms: countQuestion, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: nil)
        case 3:
            //Инициализация после прогрузки данного ViewController
            if courseNumber == 0 {chooserCorrectAnswer = ChooseCorrectAnswer.init(self)}
            self.view = chooserCorrectAnswer.drawTwoAnswer()
            ask = uniqueRandoms(numberOfRandoms: countQuestion, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: nil)
        case 4:
            //Инициализация после прогрузки данного ViewController
            if courseNumber == 0 {chooserCorrectAnswer = ChooseCorrectAnswer.init(self)}
            self.view = chooserCorrectAnswer.drawFourAnswer()
            ask = uniqueRandoms(numberOfRandoms: countQuestion, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: nil)
        case 5:
            //Инициализация после прогрузки данного ViewController
            if courseNumber == 0 {chooserCorrectAnswer = ChooseCorrectAnswer.init(self)}
            self.view = chooserCorrectAnswer.drawYesNo()
            ask = uniqueRandoms(numberOfRandoms: countQuestion, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: nil)
        case 6:
            //Инициализация после прогрузки данного ViewController
            if courseNumber == 0 {comparsionTask = ComparsionTask.init(self)}
            if lessonNumber == 4 || lessonNumber == 5 {
                self.view = comparsionTask.drawComparsionFive()
                countQuestion = 5
                ask = uniqueRandoms(numberOfRandoms: 5, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: nil)
            } else {
                self.view = comparsionTask.drawComparsionSix()
                countQuestion = 6
                ask = uniqueRandoms(numberOfRandoms: 6, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: nil)
            }
        case 7:
            //Инициализация после прогрузки данного ViewController
            if courseNumber == 0 {chooserCorrectAnswer = ChooseCorrectAnswer.init(self)}
            self.view = chooserCorrectAnswer.drawSixAnswer()
            ask = uniqueRandoms(numberOfRandoms: countQuestion, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: nil)
        case 8:
            //Инициализация после прогрузки данного ViewController
            if courseNumber == 0 {chooserCorrectAnswer = ChooseCorrectAnswer.init(self)}
            self.view = chooserCorrectAnswer.drawNineAnswer()
            ask = uniqueRandoms(numberOfRandoms: countQuestion, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: nil)
            
        default:
            print("Development..")
            _ = navigationController?.popViewController(animated: true)
            return
        }
        if courseNumber == 0 || courseNumber == 2 {
            self.title = "1/\(countQuestion ?? 0)"
        } else if courseNumber == 1{
            self.title = "1/5"
            ask = uniqueRandoms(numberOfRandoms: countQuestion / 2, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: nil)
            //TODO костыль для скорости разработки
            lastAsk = ask
            if courseNumber == 1 {
                for i in ask {
                    pairInt.append(TwoInteger(first: i))
                }
            }
        }
        initButtonTags()
        RandomizeQuize()
    }
    
    func RandomizeQuize(){
        switch typeTask {
        case 1:
            if courseNumber == 0 {
                showAsk1.text = kanaDB[count].kana
                showAsk2?.text = kanaDB[count].transcription
                if count == 0 {
                    showAnswer1.isHidden = true
                } else {
                    showAnswer1.isHidden = false
                }
                if count == kanaDB.count - 1 {
                    showAnswer2.isHidden = true
                } else {
                    showAnswer2.isHidden = false
                }
            }
            if courseNumber == 1 {
                showAsk1.text = kanaDB[ask[count]].kana
                showAsk2?.text = kanaDB[ask[count]].transcription
                showAnswer1.isHidden = true
            }
        case 2:
            showAsk1.text = kanaDB[ask[count]].transcription
            if courseNumber == 1 {
                showAsk2?.text = kanaDB[ask[count]].kana
            }
        case 5://ДаНет
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
        case 6: //Упражение на правильное сопоставление
            pairInt.removeAll()
            let isLittleQuestion = (lessonNumber == 4 || lessonNumber == 5)
            let allAnswers = isLittleQuestion ? uniqueRandoms(numberOfRandoms: 10, minNum: 0, maxNum: 9, blackList: nil) : uniqueRandoms(numberOfRandoms: 12, minNum: 0, maxNum: 11, blackList: nil)
            let transcriptionAnswers = isLittleQuestion ? allAnswers[0...4] : allAnswers[0...5]
            let kanaAnswers = isLittleQuestion ? allAnswers[5...9] : allAnswers[6...11]
            if isLittleQuestion {
                for i in 0...4 {
                    let correctPair = TwoInteger(first: transcriptionAnswers[i] + 1, second: kanaAnswers[5 + i] + 1)
                    pairInt.append(correctPair)
                }
            } else {
                for i in 0...5 {
                    let correctPair = TwoInteger(first: transcriptionAnswers[i] + 1, second: kanaAnswers[6 + i] + 1)
                    pairInt.append(correctPair)
                }
            }
            var k = 0
            for i in transcriptionAnswers {
                let answerButton = self.view.viewWithTag(i + 1) as? BigShadowButton
                answerButton?.setTitle(kanaDB[ask[k]].transcription, for: .normal)
                k += 1
            }
            k = 0
            for i in kanaAnswers {
                let answerButton = self.view.viewWithTag(i + 1) as? BigShadowButton
                answerButton?.setTitle(kanaDB[ask[k]].kana, for: .normal)
                k += 1
            }
        default: //Упражнения с выбором правильного ответа из 2, 4, 6 и 9
            var whereWillBeCorrectAnswer: Int!
            var inCorrectAnswerButtons = [Int]()
            var inCorrectAnswers = [Int]()
            switch typeTask {
            case 3:
                whereWillBeCorrectAnswer = Int.random(in: 0..<2)
                inCorrectAnswerButtons = [1,2]
                inCorrectAnswerButtons.remove(at: whereWillBeCorrectAnswer)
                inCorrectAnswers = uniqueRandoms(numberOfRandoms: 1, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: ask[count])
            case 4:
                whereWillBeCorrectAnswer = Int.random(in: 0..<4)
                inCorrectAnswerButtons = [1,2,3,4]
                inCorrectAnswerButtons.remove(at: whereWillBeCorrectAnswer)
                inCorrectAnswers = uniqueRandoms(numberOfRandoms: 3, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: ask[count])
            case 7:
                whereWillBeCorrectAnswer = Int.random(in: 0..<6)
                inCorrectAnswerButtons = [1,2,3,4,5,6]
                inCorrectAnswerButtons.remove(at: whereWillBeCorrectAnswer)
                inCorrectAnswers = uniqueRandoms(numberOfRandoms: 5, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: ask[count])
            case 8:
                whereWillBeCorrectAnswer = Int.random(in: 0..<9)
                inCorrectAnswerButtons = [1,2,3,4,5,6,7,8,9]
                inCorrectAnswerButtons.remove(at: whereWillBeCorrectAnswer)
                inCorrectAnswers = uniqueRandoms(numberOfRandoms: 8, minNum: 0, maxNum: UInt32(kanaDB.count - 1), blackList: ask[count])
            default:
                return
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
        showAnswer11?.tag = 11
        showAnswer12?.tag = 12
        for i in 1...12 {
            let buttonWithTag = self.view.viewWithTag(i) as? UIButton
            buttonWithTag?.addTarget(nil, action: #selector(clickAnswer), for: .touchUpInside)
        }
    }
    
    @objc func clickAnswer(_ sender: UIButton) {
        switch typeTask {
        case 1://показать кана
            if sender.tag == 2 {
                count += 1
            } else {
                count -= 1
            }
            self.title = "\(count + 1)/\(countQuestion ?? 0)"
            if courseNumber == 0 {RandomizeQuize()}
        case 2://написать кана
            switch sender.tag {
            case 1:
                incorrectAnswers.append(false)
                if count == countQuestion - 1{
                    drawResult()
                    return
                }
                count += 1
                self.title = "\(count + 1)/\(countQuestion ?? 0)"
                drawableView.clear()
                if courseNumber == 0 {RandomizeQuize()}
            case 2:
                drawableView.clear()
            default:
                drawableView.undo()
            }
            
        case 6://сопоставление
            if firstAnswer == 0 {
                sender.backgroundColor = UIColor(white: 0.95, alpha: 1)
                firstAnswer = sender.tag
                //костыль запись правильного варианта сапостовления
                for pair in pairInt {
                    if (sender.tag == pair.first || sender.tag == pair.second) {
                        correctAnswerForComparsion = sender.tag == pair.first ? pair.second : pair.first
                    }
                }
            } else {
                if firstAnswer == sender.tag {
                    firstAnswer = 0
                    sender.backgroundColor = .white
                    return
                }
                let firstAnswerButton = self.view.viewWithTag(firstAnswer) as? BigShadowButton
                for pair in pairInt {
                    if (sender.tag == pair.first || sender.tag == pair.second) {
                        if (firstAnswer == pair.first || firstAnswer == pair.second) {
                            count += 1
                            incorrectAnswers.append(false)
                            if count == countQuestion  {
                                firstAnswer = 0
                                if courseNumber == 1 {
                                    jXnetCourseComplete()
                                } else {
                                    drawResult()
                                }
                                return
                            }
                            self.title = "\(count + 1)/\(countQuestion!)"
                            sender.isHidden = true
                            firstAnswerButton?.isHidden = true
                        } else {
                            //Неверный выбор
                            if courseNumber == 0 {
                                //Костыль для быстрой разработки
                                firstAnswer = 0
                                view.addSubview(fullScreenView)
                                fullScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
                                let correctAnswer = self.view.viewWithTag(correctAnswerForComparsion) as? UIButton
                                correctAnswer?.backgroundColor = UIColor(hexFromString: "#1FD945")
                                sender.backgroundColor = UIColor(hexFromString: "#F2333B")
                                count = 0
                                self.title = "1/\(countQuestion!)"
                                return
                            }
                            if courseNumber == 1 {
                                incorrectAnswers.removeAll()
                                checkedAnswers.removeAll()
                                ask.removeAll()
                                pairInt.removeAll()
                                ask = lastAsk
                                for i in lastAsk {
                                    pairInt.append(TwoInteger(first: i))
                                }
                                typeTask = 1
                                count = 0
                                self.title = "1/5"
                                initButtonTags()
                                firstAnswer = 0
                                view.addSubview(fullScreenView)
                                fullScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
                                let correctAnswer = self.view.viewWithTag(correctAnswerForComparsion) as? UIButton
                                correctAnswer?.backgroundColor = UIColor(hexFromString: "#1FD945")
                                sender.backgroundColor = UIColor(hexFromString: "#F2333B")
                                return
                            }
                        }
                        firstAnswer = 0
                        break
                    }
                }
            }
        default: //тут все упражнения кроме курсов, показать кана, написать кана и сопоставление
            if correctAnswer == sender.tag {
                incorrectAnswers.append(false)
            }
            else {
                incorrectAnswers.append(true)
                view.addSubview(fullScreenView)
                fullScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
                let correctAnswerButton = self.view.viewWithTag(correctAnswer!) as? UIButton
                correctAnswerButton?.backgroundColor = UIColor(hexFromString: "#1FD945")
                sender.backgroundColor = UIColor(hexFromString: "#F2333B")
                if typeTask == 5 {
                    correctAnswerButton?.setTitleColor(.black, for: .normal)
                    sender.setTitleColor(.black, for: .normal)
                }
                return
                
            }
            if count == countQuestion - 1  {
                drawResult()
                return
            }
            progress.progress += step
            count += 1
            self.title = "\(count + 1)/\(countQuestion ?? 0)"
            if courseNumber == 0 {RandomizeQuize()}
            
        }
        
        //КУРСЫ
        let isClickInClearOrReset = ((typeTask == 2 && sender.tag == 2) || (typeTask == 2 && sender.tag == 3))
        extraTaskCourses(isClickInClearOrReset)
    }
    
    private func extraTaskCourses(_ isClickInClearOrReset: Bool) {
        if courseNumber == 1 {
            //Чтобы не реагировать при нажатии в сопоставлении
            if (typeTask == 6) {return}
            //Для кнопок стирания в рукописном вводе
            if  isClickInClearOrReset {return}
            self.view.subviews.forEach { $0.removeFromSuperview() }//Удаление всех элементов
            //TODO временный костыль для быстрогое решения
            count -= 1
            for i in 0...(pairInt.count - 1) {
                if ask[count] == pairInt[i].first {
                    var isNext: Bool!
                    if pairInt[i].second == 0 {isNext = true}
                    else {isNext = !incorrectAnswers.last!}
                    if !isNext {
                        pairInt[i].second = 0
                    } else {
                        pairInt[i].second += 1
                        if pairInt[i].second == 5 {
                            pairInt.remove(at: i)
                        }
                    }
                    break
                }
            }
            ask.removeAll()
            if pairInt.count == 0 {
                count = 0
                typeTask = 6
                if lessonNumber == 4 || lessonNumber == 5 {
                    self.view = comparsionTask.drawComparsionFive()
                    self.title = "1/5"
                    self.countQuestion = 5
                    
                } else {
                    self.view = comparsionTask.drawComparsionSix()
                    self.title = "1/6"
                    self.countQuestion = 6
                }
                ask = lastAsk
                
                var saryalFix = [Int]()
                for i in 0...(kanaDB.count - 1) {
                    saryalFix.append(i)
                }
                saryalFix = Array(Set(saryalFix).symmetricDifference(Set(ask)))
                let randomIndex = Int.random(in: 0...(saryalFix.count - 1))
                ask.append(saryalFix[randomIndex])
                
                initButtonTags()
                RandomizeQuize()
                return
            }
            let nextAsk = Int.random(in: 0...(pairInt.count - 1))
            ask.append(pairInt[nextAsk].first)
            switch pairInt[nextAsk].second {
            case 0:
                typeTask = 1
                self.view = showKana.showKana()
                self.title = "1/5"
            case 1:
                typeTask = 2
                self.view = handwritingView.drawStandartSheetWithStencil()
                self.title = "2/5"
            case 2:
                typeTask = 3
                self.view = chooserCorrectAnswer.drawTwoAnswer()
                self.title = "3/5"
            case 3:
                if Bool.random() {
                    typeTask = 4
                    self.view = chooserCorrectAnswer.drawFourAnswer()
                } else {
                    typeTask = 5
                    self.view = chooserCorrectAnswer.drawYesNo()
                }
                self.title = "4/5"
            case 4:
                typeTask = 7
                self.view = chooserCorrectAnswer.drawSixAnswer()
                self.title = "5/5"
            default:
                print("Error in nextAsk ")
                return
            }
            initButtonTags()
            RandomizeQuize()
        }
        if courseNumber == 2 && typeTask != 6 {
            //Для кнопок стирания в рукописном вводе
            if isClickInClearOrReset {return}
            self.view.subviews.forEach { $0.removeFromSuperview() }//Удаление всех элементов
            if Bool.random() {
                typeTask = 2
                self.view = handwritingView.drawStandartSheet()
            } else {
                
                if countQuestion == 10 {
                    typeTask = 8
                    self.view = chooserCorrectAnswer.drawNineAnswer()
                } else {
                    typeTask = 7
                    self.view = chooserCorrectAnswer.drawSixAnswer()
                }
            }
            initButtonTags()
            RandomizeQuize()
        }
    }
    
    private func jXnetCourseComplete() {
        let alert = UIAlertController(title: "Поздравляю!", message: "Вы выучили \(countQuestion - 1) символов", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        return
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
        initialParameters()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc private func handleTap() {
        fullScreenView.removeFromSuperview()
        setColorWhiteAllButton()
        if typeTask == 6 {
            if courseNumber == 1 {
                //удаление всех элементов
                self.view.subviews.forEach { $0.removeFromSuperview() }
                self.view = showKana.showKana()
            }
            RandomizeQuize()
        } else {
            if count == countQuestion - 1  {
                drawResult()
                return
            }
            progress.progress += step
            count += 1
            self.title = "\(count + 1)/\(countQuestion ?? 0)"
            if courseNumber == 0 {RandomizeQuize()}
        }
        
        if courseNumber != 0 && typeTask != 6 {
            extraTaskCourses(false)
        }
    }
    
    //Перекраска обратно в белый цвет (немного костылб)
    private func setColorWhiteAllButton() {
        for i in 1...12 {
            let buttonWithTag = self.view.viewWithTag(i) as? UIButton
            buttonWithTag?.backgroundColor = .white
            buttonWithTag?.isHidden = false
        }
        if typeTask == 5 {
            (self.view.viewWithTag(1) as? UIButton)?.setTitleColor(.red, for: .normal)
            (self.view.viewWithTag(2) as? UIButton)?.setTitleColor(UIColor(hexFromString: "#33CC66"), for: .normal)
        }
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

