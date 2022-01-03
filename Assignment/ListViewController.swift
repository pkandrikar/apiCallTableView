//
//  ListViewController.swift
//  Assignment
//
//  Created by Sahil Saharkar on 3/1/22.
//

import UIKit

protocol userSelectDelegate {
    func userSelected(user: User)
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userTable: UITableView!
    var users:[User] = []
    
    let imageCache = NSCache<NSString, UIImage>()
    
    var delegate: userSelectDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        initTable()
        // Do any additional setup after loading the view.
        getDataFromAPI()
    }
    
    func initTable(){
//        userTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        userTable.delegate = self
        userTable.dataSource = self
    }
    
    func getDataFromAPI(){
        guard let url = URL(string: "https://reqres.in/api/users?per_page=12") else {
                    print("Invalid url...")
                    return
                }
                URLSession.shared.dataTask(with: url) { data, response, error in
                    let userAPIResponse = try! JSONDecoder().decode(UserAPIResponse.self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.users = userAPIResponse.data
                        self.reloadData()
                    }
                }.resume()
    }
    
    func reloadData(){
        userTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return users.count
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserTableViewCell
        cell.label_name.text = users[indexPath.row].first_name + " " + users[indexPath.row].last_name
        cell.label_email.text = users[indexPath.row].email
        
        
        
            let url = URL(string: self.users[indexPath.row].avatar)!
            
            if let cachedImage = self.imageCache.object(forKey: NSString(string: self.users[indexPath.row].avatar)) {
                DispatchQueue.main.async {
                    cell.avatar.image = cachedImage
                }
            }else{
                let task = URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
                                if let data = try? Data(contentsOf: url) {
                                    let img: UIImage! = UIImage(data: data)
                                    self.imageCache.setObject(img, forKey: self.users[indexPath.row].avatar as NSString)
                                    DispatchQueue.main.async {
                                        cell.avatar.image = UIImage(data: data)
                                    }
                                }
                            })
                task.resume()
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.userSelected(user: users[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
    }

}
