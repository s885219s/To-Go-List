
//
//  LocationListTableViewController.swift
//  ToGoList
//
//  Created by 林紹瑾 on 2016/6/14.
//  Copyright © 2016年 group7. All rights reserved.
//

import UIKit

class LocationListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var locations: [Location]?
    var searchResults:[Location] = []
    var searchController:UISearchController!
//    var locations = [Location(_name: "home", _tags: "", _url: "", _address: "台北市內湖區成功路五段450巷21弄33號7樓", _lati: 12, _long: 21, _visited: 0, _phoneNumber: "0987654321", _imagePath: ""), Location(_name: "taipei 101", _tags: "", _url: "", _address: "臺北市信義區西村里8鄰信義路五段7號", _lati: 0, _long: 0, _visited: 0, _phoneNumber: "", _imagePath: ""), Location(_name: "覺旅", _tags: "", _url: "", _address: "114台北市內湖區瑞光路583巷24號", _lati: 0, _long: 0, _visited: 0, _phoneNumber: "1234567890", _imagePath: "")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locations = LocationsSource.sharedInstance.getLocationList()
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
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
//        print("LocationList numberOfRows")
//        let count = locations!.count
        if searchController.active {
            return searchResults.count
        } else {
            return (locations?.count)!
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LocationListTableViewCell
        
        let location = searchController.active ? searchResults[indexPath.row] : locations![indexPath.row]
        
        // Configure the cell...
        cell.locationNameLabel.text = location.name
        cell.locationAddressLabel.text = location.address
        cell.locationPhoneNumberLabel.text = location.phoneNumber
        switch location.tags[0] {
        case "bar":
            cell.locationTypeImage.image = UIImage(named:"bar")
        case "restaurant":
            cell.locationTypeImage.image = UIImage(named:"restaurant")
        case "hotel":
            cell.locationTypeImage.image = UIImage(named:"hotel")
        case "shopping":
            cell.locationTypeImage.image = UIImage(named:"shopping")
        case "recreation":
            cell.locationTypeImage.image = UIImage(named:"recreation")
        default:
            cell.locationTypeImage.image = UIImage(named:"attrationPin")
        }
        
        if let isVisited = location.visited {
            cell.accessoryType = isVisited ? .Checkmark : .None
        }

        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ListShowDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            let location = self.locations![indexPath.row]
            
            let detailViewController = segue.destinationViewController as! LocationDetailTableViewController
            detailViewController.location = searchController.active ? searchResults[indexPath.row] : locations![indexPath.row]
            detailViewController.location = location
            
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        } else {
            return true
        }
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let deleteTarget = self.locations![indexPath.row]
            LocationsSource.sharedInstance.removeLocationFromList(deleteTarget)
            locations!.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        tableView.reloadData()
    }
    
    //for searchcontroller
    func filterContentForSearchText(searchText: String) {
        searchResults = (locations?.filter({ (location:Location) -> Bool in
            let nameMatch = location.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let typeMatch = location.tags[0].rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return (nameMatch != nil || typeMatch != nil)
        }))!
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //do whatever with searchController here.
        if let searText = searchController.searchBar.text {
            filterContentForSearchText(searText)
            tableView.reloadData()
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
