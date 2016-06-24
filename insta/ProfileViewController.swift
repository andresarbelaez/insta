//
//  ProfileViewController.swift
//  insta
//
//  Created by Andrés Arbeláez on 6/22/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parsedPosts: [PFObject] = []
    
    var imageToPost: UIImage?
    
    var sourcePost : PFObject!
    
    var cellHasRequestedProfile = false
    
    var userInfo: [PFObject] = []
    
    var user = PFUser.currentUser()
    
    let vc = UIImagePickerController()
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    
    @IBAction func onAddPicture(sender: AnyObject) {
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func onPost(sender: AnyObject) {
        postProfilePicture()

    }

    @IBOutlet weak var profilePic: PFImageView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var smallImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        usernameLabel.text = user?.username
        collectionView.dataSource = self
        collectionView.delegate = self
        
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        //flowLayout.scrollDirection = .Horizontal
        flowLayout.itemSize = CGSize(width: screenWidth / 3 - 30, height: screenWidth / 3 - 30)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
//        flowLayout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        let backgroundGreenColor = UIColor(hue: 0.4417, saturation: 0.96, brightness: 0.8, alpha: 1.0) /* #08cc87 */
        
        navigationController!.navigationBar.barTintColor = backgroundGreenColor
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        
        if cellHasRequestedProfile == true {
            user = sourcePost["author"] as? PFUser
        }
    }
    
    func postProfilePicture(){
        user!["profilePic"] = getPFFileFromImage(imageToPost!)
        
        //user?.setObject(sampleProfilePic!, forKey: "profilePicture")
        user!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
        }
        loadData()
        print(user!)
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        imageToPost = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    
    func loadData(){
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.includeKey("_id")
        query.whereKey("author", equalTo: (user)!)
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let posts = posts {
                    // do something with the data fetched
                    
                    self.parsedPosts = posts
                    self.collectionView.reloadData()
                    
                    if let profilePic = self.user!["profilePic"]{
                        print(profilePic)
                        self.profilePic.file = profilePic as? PFFile
                        print(self.profilePic!.file)
                        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.height / 2
                        self.profilePic.layer.masksToBounds = true
                        self.profilePic.layer.borderWidth = 0
                        self.profilePic.loadInBackground()
                    } else {
                        print("this shit isnt working")
                    }
                    
                    
                } else {
                    // handle error
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
 
 */
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.parsedPosts.count
    }
    
//    func collectionView(collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let kWhateverHeightYouWant = 100
//        return CGSizeMake(collectionView.bounds.size.width, CGFloat(kWhateverHeightYouWant))
//    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("postCollectionCell", forIndexPath: indexPath) as! PostCollectionCell
        
        
        
        let post = self.parsedPosts[indexPath.row]
        
        
        if let parsedImage = post["media"] {
            //print(parsedImage)
            cell.postCollectionImage.file = parsedImage as? PFFile
            cell.postCollectionImage.loadInBackground()
        }
        
        cell.layer.borderWidth = 0.5
//        cell.frame.size.width = screenWidth / 3
//        cell.frame.size.height = screenWidth / 3
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let detailViewController = segue.destinationViewController as! DetailViewController
        let indexPath = collectionView.indexPathForCell(sender as! UICollectionViewCell)
        
        let post = parsedPosts[indexPath!.row]
        detailViewController.post = post
        
    }
    

}
