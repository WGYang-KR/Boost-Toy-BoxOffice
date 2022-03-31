//
//  CommentTableViewCell.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/03/31.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var starRatingView: UIView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
