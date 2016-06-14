//
//  MapLocationDetailTableViewController.swift
//  ToGoList
//
//  Created by 林紹瑾 on 2016/6/11.
//  Copyright © 2016年 group7. All rights reserved.
//

import UIKit

class MapLocationDetailTableViewController: UITableViewController {
    var location:Location?
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationTypeLabel: UILabel!
    @IBOutlet weak var locationPhoneNumberLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var locationWebsiteLabel: UILabel!
    @IBOutlet weak var locationVisitedButton: UIButton!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        print("name: \(location!.name)")
        if(location?.name != ""){
            locationNameLabel.text = location?.name
        }
        if(location?.tags.joinWithSeparator(" ") != ""){
            locationTypeLabel.text = location?.tags.joinWithSeparator(" ")
        }
        if(location?.phoneNumber != ""){
            locationPhoneNumberLabel.text = location?.phoneNumber
        }
        if(location?.address != ""){
            locationAddressLabel.text = location?.address
        }
        if(location?.url != ""){
            locationWebsiteLabel.text = location?.url
        }
        if(location?.visited == true){
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

    /*
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
