//
//  StatisticsTableViewCell.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 18.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {
    
    let trackView = UIView()
    let fillView = UIView()
    let percentLabel = UILabel()
    let kanaLabel = UILabel()
    let transcriptionLabel = UILabel()
    let soundButton = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setConfig(kana: String, transcription: String, shortLearner: Int, deepLearned: Int, mnemonics: String) {
        
        kanaLabel.text = kana
        kanaLabel.frame = CGRect(x: 20, y: 5, width: 35, height: 35)
        kanaLabel.textAlignment = .center
        kanaLabel.font = .systemFont(ofSize: 32)
        kanaLabel.sizeToFit()
        contentView.addSubview(kanaLabel)
        
        transcriptionLabel.text = transcription
        transcriptionLabel.frame = CGRect(x: 20, y: 40, width: kanaLabel.frame.size.width, height: 20)
        transcriptionLabel.textAlignment = .center
        contentView.addSubview(transcriptionLabel)
        
        soundButton.setImage(UIImage(named: "sound"), for: .normal)
        soundButton.frame = CGRect(x: kanaLabel.frame.maxX + 8, y: 20, width: 20, height: 20)
        contentView.addSubview(soundButton)
        
     
        let value = (((Float(shortLearner) + Float(deepLearned)) / 350.0) * 100)
        
            percentLabel.text = "\((shortLearner + deepLearned) * 100 / 350)%"
        
        percentLabel.frame = CGRect(x: UIScreen.main.bounds.width - 50, y: 20, width: 20, height: 20)
        percentLabel.sizeToFit()
        contentView.addSubview(percentLabel)
        
        if (value >= 100) {
            trackView.backgroundColor = UIColor(hexFromString: "#DE6FA1")
        } else {
            trackView.backgroundColor = UIColor(white: 0.90, alpha: 1)
        }
        trackView.frame = CGRect(x: soundButton.frame.maxX + 3, y: 20, width: UIScreen.main.bounds.width - 56 - soundButton.frame.maxX, height: 20)
        trackView.layer.cornerRadius = 8
        contentView.addSubview(trackView)
        
        var stretch = 0.0
        if (value >= 100) {
            fillView.backgroundColor = UIColor(hexFromString: "#FF3300")
            stretch = Double(value - 100) / 100
        } else {
            stretch = Double(value) / 100
            fillView.backgroundColor = UIColor(hexFromString: "#DE6FA1")
        }
        fillView.frame = CGRect(x: soundButton.frame.maxX + 3, y: 20, width: (UIScreen.main.bounds.width - 46 - soundButton.frame.maxX) * CGFloat(stretch), height: 20)
        fillView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 8)
        contentView.addSubview(fillView)
    }
    
    func setConfigForResult(kana: String, transcription: String, shortLearner: Int, deepLearned: Int, score: Int) {
        
        kanaLabel.text = kana
        kanaLabel.frame = CGRect(x: 20, y: 5, width: 35, height: 35)
        kanaLabel.textAlignment = .center
        kanaLabel.font = .systemFont(ofSize: 32)
        kanaLabel.sizeToFit()
        contentView.addSubview(kanaLabel)
        
        transcriptionLabel.text = transcription
        transcriptionLabel.frame = CGRect(x: 20, y: 40, width: kanaLabel.frame.size.width, height: 20)
        transcriptionLabel.textAlignment = .center
        contentView.addSubview(transcriptionLabel)
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .percent
        let value = (((Float(shortLearner) + Float(deepLearned)) / 350.0) * 100)
        if let formattedString = formatter.string(for: value) {
            percentLabel.text = formattedString
        }
        percentLabel.frame = CGRect(x: UIScreen.main.bounds.width - 50, y: 20, width: 20, height: 20)
        percentLabel.sizeToFit()
        contentView.addSubview(percentLabel)
        
        if (value >= 100) {
            trackView.backgroundColor = UIColor(hexFromString: "#DE6FA1")
        } else {
            trackView.backgroundColor = UIColor(white: 0.90, alpha: 1)
        }
        trackView.frame = CGRect(x: soundButton.frame.maxX + 3, y: 20, width: UIScreen.main.bounds.width - 56 - soundButton.frame.maxX, height: 20)
        trackView.layer.cornerRadius = 8
        contentView.addSubview(trackView)
        
        var stretch = 0.0
        if (value >= 100) {
            fillView.backgroundColor = UIColor(hexFromString: "#FF3300")
            stretch = Double(value - 100) / 100
        } else {
            stretch = Double(value) / 100
            fillView.backgroundColor = UIColor(hexFromString: "#DE6FA1")
        }
        fillView.frame = CGRect(x: soundButton.frame.maxX + 3, y: 20, width: (UIScreen.main.bounds.width - 46 - soundButton.frame.maxX) * CGFloat(stretch), height: 20)
        fillView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 8)
        contentView.addSubview(fillView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
