//
//  HotelCell.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import UIKit

protocol HotelCellDelegate {
    func favoritePressed(cell: HotelCell)
}

class HotelCell: UITableViewCell, Reusable {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblInformations: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblLikesDislikes: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var delegate: HotelCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDefaultValues()
    }
    
    override func prepareForReuse() {
        setDefaultValues()
    }

    func setDefaultValues() {
        imgView.image = nil
        lblInformations.text = ""
        lblDescription.text = ""
        lblLikesDislikes.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func favoriteAction(_ sender: Any) {
        delegate?.favoritePressed(cell: self)
    }

}
