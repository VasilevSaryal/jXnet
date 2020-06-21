//
//  SelectKanaViewController.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 21.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class SelectKanaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        setTheme()
        self.view.backgroundColor = UIColor(white: 0.93, alpha: 1)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func info(_ sender: Any) {
    }
    
    private func setNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.view.backgroundColor = .darkGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
    }

    private func setTheme() {
        let widthImages = (UIScreen.main.bounds.width - 40)
        let heightImages = 465 * widthImages / 770
        
        let hiragana = UIImageView(frame: CGRect(x: 20, y: self.topbarHeight + 40, width: widthImages, height: heightImages))
        hiragana.contentMode = .scaleAspectFit
        hiragana.image = UIImage(named: "Table_hiragana")
        
        let katakana = UIImageView(frame: CGRect(x: 20, y: hiragana.frame.maxY + 40, width: widthImages, height: heightImages))
        katakana.contentMode = .scaleAspectFit
        katakana.image = UIImage(named: "Table_katakana")
        
        let hiraganaTitle = UIImageView(frame: CGRect(x: 20, y: hiragana.frame.minY, width: widthImages, height: heightImages))
        hiraganaTitle.contentMode = .scaleToFill
        hiraganaTitle.image = UIImage(named: "gradient")
        hiraganaTitle.image = hiraganaTitle.image?.alpha(0.5)
        
        let katakanaTitle = UIImageView(frame: CGRect(x: 20, y: katakana.frame.minY, width: widthImages, height: heightImages))
        katakanaTitle.contentMode = .scaleToFill
        katakanaTitle.image = UIImage(named: "gradient")
        katakanaTitle.image = katakanaTitle.image?.alpha(0.5)
        
        let hiraganaButton = UIButton(frame: CGRect(x: 20, y: hiragana.frame.maxY - 60, width: widthImages, height: 60))
        hiraganaButton.setTitle("Хирагана", for: .normal)
        hiraganaButton.setTitleColor(.white, for: .normal)
        hiraganaButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        hiraganaButton.tag = 1
        hiraganaButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        let katakanaButton = UIButton(frame: CGRect(x: 20, y: katakana.frame.maxY - 60, width: widthImages, height: 60))
        katakanaButton.setTitle("Катакана", for: .normal)
        katakanaButton.setTitleColor(.white, for: .normal)
        katakanaButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        katakanaButton.tag = 2
        katakanaButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        
        self.view.addSubview(hiragana)
        self.view.addSubview(katakana)
        self.view.addSubview(hiraganaTitle)
        self.view.addSubview(katakanaTitle)
        self.view.addSubview(hiraganaButton)
        self.view.addSubview(katakanaButton)
        
    }
    
    @objc func buttonTapped(_ sender: UIButton)
    {
        if sender.tag == 1 {
            UserDefaults.standard.set(true, forKey: "isHiraganaTheme")
        } else {
            UserDefaults.standard.set(false, forKey: "isHiraganaTheme")
        }
        self.performSegue(withIdentifier: "SelectedKana", sender: nil)
    }

}
