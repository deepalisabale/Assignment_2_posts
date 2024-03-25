//
//  PostCollectionViewCell.swift
//  Assignment_2_posts
//
//  Created by Deepali on 24/03/24.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var postIdLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var postUserIdLabel: UILabel!
    @IBOutlet weak var postReactionsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
