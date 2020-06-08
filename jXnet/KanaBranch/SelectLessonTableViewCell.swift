//
//  SelectLessonTableViewCell.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 07.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import UIKit

class SelectLessonTableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var subSubject: UILabel!
    @IBOutlet weak var proccess: UILabel!
    @IBOutlet weak var info: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        info.tintColor = .white
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
