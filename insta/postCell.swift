//
//  postCell.swift
//  insta
//
//  Created by Andrés Arbeláez on 6/20/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Timepiece

class postCell: UITableViewCell {

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profilePic: PFImageView!
    @IBOutlet weak var usernameLabel2: UILabel!
    @IBOutlet weak var likeHeartImage: UIImageView!
    
    var hasBeenLiked = false
    
    @IBAction func onLikeTap(sender: AnyObject) {
        
        let likesCount = post!["likesCount"] as! Int
        
        if hasBeenLiked == true {
            
        } else {
            post!["likesCount"] = likesCount + 1
            heartImage.image = UIImage(named: "fullHeart")
            post!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            }
            hasBeenLiked = true
        }
        
        
        
    }
    @IBOutlet weak var postImage: PFImageView!
    var query = PFQuery(className: "Post")
    
    var postID : String?
    
    var post: PFObject?
    
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*
         let tap = UITapGestureRecognizer(target: postImage, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        postImage.addGestureRecognizer(tap)
    */
    }
    
    func doubleTapped() {
        likeHeartImage.image = UIImage(named: "fullHeart")
        //addLikes()
        //heartImage.image = UIImage(named: "fullHeart")
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: [], animations: {
            self.likeHeartImage.alpha = CGFloat(0.0)
            }, completion: nil)
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

