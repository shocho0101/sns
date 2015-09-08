//
//  SignupViewController.swift
//  sns
//
//  Created by 張翔 on 2015/07/23.
//  Copyright (c) 2015年 sho. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var againTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextfield.secureTextEntry = true
        againTextfield.secureTextEntry = true
        // Do any additional setup after loading the view.
        
        usernameTextfield.delegate = self
        passwordTextfield.delegate  = self
        againTextfield.delegate = self
        
        
        usernameTextfield.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(){
        if usernameTextfield.text != "" && passwordTextfield != "" && againTextfield.text != ""{
            if passwordTextfield.text == againTextfield.text{
                var user: PFUser = PFUser()
                
                //textfiledに入力された内容を変数に代入
                user.username = usernameTextfield.text
                user.password = passwordTextfield.text
                
                //parseに送信
                user.signUpInBackgroundWithBlock({ (succeeded, error) -> Void in
                    if error == nil{
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }else{
                       self.alert("エラー", message: "アカウントを作成できませんでした")
                        
                    }
                })

            }else{
                //未入力の欄があるときにalertを表示
                
                alert("エラー", message: "パスワードが間違っています")
                
                passwordTextfield.text = ""
                againTextfield.text = ""
                passwordTextfield.becomeFirstResponder()

            }
        }else{
            alert("エラー", message: "未入力の欄があります")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField{
        case usernameTextfield:
            passwordTextfield.becomeFirstResponder()
        case passwordTextfield:
            againTextfield.becomeFirstResponder()
        case againTextfield:
            signup()
        default:
            println("error")
        }
        
        return false
    }
    
    func alert(title: String!, message: String!){
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okbutton: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            println("OK")
            
        })
        alert.addAction(okbutton)
        
        self.presentViewController(alert, animated: true, completion: nil)

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
