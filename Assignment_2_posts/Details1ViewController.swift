//
//  Details1ViewController.swift
//  Assignment_2_posts
//
//  Created by Deepali on 24/03/24.
//

import UIKit

class Details1ViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var reactionsLabel: UILabel!
    
    
    var idContainer : Int?
    var titleContainer : String?
    var bodyContainer : String?
    var userIdContainer : Int?
    var tagsContainer : [String]?
    var reactionsContainer : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()

       
    }
    
    func bindData(){
        idLabel.text = "\(idContainer!)"
        titleLabel.text = titleContainer!
        bodyLabel.text = bodyContainer!
        userIdLabel.text = "\(userIdContainer!)"
        reactionsLabel.text = "\(reactionsContainer!)"
        
        
    }
   
}
