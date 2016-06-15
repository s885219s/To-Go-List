//
//  LocationDetailTableViewController.swift
//  ToGoList
//
//  Created by 陳宥丞 on 2016/6/7.
//  Copyright © 2016年 group7. All rights reserved.
//

import UIKit

class LocationDetailTableViewController: UITableViewController {
    var locationVisited = 0
    @IBOutlet weak var LocationPhoto: UIImageView!
    @IBOutlet weak var LocationName: UILabel!
    @IBOutlet weak var LocationPhone: UILabel!
    @IBOutlet weak var LocationAddress: UILabel!
    @IBOutlet weak var LocationTypes: UILabel!
    @IBOutlet weak var LocationWebsite: UILabel!
    @IBOutlet weak var LocationVisitButton: UIButton!
    @IBAction func callLocationPhoneNumber(sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil, message: "Call \(location!.name)", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        let callActionHandler = {(action:UIAlertAction!) -> () in
            //            if let phoneCallURL:NSURL = NSURL(string: "tel://\(self.location?.phoneNumber)") {
            //                let application:UIApplication = UIApplication.sharedApplication()
            //                if (application.canOpenURL(phoneCallURL)) {
            //                    application.openURL(phoneCallURL);
            //                }
            //            }
            if let url = NSURL(string: "tel://\(self.location!.phoneNumber)") {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        let callAction = UIAlertAction(title: "Call "+"\(location!.name)?", style: UIAlertActionStyle.Default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        //show alertSheet
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
    var location: Location? {
        didSet(newLocation) {
            if self.isViewLoaded(){
                self.fillData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()

    }
    
    func fillData(){
        guard let location = self.location else{
            return
        }
        if(location.imagePath != ""){
            let documentFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
            let filePath = (documentFolder as NSString).stringByAppendingPathComponent(location.imagePath)
            LocationPhoto.image = UIImage(contentsOfFile: filePath)
            LocationPhoto.contentMode = UIViewContentMode.ScaleAspectFill
            LocationPhoto.clipsToBounds = true
        }
        if(location.name != ""){
            self.LocationName.text = location.name
        }
        if(location.tags.joinWithSeparator(" ") != ""){
            self.LocationTypes.text = location.tags.joinWithSeparator(" ")
        }
        if(location.phoneNumber != ""){
            self.LocationPhone.text = location.phoneNumber
        }
        if(location.address != ""){
            self.LocationAddress.text = location.address
        }
        if(location.url != ""){
            self.LocationWebsite.text = location.url
        }
        if(location.visited == true){
            LocationVisitButton.setImage(UIImage(named: "beenHere"), forState: .Normal)
        }
        else{
            LocationVisitButton.setImage(UIImage(named: "BeenHereGray"), forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "DetailEdit" {
            let controller = segue.destinationViewController as! EditLocationTableViewController
            controller.oldLocation = self.location
        }
        
    }
    

}
