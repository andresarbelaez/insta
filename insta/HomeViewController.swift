//
//  HomeViewController.swift
//  insta
//
//  Created by Andrés Arbeláez on 6/19/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addPhoto: UIButton!
    @IBAction func onSubmit(sender: AnyObject) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Post.postUserImage(imageToPost, withCaption: captionField.text) { (success: Bool, error: NSError?) in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.performSegueWithIdentifier("afterSubmit", sender: nil)
        }
    }
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var previewImage: UIImageView!
    var imageToPost: UIImage?
    
    @IBOutlet weak var captionField: UITextField!
    let vc = UIImagePickerController()
    
    @IBAction func onCaptureButton(sender: AnyObject) {
        
        
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func onLogOut(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
            // PFUser.currentUser() will now be nil
            
            self.performSegueWithIdentifier("backToLogin", sender: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addPhoto.layer.cornerRadius = 10
    }
    
    
    func imagePickerController(picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        imageToPost = editedImage
        previewImage.image = imageToPost
        addButton.alpha = 0.0
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
