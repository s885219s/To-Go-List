
//
//  LocationListTableViewController.swift
//  ToGoList
//
//  Created by 林紹瑾 on 2016/6/14.
//  Copyright © 2016年 group7. All rights reserved.
//

import UIKit

class LocationListTableViewController: UITableViewController {
    
    var locations: [Location]?
//    var locations = [Location(_name: "home", _tags: "", _url: "", _address: "台北市內湖區成功路五段450巷21弄33號7樓", _lati: 12, _long: 21, _visited: 0, _phoneNumber: "0987654321", _imagePath: ""), Location(_name: "taipei 101", _tags: "", _url: "", _address: "臺北市信義區西村里8鄰信義路五段7號", _lati: 0, _long: 0, _visited: 0, _phoneNumber: "", _imagePath: ""), Location(_name: "覺旅", _tags: "", _url: "", _address: "114台北市內湖區瑞光路583巷24號", _lati: 0, _long: 0, _visited: 0, _phoneNumber: "1234567890", _imagePath: "")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locations = LocationsSource.sharedInstance.getLocationList()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        locations = LocationsSource.sharedInstance.getLocationList()
        print("LocationList numberOfRows")
        let count = locations!.count
        return count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LocationListTableViewCell
        
        // Configure the cell...
        cell.locationNameLabel.text = locations![indexPath.row].name
        cell.locationAddressLabel.text = locations![indexPath.row].address
        cell.locationPhoneNumberLabel.text = locations![indexPath.row].phoneNumber

        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ListShowDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            let location = self.locations![indexPath.row]
            
            let detailViewController = segue.destinationViewController as! LocationDetailTableViewController
            detailViewController.location = location
            
        }
    }

    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let deleteTarget = self.locations![indexPath.row]
            LocationsSource.sharedInstance.removeLocationFromList(deleteTarget)
            locations!.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
