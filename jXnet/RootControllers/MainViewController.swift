//
//  MainViewController.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 07.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var currentDate: UIBarButtonItem!
    @IBOutlet weak var backgoundImage: UIImageView!
    
    private var hiraganaButton: UIButton!
    private var katakanaButton: UIButton!
    private var kanjiButton: UIButton!
    private var wordButton: UIButton!
    private var phraseButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initButtons()
        self.initTags()
        self.initDate()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavigationBar()
    }
   
    private func initDate() {
        let year = Calendar.current.component(.year, from: Date())
        let mounth = Calendar.current.component(.month, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        currentDate.title = "\(year)年\(mounth)月\(day)日"
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func initTags() {
        hiraganaButton.tag = 1
        katakanaButton.tag = 2
        kanjiButton.tag = 3
        wordButton.tag = 4
        phraseButton.tag = 5
        for i in 1...5 {
            let buttonWithTag = self.view.viewWithTag(i) as? UIButton
            buttonWithTag?.addTarget(nil, action: #selector(clickTheme(_:)), for: .touchUpInside)
        }
    }
    
    private func initButtons() {
        let fontHeight = (30 * UIScreen.main.bounds.height) / 896
        hiraganaButton = BigShadowButton()
        hiraganaButton.setTitle("ХИРАГАНА (平仮名)", for: .normal)
        hiraganaButton.titleLabel?.font = .systemFont(ofSize: fontHeight)
        

        katakanaButton = BigShadowButton()
        katakanaButton.setTitle("КАТАКАНА (片仮名)", for: .normal)
        katakanaButton.titleLabel?.font = .systemFont(ofSize: fontHeight)

        kanjiButton = BigShadowButton()
        kanjiButton.setTitle("КАНДЗИ (漢字)", for: .normal)
        kanjiButton.titleLabel?.font = .systemFont(ofSize: fontHeight)

        wordButton = BigShadowButton()
        wordButton.setTitle("СЛОВА (言葉)", for: .normal)
        wordButton.titleLabel?.font = .systemFont(ofSize: fontHeight)

        phraseButton = BigShadowButton()
        phraseButton.setTitle("ФРАЗЫ (フレーズ)", for: .normal)
        phraseButton.titleLabel?.font = .systemFont(ofSize: fontHeight)
        
        view.addSubview(hiraganaButton)
        view.addSubview(katakanaButton)
        view.addSubview(kanjiButton)
        view.addSubview(wordButton)
        view.addSubview(phraseButton)
        
        hiraganaButton.translatesAutoresizingMaskIntoConstraints = false
        katakanaButton.translatesAutoresizingMaskIntoConstraints = false
        kanjiButton.translatesAutoresizingMaskIntoConstraints = false
        wordButton.translatesAutoresizingMaskIntoConstraints = false
        phraseButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let heightButtons = ((backgoundImage.frame.size.height * UIScreen.main.bounds.height) / 896 - 190) / 5
        
        NSLayoutConstraint.activate([
            hiraganaButton.topAnchor.constraint(equalTo: backgoundImage.topAnchor, constant: 5),
            hiraganaButton.heightAnchor.constraint(equalToConstant: heightButtons),
            hiraganaButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            hiraganaButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            
            katakanaButton.topAnchor.constraint(equalTo: hiraganaButton.bottomAnchor, constant: 40),
            katakanaButton.heightAnchor.constraint(equalToConstant: heightButtons),
            katakanaButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            katakanaButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            
            kanjiButton.topAnchor.constraint(equalTo: katakanaButton.bottomAnchor, constant: 40),
            kanjiButton.heightAnchor.constraint(equalToConstant: heightButtons),
            kanjiButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            kanjiButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            
            wordButton.topAnchor.constraint(equalTo: kanjiButton.bottomAnchor, constant: 40),
            wordButton.heightAnchor.constraint(equalToConstant: heightButtons),
            wordButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            wordButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            
            phraseButton.topAnchor.constraint(equalTo: wordButton.bottomAnchor, constant: 40),
            phraseButton.heightAnchor.constraint(equalToConstant: heightButtons),
            phraseButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            phraseButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
        ])

    }

    @IBAction func clickDate(_ sender: Any) {
        let alert = UIAlertController(title: currentDate.title, message: "Тут будет красивое окошко с датой", preferredStyle: .alert)
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
    
    @objc private func clickTheme(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            UserDefaults.standard.set(true, forKey: "isHiraganaTheme")
            self.performSegue(withIdentifier: "SelectKana", sender: nil)
        case 2:
            UserDefaults.standard.set(false, forKey: "isHiraganaTheme")
            self.performSegue(withIdentifier: "SelectKana", sender: nil)
        default:
            print("Working..")
        }
        
    }


}
