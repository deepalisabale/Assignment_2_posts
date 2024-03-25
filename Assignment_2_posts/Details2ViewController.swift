//
//  Details2ViewController.swift
//  Assignment_2_posts
//
//  Created by Deepali on 24/03/24.
//

import UIKit

class Details2ViewController: UIViewController {
    
    @IBOutlet weak var postIdLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var postUserIdLabel: UILabel!
    @IBOutlet weak var postReactionsLabel: UILabel!
    
    
    var idContainer : Int?
    var titleContainer : String?
    var bodyContainer : String?
    var userIdContainer : Int?
    var tagsContainer : [String]?
    var reactionsContainer : Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postIdLabel.text = "\(idContainer!)"
        postTitleLabel.text = titleContainer!
        postBodyLabel.text = bodyContainer!
        postUserIdLabel.text = "\(userIdContainer!)"
       postReactionsLabel.text = "\(reactionsContainer!)"
    }
    

  

}
