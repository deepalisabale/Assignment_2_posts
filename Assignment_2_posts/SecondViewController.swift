//
//  SecondViewController.swift
//  Assignment_2_posts
//
//  Created by Deepali on 24/03/24.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    @IBOutlet weak var postCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var postCollectionViewCell : PostCollectionViewCell?
    private var postCollectionViewCellIdentifier = "PostCollectionViewCell"
    var postDetailsViewController : Details2ViewController?
    var postDetailsViewControllerIdentifier = "Details2ViewController"
    var uiNib : UINib?
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var posts : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCollectionView()
       registerXIBWithCollectionViewCell()
        jsonSerialization()
    }
    
    func initializeCollectionView(){
        postCollectionView.dataSource = self
        postCollectionView.delegate = self
    }
    
    func registerXIBWithCollectionViewCell(){
        let uiNIb = UINib(nibName: "PostCollectionViewCell", bundle: nil)
        self.postCollectionView.register(uiNIb, forCellWithReuseIdentifier: "PostCollectionViewCell")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        postCollectionViewFlowLayout.scrollDirection = .vertical
        postCollectionViewFlowLayout.minimumInteritemSpacing = 0
        postCollectionViewFlowLayout.minimumLineSpacing = 5.0
    }
    func jsonSerialization(){

       url = URL(string: "https://dummyjson.com/posts")
       urlRequest = URLRequest(url: url!)
       urlRequest?.httpMethod = "GET"
       urlSession = URLSession(configuration: .default)

       let dataTask1 = urlSession?.dataTask(with: urlRequest!)
       {
           data, response, error in
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
               self.postCollectionView.reloadData()
           }
           print(jsonResponse)
   }
       dataTask1?.resume()
      
   }
          
}
extension SecondViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        postCollectionViewCell = (self.postCollectionView.dequeueReusableCell(withReuseIdentifier: postCollectionViewCellIdentifier, for: indexPath)as! PostCollectionViewCell)
        postCollectionViewCell?.postIdLabel.text = String(posts[indexPath.row].id)
        postCollectionViewCell?.postTitleLabel.text = posts[indexPath.row].title
        postCollectionViewCell?.postBodyLabel.text = posts[indexPath.row].body
        postCollectionViewCell?.postUserIdLabel.text = String(posts[indexPath.row].userId)
        postCollectionViewCell?.postReactionsLabel.text = String(posts[indexPath.row].reactions)
        return postCollectionViewCell!
    }
}
extension SecondViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        postDetailsViewController = (self.storyboard?.instantiateViewController(withIdentifier: postDetailsViewControllerIdentifier)as! Details2ViewController)
        postDetailsViewController?.idContainer = posts[indexPath.row].id
        postDetailsViewController?.titleContainer = posts[indexPath.row].title
        postDetailsViewController?.bodyContainer = posts[indexPath.row].body
        postDetailsViewController?.userIdContainer = posts[indexPath.row].userId
        postDetailsViewController?.reactionsContainer = posts[indexPath.row].reactions
        navigationController?.pushViewController(postDetailsViewController!, animated: true)
    }
}

extension SecondViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        postCollectionViewCell?.backgroundColor = .gray
        return CGSize(width: 410.0, height: 300.0)
        var totalWidth = self.postCollectionView.bounds.size.width
        var numberOfCellsInARow = posts.count
        var evenOdd = (indexPath.row)/(numberOfCellsInARow) % 2
    }
}
