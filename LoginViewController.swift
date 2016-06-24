//
//  LoginViewController.swift
//  insta
//
//  Created by Andrés Arbeláez on 6/19/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var passwordField: UITextField!

    @IBAction func onTapEndTyping(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var notificationLabel: UILabel!
    
    override func viewDidLoad() {
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        
        
        super.viewDidLoad()
        loginButton.backgroundColor = UIColor.clearColor()
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        usernameField.layer.borderColor = UIColor.whiteColor().CGColor
        passwordField.layer.borderColor = UIColor.whiteColor().CGColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification){
        print("keyboard shown")
        //let userinfo = notification.userInfo
        //let keyboardFrame = userInfo![UIKeyboardFrameEndUserInfoKey].CGRectValue()
        //let keyboardHeight = keyboardFrame.size.height
        //buttonBottomConstraint.constant = keyboardHeight!
        
        //view.layoutIfNeeded() //special autolayout method that updates the view and all the constraingts
    }
    
    func keyboardWillHide(notification: NSNotification){
        print("keyboard hidden")
    }

    
    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) in
            if user != nil{
                print("you are logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                self.notificationLabel.text = "incorrect username and/or password"
                
                UITextField.animateWithDuration(0.2, animations: {
                    self.passwordField.frame.origin.x += 30
                })
                UITextField.animateWithDuration(0.2, delay: 0.2, options: [], animations: {
                    self.passwordField.frame.origin.x -= 30
                    }, completion: nil)
                
                UITextField.animateWithDuration(0.2, delay: 0.4, options: [], animations: {
                    self.passwordField.frame.origin.x += 20
                    }, completion: nil)
                
                UITextField.animateWithDuration(0.2, delay: 0.6, options: [], animations: {
                    self.passwordField.frame.origin.x -= 20
                    }, completion: nil)

            }
        }
        
        
    }

    
    
    @IBAction func onSignUp(sender: AnyObject) {
        
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackgroundWithBlock { (success:Bool, error: NSError?) -> Void in
            if success{
               print("yay, created user")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
                if error?.code == 202{
                    print("username already exists")
                    self.notificationLabel.text = "username already exists"
                    
                    UITextField.animateWithDuration(0.2, animations: {
                        self.usernameField.frame.origin.x += 30
                    })
                    UITextField.animateWithDuration(0.2, delay: 0.2, options: [], animations: {
                        self.usernameField.frame.origin.x -= 30
                        }, completion: nil)
                    
                    UITextField.animateWithDuration(0.2, delay: 0.4, options: [], animations: {
                        self.usernameField.frame.origin.x += 20
                        }, completion: nil)
                    
                    UITextField.animateWithDuration(0.2, delay: 0.6, options: [], animations: {
                        self.usernameField.frame.origin.x -= 20
                        }, completion: nil)
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
