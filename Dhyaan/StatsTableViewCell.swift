//
//  StatsTableViewCell.swift
//  Dhyaan
//
//  Created by Shreya Zala on 6/23/22.
//

import UIKit

class StatsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sessionDateLbl: UILabel!
    @IBOutlet weak var sessionDurationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
