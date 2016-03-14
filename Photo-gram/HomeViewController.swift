//
//  HomeViewController.swift
//  Photo-gram
//
//  Created by Lise Ho on 3/13/16.
//  Copyright © 2016 Lise Ho. All rights reserved.
//

import UIKit
import Parse
import ParseUI
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var posts: [PFObject]! = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func go_post(sender: AnyObject) {
        
        let cameraController = self.storyboard?.instantiateViewControllerWithIdentifier("camera_controller") as! CameraViewController
        self.presentViewController(cameraController, animated: true,completion: nil)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
        
    }
    @IBAction func logout(sender: AnyObject) {
        
        PFUser.logOut()
        print ("logged Out")
        print (PFUser.currentUser())
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("login_controller") as! LogInViewController
        self.presentViewController(viewController, animated: true,completion: nil)
        //self.storyboard.rootViewController = viewController
        // PFUser.currentUser() will now be nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //self.tableView.reloadData()
        
        // show last 20 poprint ("ASDFADSF")
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            print (error)
            if let posts = posts  {
                // do something with the data fetched
                    self.posts = posts as [PFObject]
                    self.tableView.reloadData()
            } else {
                // handle error
                
            }
        }
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.posts!.count > 0{
            //print (self.posts!.count)
            return self.posts!.count
        }else{
            //print ("posts array is empty")
            return 0
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postcell", forIndexPath: indexPath) as! PostCell
        
        let p = self.posts[indexPath.row] as PFObject
        
        cell.instagramPost = p
        
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
