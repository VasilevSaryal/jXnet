//
//  MainViewController.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 07.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var levelProgress: UIProgressView!
    @IBOutlet weak var currentDate: UIBarButtonItem!
    @IBOutlet weak var backgoundImage: UIImageView!
    @IBOutlet weak var showLevel: UIBarButtonItem!
    private var kanaButton: UIButton!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initProgress()
    }
   
    private func initDate() {
        let year = Calendar.current.component(.year, from: Date())
        let mounth = Calendar.current.component(.month, from: Date())
        let day = Calendar.current.component(.day, from: Date())
        currentDate.title = "\(year)年\(mounth)月\(day)日"
    }
    
    private func initProgress() {
        self.showLevel.title = "\(UserDefaults.standard.integer(forKey: "userLevel"))"
        self.levelProgress.progress = Float(UserDefaults.standard.integer(forKey: "userExperience")) / Float(UserDefaults.standard.integer(forKey: "nextLevel"))
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = true
        //self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func initTags() {
        kanaButton.tag = 1
        kanjiButton.tag = 2
        wordButton.tag = 3
        phraseButton.tag = 4
        for i in 1...4 {
            let buttonWithTag = self.view.viewWithTag(i) as? UIButton
            buttonWithTag?.addTarget(nil, action: #selector(clickTheme(_:)), for: .touchUpInside)
        }
    }
    
    private func initButtons() {
        let fontHeight = (30 * UIScreen.main.bounds.height) / 896

        kanaButton = BigShadowButton()
        kanaButton.setTitle("АЗБУКА КАНА (かな)", for: .normal)
        kanaButton.titleLabel?.font = .systemFont(ofSize: fontHeight)

        kanjiButton = BigShadowButton()
        kanjiButton.setTitle("КАНДЗИ (漢字)", for: .normal)
        kanjiButton.titleLabel?.font = .systemFont(ofSize: fontHeight)

        wordButton = BigShadowButton()
        wordButton.setTitle("СЛОВА (言葉)", for: .normal)
        wordButton.titleLabel?.font = .systemFont(ofSize: fontHeight)

        phraseButton = BigShadowButton()
        phraseButton.setTitle("ФРАЗЫ (フレーズ)", for: .normal)
        phraseButton.titleLabel?.font = .systemFont(ofSize: fontHeight)
        
        view.addSubview(kanaButton)
        view.addSubview(kanjiButton)
        view.addSubview(wordButton)
        view.addSubview(phraseButton)
        
        
        
        let heightButtons = CGFloat(60)
        let widthButtons = (UIScreen.main.bounds.width - 40)
        kanaButton.frame = CGRect(x: 20, y: self.topbarHeight + 10, width: widthButtons, height: heightButtons)
        kanjiButton.frame = CGRect(x: 20, y: kanaButton.frame.maxY + 40, width: widthButtons, height: heightButtons)
        wordButton.frame = CGRect(x: 20, y: kanjiButton.frame.maxY + 40, width: widthButtons, height: heightButtons)
        phraseButton.frame = CGRect(x: 20, y: wordButton.frame.maxY + 40, width: widthButtons, height: heightButtons)

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
            self.performSegue(withIdentifier: "SelectKana", sender: nil)
        default:
            print("Working..")
        }
        
    }


}
