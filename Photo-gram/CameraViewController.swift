//
//  CameraViewController.swift
//  Photo-gram
//
//  Created by Lise Ho on 3/14/16.
//  Copyright © 2016 Lise Ho. All rights reserved.
//

import UIKit
import MobileCoreServices
import MBProgressHUD
import Parse
import ParseUI
class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var shown_image:UIImage? = UIImage()
   
    @IBOutlet weak var DirectionLabel: UILabel!
    @IBOutlet weak var PhotoImage: UIImageView!

    @IBOutlet weak var YesPhotoView: UIView!
    @IBOutlet weak var Caption: UITextField!
    @IBOutlet weak var PostButton: UIButton!
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        refreshview()
    }

    
   func refreshview() {
        
    // refresh view
        if shown_image!.size.width > 0 && shown_image!.size.height > 0{
            YesPhotoView.hidden = false
            PhotoImage.image = shown_image!;
            DirectionLabel.hidden = true
        }else{
            DirectionLabel.hidden = false
            YesPhotoView.hidden = true
        }

    }

    @IBAction func addPhoto(sender: AnyObject) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        vc.mediaTypes = [kUTTypeImage  as String]
        self.presentViewController(vc, animated: true, completion: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
           
            // Do something with the images (based on your use case)
            let size = CGSize(width: 700, height: 700)
             self.shown_image = resize(editedImage, newSize: size)
            self.PhotoImage.image = shown_image!;
            refreshview()
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    @IBAction func returnToHome(sender: AnyObject) {
        
        let homeController = self.storyboard?.instantiateViewControllerWithIdentifier("home_controller") as! HomeViewController
        self.presentViewController(homeController, animated: true,completion: nil)
    }

    @IBAction func postPost(sender: AnyObject) {
        //let newpost = Post()
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        var posting : Bool = false
        Post.postUserImage(shown_image, withCaption: Caption.text, withCompletion: {
            (user,error) in
            if (error == nil){
        
        MBProgressHUD.hideHUDForView(self.view, animated: true)
       // task.resume()
        let homeController = self.storyboard?.instantiateViewControllerWithIdentifier("home_controller") as! HomeViewController
        self.presentViewController(homeController, animated: true,completion: nil)
            }
        })
    

    
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
