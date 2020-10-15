//
//  FeedViewController.swift
//  instagram
//
//  Created by Mobin Uddin Chowdhury on 10/14/20.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(newPostCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        
        
        query.findObjectsInBackground{ (posts,error) in
            if posts != nil {
                self.posts = posts!
                print(posts!.count)
                self.tableView.reloadData()
            }
            
            
            
        }
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let  cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! newPostCell
       // cell.textLabel?.text = "vj sjhw hv wj"
        
       let post = posts[indexPath.row]
//
 //       let user = post["author"] as! PFUser
//        cell.usernameLabel.text = user.username
//
//
//        cell.captionLabel.text = post["caption"] as! String
//
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!

        //cell.photoView.af_setImage(withURL: url)
    
        let user = post["author"] as! PFUser
        cell.nameLabel.text = user.username
        cell.postImageView.af_setImage(withURL: url)
               cell.postLabel.text = post["caption"] as! String
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



class newPostCell : UITableViewCell {
    
    var postImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
    
        return imageView
    }()
    
    var nameLabel : UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    var postLabel : UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpView()
    }
    
    
    func setUpView(){
        
        let substackview = UIStackView(arrangedSubviews: [nameLabel,postLabel])
        substackview.axis = .horizontal
        substackview.spacing = 10
        let stackView = UIStackView(arrangedSubviews: [postImageView ,substackview])

        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
       stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        substackview.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //postLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
}
