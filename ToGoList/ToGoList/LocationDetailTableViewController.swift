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
    @IBAction func LocationVisited(sender: AnyObject) {
        if locationVisited == 0 {
            //            locationVisitButton.imageView?.image = UIImage(named: "beenHere")
            LocationVisitButton.setImage(UIImage(named: "beenHere"), forState: .Normal)
            print("set locationVisited true")
            locationVisited = 1
        } else {
            //            locationVisitButton.imageView?.image = UIImage(named: "BeenHereGray")
            LocationVisitButton.setImage(UIImage(named: "BeenHereGray"), forState: .Normal)
            print("set locationVisited false")
            locationVisited = 0
        }

    }
        
    func fillData(){
        guard let location = self.location else{
            return
        }
        //self.LocationName.text = UIImage(named: locaiton.imageName)
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
        //self.LocationBeenHere = locaiton.visited
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
