//
//  ReviewCell.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell, Reusable {
    @IBOutlet weak var lblAuthor: UILabel!

    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var lblLikesDislikes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDefaultValues()
    }
    
    override func prepareForReuse() {
        setDefaultValues()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setDefaultValues() {
        lblAuthor.text = ""
        lblMessage.text = ""
        lblLikesDislikes.text = ""
    }

}
