//
//  PostsViewController.swift
//  insta
//
//  Created by Andrés Arbeláez on 6/20/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD
import ParseUI



class PostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var parsedPosts: [PFObject] = []
    
    var isMoreDataLoading = false
    
    var loadingMoreView:InfiniteScrollActivityView?
    
    var user : PFUser!
    
    var queryLimit = 20
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.allowsSelection = false
        
        loadData()
        
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
        
        let backgroundGreenColor = UIColor(hue: 0.4417, saturation: 0.96, brightness: 0.8, alpha: 1.0) /* #08cc87 */
        
        navigationController!.navigationBar.barTintColor = backgroundGreenColor
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Handle scroll behavior here
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                // Code to load more results
                loadMoreData()
            }
        }
    }
    
    
    func loadMoreData() {
            loadData()
            self.isMoreDataLoading = false
            queryLimit += 20
            // Stop the loading indicator
            self.loadingMoreView!.stopAnimating()
            // ... Use the new data to update the data source ...
            // Reload the tableView now that there is new data
            self.tableView.reloadData()
     
    }
    
    class InfiniteScrollActivityView: UIView {
        var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        static let defaultHeight:CGFloat = 60.0
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupActivityIndicator()
        }
        
        override init(frame aRect: CGRect) {
            super.init(frame: aRect)
            setupActivityIndicator()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            activityIndicatorView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        }
        
        func setupActivityIndicator() {
            activityIndicatorView.activityIndicatorViewStyle = .Gray
            activityIndicatorView.hidesWhenStopped = true
            self.addSubview(activityIndicatorView)
        }
        
        func stopAnimating() {
            self.activityIndicatorView.stopAnimating()
            self.hidden = true
        }
        
        func startAnimating() {
            self.hidden = false
            self.activityIndicatorView.startAnimating()
        }
    }
 
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.parsedPosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! postCell
        
        
        
        //print(indexPath.row)
        
        let post = self.parsedPosts[indexPath.row]
        
        cell.post = post
        
        cell.profileButton.tag = indexPath.row
        

        if let caption = post["caption"] {
            cell.captionLabel.text = caption as? String
        }
        
        if let parsedImage = post["media"] {
            //print(parsedImage)
            cell.postImage.file = parsedImage as? PFFile
            cell.postImage.loadInBackground()
        }
        
        if let likes = post["likesCount"] {
            cell.likeLabel.text = "\(likes)"
        }
        
        if let username = post["author"].username {
            cell.userLabel.text = username
            cell.usernameLabel2.text = username
        }
        
        if let user = post["author"] {
            print(user)
            self.user = user as! PFUser
            if let profilePic = self.user!["profilePic"]{
                print(profilePic)
                cell.profilePic.file = profilePic as? PFFile
                cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.height / 2
                cell.profilePic.layer.masksToBounds = true
                cell.profilePic.layer.borderWidth = 0
                cell.profilePic.loadInBackground()
            }
        }
        
        
        
        if let timestamp = post.createdAt {
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            var dateString = dateFormatter.stringFromDate(timestamp)
            //print(dateString)
            
            if timestamp > 1.minute.ago{
                //print("this was posted less than a minute ago")
                cell.dateLabel.text = "1 minute ago"
            }else if timestamp > 2.minute.ago{
                cell.dateLabel.text = "2 minutes ago"
            } else if timestamp > 3.minute.ago{
                cell.dateLabel.text = "3 minutes ago"
            } else if timestamp > 4.minute.ago{
                cell.dateLabel.text = "4 minutes ago"
            } else if timestamp > 5.minute.ago{
                cell.dateLabel.text = "5 minutes ago"
            } else if timestamp > 6.minute.ago{
                cell.dateLabel.text = "6 minutes ago"
            } else if timestamp > 7.minute.ago{
                cell.dateLabel.text = "7 minutes ago"
            } else if timestamp > 8.minute.ago{
                cell.dateLabel.text = "8 minutes ago"
            } else if timestamp > 9.minute.ago{
                cell.dateLabel.text = "9 minute ago"
            } else if timestamp > 10.minute.ago{
                cell.dateLabel.text = "10 minute ago"
            } else if timestamp > 1.hour.ago {
                //print("this was posted less than an hour ago")
                cell.dateLabel.text = "1 hour ago"
            } else if timestamp > 2.hour.ago {
                //print("this was posted less than an hour ago")
                cell.dateLabel.text = "2 hours ago"
            } else if timestamp > 3.hour.ago {
                //print("this was posted less than an hour ago")
                cell.dateLabel.text = "3 hours ago"
            } else if timestamp > 4.hour.ago {
                //print("this was posted less than an hour ago")
                cell.dateLabel.text = "4 hours ago"
            } else if timestamp > 5.hour.ago {
                //print("this was posted less than an hour ago")
                cell.dateLabel.text = "5 hours ago"
            } else if timestamp > 6.hour.ago {
                //print("this was posted less than an hour ago")
                cell.dateLabel.text = "6 hours ago"
            } else if timestamp > 7.hour.ago {
                //print("this was posted less than an hour ago")
                cell.dateLabel.text = "7 hours ago"
            } else if timestamp > 8.hour.ago {
                //print("this was posted less than an hour ago")
                cell.dateLabel.text = "8 hours ago"
            } else if timestamp > 9.hour.ago {
                //print("this was posted less than an hour ago")
                cell.dateLabel.text = "9 hours ago"
            } else if timestamp > 1.day.ago{
                cell.dateLabel.text = "1 day ago"
            } else {
                
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        return cell
    }
    
    
    
    func loadData(){
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.includeKey("_id")
        
        query.limit = queryLimit
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let posts = posts {
                    // do something with the data fetched
                    
                    self.parsedPosts = posts
                    self.tableView.reloadData()
                    
                    
                } else {
                    // handle whatever error
                }
            }
        }
    }
 
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        loadData()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        refreshControl.endRefreshing()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let detailViewController = segue.destinationViewController as! DetailViewController
            
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            
            let post = parsedPosts[indexPath!.row]
            
            detailViewController.post = post
        } else {
            let profileViewController = segue.destinationViewController as! ProfileViewController
            
            
            let button = sender as! UIButton
            
            let post = parsedPosts[button.tag]
            
            profileViewController.sourcePost = post
            
            profileViewController.cellHasRequestedProfile = true
            
        }
            
        
            
        
    }
}
