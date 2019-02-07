//
//  DamageViewCell.swift
//  mfp-Insurance
//
//  Created by Vittal Pai on 07/02/19.
//  Copyright © 2019 Vittal Pai. All rights reserved.
//

import UIKit

class DamageViewCell: UITableViewCell, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
