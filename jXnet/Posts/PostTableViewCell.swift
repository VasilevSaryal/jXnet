//
//  PostTableViewCell.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 21.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setConfig(isTask: Bool, isText: Bool) {
        if isTask {
            
        } else {
            if isText {
                
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
