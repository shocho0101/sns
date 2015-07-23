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
        loadData()
        
        
        if PFUser.currentUser() == nil{
            var loginAlert: UIAlertController = UIAlertController(title: "Sign UP/Login", message: "Please choose Sign UP or Login.", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            loginAlert.addAction(UIAlertAction(title: "Sign UP", style: UIAlertActionStyle.Default, handler: {
                action in
                
                let signupviewcontroller: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("signup") as! UIViewController
                
                self.presentViewController(signupviewcontroller as UIViewController, animated: true, completion: nil)
            }))
            
            loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
                action in
                let loginviewcontroller: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login") as! UIViewController
                
                self.presentViewController(loginviewcontroller as UIViewController, animated: true, completion: nil)
            }))

            
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
            
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //スクロールで更新
        var refresh = UIRefreshControl()
        refresh.addTarget(self, action: Selector("loadData"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresh
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return timelineData.count
    }
    
    //Post内容の取得
    var timelineData: NSMutableArray = NSMutableArray()
    
    func loadData(){
        timelineData.removeAllObjects()
        
        var findTimelineData:PFQuery = PFQuery(className: "Posts")
        
        findTimelineData.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                for var i = objects!.count; i > 0; --i{
                    self.timelineData.addObject(objects![i - 1])
                }
                
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
        
    }

    //セルの表示
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell

        let post: PFObject = self.timelineData.objectAtIndex(indexPath.row) as! PFObject
        
        cell.postTextView.text = post.objectForKey("content") as! String
        
        var dataFormatter: NSDateFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        cell.timestampTextLabel.text = dataFormatter.stringFromDate(post.createdAt as NSDate!)
        
        var finduser: PFQuery = PFUser.query() as PFQuery!
        finduser.whereKey("objectId", equalTo: post.objectForKey("userID")?.objectId as String!)
        
        finduser.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil{
                let user: PFUser = objects![0] as! PFUser
                cell.usernameTextLabel.text = user.username
                
            }
        }
        
        
        
        
        
        

        return cell
    }
    

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
