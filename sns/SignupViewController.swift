//
//  SignupViewController.swift
//  sns
//
//  Created by 張翔 on 2015/07/23.
//  Copyright (c) 2015年 sho. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {
    
    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var againTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextfield.secureTextEntry = true
        againTextfield.secureTextEntry = true
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(){
        if usernameTextfield.text != nil && passwordTextfield != nil && againTextfield.text != nil{
            if passwordTextfield.text == againTextfield.text{
                var user: PFUser = PFUser()
                
                //textfiledに入力された内容を変数に代入
                user.username = usernameTextfield.text
                user.password = passwordTextfield.text
                
                //parseに送信
                user.signUpInBackgroundWithBlock({ (succeeded, error) -> Void in
                    if error == nil{
                        println("successsss")
//                        let timelinetableviewcontroller: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("timeline") as! UIViewController
//                        self.presentViewController(timelinetableviewcontroller, animated: true, completion: nil)
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }else{
                        println(error)
                    }
                })

            }
        }
    }
    
    @IBAction func cancel(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
