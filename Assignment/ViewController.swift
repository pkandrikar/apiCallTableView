//
//  ViewController.swift
//  Assignment
//
//  Created by Piyush on 3/1/22.
//

import UIKit



class ViewController: UIViewController, userSelectDelegate {

    @IBOutlet weak var text_name: UITextField!
    @IBOutlet weak var text_email: UITextField!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmTapped(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController{
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func userSelected(user: User) {
        text_name.text = user.first_name + " " + user.last_name
        text_email.text = user.email
        
        let url = URL(string: user.avatar)!
        self.indicator.isHidden = false
        
        let task = URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
                        if let data = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                self.avatar.image = UIImage(data: data)
                                self.indicator.isHidden = true
                            }
                        }
                    })
        task.resume()
    }


}

