//
//  MapLocationDetailTableViewController.swift
//  ToGoList
//
//  Created by 林紹瑾 on 2016/6/11.
//  Copyright © 2016年 group7. All rights reserved.
//

import UIKit

class MapLocationDetailTableViewController: UITableViewController, PassNewLocation{
    
    func getNewLocation(newLocation: Location){
        self.location = newLocation
    }
    
    var location:Location!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationTypeLabel: UILabel!
    @IBOutlet weak var locationPhoneNumberLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var locationWebsiteLabel: UILabel!
    @IBOutlet weak var locationVisitedButton: UIButton!
    @IBAction func callLocationPhoneNumber(sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil, message: "Call \(location.name)", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        let callActionHandler = {(action:UIAlertAction!) -> () in
            
            if let url = NSURL(string: "tel://\(self.location.phoneNumber)") {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        let callAction = UIAlertAction(title: "Call "+"\(location.name)?", style: UIAlertActionStyle.Default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        //show alertSheet
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(location.imagePath != ""){
            let documentFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
            let filePath = (documentFolder as NSString).stringByAppendingPathComponent(location.imagePath)

            locationImageView.image = UIImage(contentsOfFile: filePath)
            locationImageView.contentMode = UIViewContentMode.ScaleAspectFill
            locationImageView.clipsToBounds = true
        }
        if(location.name != ""){
            locationNameLabel.text = location.name
            navigationItem.title = location.name
        }
        if(location.tags.joinWithSeparator(" ") != ""){
            locationTypeLabel.text = location.tags.joinWithSeparator(" ")
        }
        if(location.phoneNumber != ""){
            locationPhoneNumberLabel.text = location.phoneNumber
        }
        if(location.address != ""){
            locationAddressLabel.text = location.address
        }
        if(location.url != ""){
            locationWebsiteLabel.text = location.url
        }
        if(location.visited == true){
            locationVisitedButton.setImage(UIImage(named: "beenHere"), forState: .Normal)
        }
        else{
            locationVisitedButton.setImage(UIImage(named: "BeenHereGray"), forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "DetailEdit" {
            let controller = segue.destinationViewController as! EditLocationTableViewController
            controller.oldLocation = self.location
            controller.delegate = self
        }
    }
    

}
