//
//  TimelineTableViewController.swift
//  sns
//
//  Created by 張翔 on 2015/07/21.
//  Copyright (c) 2015年 sho. All rights reserved.
//

import UIKit
import Parse

class TimelineTableViewController: UITableViewController {
    
    //アプリ起動時のログインアラート
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() == nil{
            var loginAlert: UIAlertController = UIAlertController(title: "Sign UP/IN", message: "Please sign up or login", preferredStyle: UIAlertControllerStyle.Alert)
            
            //ユーザーネームとパスワードの入力欄
            loginAlert.addTextFieldWithConfigurationHandler({ (username:UITextField!) -> Void in
                username.placeholder = "user name"
            })
            loginAlert.addTextFieldWithConfigurationHandler({ (password:UITextField!) -> Void in
                password.placeholder = "password"
                password.secureTextEntry = true
            })
            
            loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
                action in
                //textfieldの取得
                let textfields: [UITextField] = loginAlert.textFields as! [UITextField]
                let usernameTextfield: UITextField = textfields[0]
                let passwordTextfield: UITextField = textfields[1]
                
                var user: PFUser = PFUser()
                
                //textfiledに入力された内容を変数に代入
                user.username = usernameTextfield.text
                user.password = passwordTextfield.text
                
                //parseに送信
                user.signUpInBackgroundWithBlock({ (succeeded, error) -> Void in
                    if error == nil{
                        println("success")
                    }else{
                        println(error)
                    }
                })
                
                
                
            }))
            
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
