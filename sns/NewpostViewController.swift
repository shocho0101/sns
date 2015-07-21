//
//  NewPostViewController.swift
//  sns
//
//  Created by 張翔 on 2015/07/21.
//  Copyright (c) 2015年 sho. All rights reserved.
//

import UIKit
import Parse

class NewPostViewController: UIViewController {
    
    
    @IBOutlet var PostTextView:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //投稿を送信
    @IBAction func sendPost(){
        var post:PFObject = PFObject(className: "Posts")
        post["content"] = PostTextView.text
        post["userID"] = PFUser.currentUser()
        
        post.saveInBackground()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
