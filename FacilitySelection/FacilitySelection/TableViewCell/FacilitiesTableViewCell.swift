//
//  FacilitiesTableViewCell.swift
//  FacilitySelection
//
//  Created by Richa Kalani on 28/06/23.
//

import UIKit

class FacilitiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    static let facilitiesTableViewCellId = "FacilitiesTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
