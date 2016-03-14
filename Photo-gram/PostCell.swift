//
//  PostCell.swift
//  Photo-gram
//
//  Created by Lise Ho on 3/13/16.
//  Copyright © 2016 Lise Ho. All rights reserved.
//

import UIKit
import Parse
import ParseUI
class PostCell: UITableViewCell {

   
    @IBOutlet weak var photoView: PFImageView!
    
    @IBOutlet weak var cellcaption: UILabel!
    
    var instagramPost: PFObject! {
        didSet {
            self.photoView.file = instagramPost["media"] as? PFFile
            self.photoView.loadInBackground()
            
            self.cellcaption.text  = instagramPost["caption"] as! String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
