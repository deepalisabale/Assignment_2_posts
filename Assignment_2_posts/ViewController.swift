//
//  ViewController.swift
//  Assignment_2_posts
//
//  Created by Deepali on 24/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var PostTableView: UITableView!
    
    var uiNib : UINib?
    var postTableViewCell : PostTableViewCell?
    private var postTableViewCellIdentifier = "PostTableViewCell"
    var postDetailsViewController : Details1ViewController?
    var postDetailsViewControllerIdentifier = "Details1ViewController"
    
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var posts : [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        jsonSerialization()
        initialzeTableView()
        registerXIBWithTableViewCell()
    }
    
    
    func initialzeTableView(){
        
        PostTableView.dataSource = self
        PostTableView.delegate = self
    }
    
    func registerXIBWithTableViewCell(){
        let uiNIb = UINib(nibName: "PostTableViewCell" , bundle: nil)
        self.PostTableView.register(uiNIb, forCellReuseIdentifier: "PostTableViewCell")
        
        
    }

     func jsonSerialization(){

        url = URL(string: "https://dummyjson.com/posts")
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        urlSession = URLSession(configuration: .default)


        let dataTask1 = urlSession?.dataTask(with: urlRequest!)
        {
            data, response, error
            
            in

            let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [String: Any]

            let posts = jsonResponse["posts"] as!
            [[String: Any]]

            for post in posts{
                let id =  post["id"] as! Int
                let title = post["title"] as! String
                let body = post["body"] as! String
                let userId = post["userId"] as! Int
                let tags = post["tags"] as! [String]
                let reactions = post["reactions"] as! Int
                
                
                let eachPostObject = Post(id: id, title: title, body: body, userId: userId, tags: tags , reactions: reactions)
                self.posts.append(eachPostObject)
                
            }
            
            DispatchQueue.main.async {
                self.PostTableView.reloadData()
            }

            print(jsonResponse)
    }
      
        dataTask1?.resume()
       
    }
           
}
    

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        postTableViewCell = (self.PostTableView.dequeueReusableCell(withIdentifier: postTableViewCellIdentifier, for: indexPath) as! PostTableViewCell)
        postTableViewCell?.idLabel.text = String(posts[indexPath.row].id)
        postTableViewCell?.titleLabel.text = posts[indexPath.row].title
        postTableViewCell?.bodyLabel.text = posts[indexPath.row].body
        postTableViewCell?.userIdLabel.text = String(posts[indexPath.row].userId)
        postTableViewCell?.reactionaLabel.text = String(posts[indexPath.row].reactions)
        
        return postTableViewCell!
    }
    
    
    
}

extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postDetailsViewController = (self.storyboard?.instantiateViewController(withIdentifier: postDetailsViewControllerIdentifier) as! Details1ViewController)
        postDetailsViewController?.idContainer = posts[indexPath.row].id
        postDetailsViewController?.titleContainer = posts[indexPath.row].title
        postDetailsViewController?.bodyContainer = posts[indexPath.row].body
        postDetailsViewController?.userIdContainer = posts[indexPath.row].userId
        postDetailsViewController?.reactionsContainer = posts[indexPath.row].reactions
        navigationController?.pushViewController(postDetailsViewController!, animated: true)

        
    }
}



