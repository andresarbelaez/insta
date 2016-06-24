//
//  DetailViewController.swift
//  insta
//
//  Created by Andrés Arbeláez on 6/21/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD

class DetailViewController: UIViewController {
    
    @IBOutlet weak var profilePic: PFImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!

    @IBOutlet weak var usernameLabel2: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    var post: PFObject!
    var hasBeenLiked = false
    var user = PFUser()

    @IBAction func onLike(sender: AnyObject) {
        
        if hasBeenLiked == true {
            heartImage.image = UIImage(named: "fullHeart")
        } else {
            heartImage.image = UIImage(named: "fullHeart")
            
            let likesCount = post!["likesCount"] as! Int
            
            post!["likesCount"] = likesCount + 1
            
            loadData()
            if let likes = post["likesCount"]{
                likesLabel.text = "\(likes)"
            }
            
            post!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            }
            hasBeenLiked = true
        }
        
    }
    @IBOutlet weak var likeHeartImage: UIImageView!
    @IBOutlet weak var heartImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.likeHeartImage.image = UIImage(named: "fullHeart")
        
        //navigationController!.navigationBar.barTintColor = UIColor.blackColor()
        //navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.greenColor()]
        //navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor.whiteColor()
        
        loadData()
        
        let tappy = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapped))
        
        tappy.numberOfTapsRequired = 2
        view.addGestureRecognizer(tappy)
        
        
    }
    
    func loadData(){
        let caption = post["caption"] as! String
        self.captionLabel.text = caption
        
        let parsedImage = post["media"] as? PFFile
        self.postImage.file = parsedImage
        self.postImage.loadInBackground()
        
        if let likes = post["likesCount"]{
            likesLabel.text = "\(likes)"
        }
        
        
        if let username = post["author"].username {
            usernameLabel.text = username
            usernameLabel2.text = username
        }
        
        if let user = post["author"] {
            print(user)
            self.user = user as! PFUser
            if let profilePic = self.user["profilePic"]{
                print(profilePic)
                self.profilePic.file = profilePic as? PFFile
                self.profilePic.layer.cornerRadius = self.profilePic.frame.size.height / 2
                self.profilePic.layer.masksToBounds = true
                self.profilePic.layer.borderWidth = 0
                self.profilePic.loadInBackground()
            }
        }
        
        
        if let timestamp = post.createdAt {
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            var dateString = dateFormatter.stringFromDate(timestamp)
            print(dateString)
        
            
            if timestamp > 1.minute.ago{
                print("this was posted less than a minute ago")
                dateLabel.text = "1 minute ago"
            }else if timestamp > 2.minute.ago{
                dateLabel.text = "2 minutes ago"
            } else if timestamp > 3.minute.ago{
                dateLabel.text = "3 minutes ago"
            } else if timestamp > 4.minute.ago{
                dateLabel.text = "4 minutes ago"
            } else if timestamp > 5.minute.ago{
                dateLabel.text = "5 minutes ago"
            } else if timestamp > 6.minute.ago{
                dateLabel.text = "6 minutes ago"
            } else if timestamp > 7.minute.ago{
                dateLabel.text = "7 minutes ago"
            } else if timestamp > 8.minute.ago{
                dateLabel.text = "8 minutes ago"
            } else if timestamp > 9.minute.ago{
                dateLabel.text = "9 minute ago"
            } else if timestamp > 10.minute.ago{
                dateLabel.text = "10 minute ago"
            } else if timestamp > 1.hour.ago {
                print("this was posted less than an hour ago")
                dateLabel.text = "1 hour ago"
            } else if timestamp > 2.hour.ago {
                print("this was posted less than an hour ago")
                dateLabel.text = "2 hours ago"
            } else if timestamp > 3.hour.ago {
                print("this was posted less than an hour ago")
                dateLabel.text = "3 hours ago"
            } else if timestamp > 4.hour.ago {
                print("this was posted less than an hour ago")
                dateLabel.text = "4 hours ago"
            } else if timestamp > 5.hour.ago {
                print("this was posted less than an hour ago")
                dateLabel.text = "5 hours ago"
            } else if timestamp > 6.hour.ago {
                print("this was posted less than an hour ago")
                dateLabel.text = "6 hours ago"
            } else if timestamp > 7.hour.ago {
                print("this was posted less than an hour ago")
                dateLabel.text = "7 hours ago"
            } else if timestamp > 8.hour.ago {
                print("this was posted less than an hour ago")
                dateLabel.text = "8 hours ago"
            } else if timestamp > 9.hour.ago {
                print("this was posted less than an hour ago")
                dateLabel.text = "9 hours ago"
            } else if timestamp > 1.day.ago{
                dateLabel.text = "1 day ago"
            } else {
                
            }
            
        }

    }
    
    func doubleTapped(){
        
        self.heartImage.image = UIImage(named: "fullHeart")
        
        self.likeHeartImage.image = UIImage(named: "whiteHeart")
        UIView.animateWithDuration(0.5, delay: 0.5, options: [], animations: {
            self.likeHeartImage.alpha = CGFloat(0.0)
            }, completion: nil)
        
        if hasBeenLiked == true {
            
        } else {
            let likesCount = post!["likesCount"] as! Int
            
            post!["likesCount"] = likesCount + 1
            
            post!["hasBeenLiked"] = "true"
            
            post!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            }
            hasBeenLiked = true
        }
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let profileViewController = segue.destinationViewController as! ProfileViewController
        
        
        let button = sender as! UIButton
        
        let post = posts[button.tag]
        
        profileViewController.sourcePost = post
        
        profileViewController.cellHasRequestedProfile = true
    }
 */
    

}
