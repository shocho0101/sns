//
//  loginViewController.swift
//  sns
//
//  Created by 張翔 on 2015/07/23.
//  Copyright (c) 2015年 sho. All rights reserved.
//

import UIKit
import Parse

class loginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        
        passwordTextfield.secureTextEntry = true
        usernameTextfield.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(){
        
        if usernameTextfield.text != "" && passwordTextfield != ""{
            var user: PFUser = PFUser()
            
            //textfiledに入力された内容を変数に代入
            user.username = usernameTextfield.text
            user.password = passwordTextfield.text
            
            //parseに送信
            PFUser.logInWithUsernameInBackground(usernameTextfield.text, password: passwordTextfield.text, block: { (user, error) -> Void in
                if error == nil{
                    self.dismissViewControllerAnimated(true, completion: nil)
                }else{
                    let alert: UIAlertController = UIAlertController(title: "エラー", message: "ユーザー名かパスワードが間違っています。", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let okbutton: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
                        println("OK")
                    })
                    alert.addAction(okbutton)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
                
            })
        }else{
            //未入力の欄がある場合にalertを表示
            let alert: UIAlertController = UIAlertController(title: "エラー", message: "ユーザー名とパスワードを入力してください。", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okbutton: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
                println("OK")
            })
            alert.addAction(okbutton)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField{
        case usernameTextfield:
            passwordTextfield.becomeFirstResponder()
        case passwordTextfield:
            login()
        default:
            println("textfiedldshuldreturn error")
        }
    
    return false
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
