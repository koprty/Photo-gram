//
//  LogInViewController.swift
//  Photo-gram
//
//  Created by Lise Ho on 3/13/16.
//  Copyright © 2016 Lise Ho. All rights reserved.
//

import UIKit
import Parse
class LogInViewController: UIViewController {

    @IBOutlet weak var signout_button: UIButton!
    @IBOutlet weak var signin_button: UIButton!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sign_In(sender: AnyObject) {
        
        
        let username1 = username.text ?? ""
        let password = pwd.text ?? ""
        
        PFUser.logInWithUsernameInBackground(username1, password: password) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                print("User login failed.")
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                // display view controller that needs to shown after successful login
            }
        }
        
        
    }
    @IBAction func sign_Out(sender: AnyObject) {
        
        // haha... um this function is named inappropriately... THIS IS THE SIGN UP FUNCTION.....
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = username.text
        //newUser.email = " "
        newUser.password = pwd.text
        
        // call sign up function on the object
        if (newUser.username?.characters.count > 0 && newUser.username?.characters.count > 0){
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                if error.code == 202{
                    print ("USERNAME TAKEN");
                }
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)

                // manually segue to logged in view
            }
        }
        }
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
