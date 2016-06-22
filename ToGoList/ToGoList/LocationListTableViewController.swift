
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
    var locationTypes:[String:[Location]] = [:]
    var locationTypesNumber:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locations = LocationsSource.sharedInstance.getLocationList()
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        //section tableView
        fullLocationTypes(locations!)
        
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
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.active {
            return "Search"
        } else {
            return locationTypesNumber[section]
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if searchController.active {
            return 1
        } else {
            return locationTypesNumber.count
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        locations = LocationsSource.sharedInstance.getLocationList()
        
        if searchController.active {
            return searchResults.count
        } else {
            return locationTypes[locationTypesNumber[section]]!.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if searchController.active {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LocationListTableViewCell
            
            let location = searchController.active ? searchResults[indexPath.row] : locations![indexPath.row]
            
            // Configure the cell...
            cell.locationNameLabel.text = location.name
            cell.locationAddressLabel.text = location.address
            cell.locationPhoneNumberLabel.text = location.phoneNumber
            switch location.tags[0] {
            case "bar":
                cell.locationTypeImage.image = UIImage(named:"barmarker")
            case "restaurant":
                cell.locationTypeImage.image = UIImage(named:"restaurantmarker")
            case "hotel":
                cell.locationTypeImage.image = UIImage(named:"hotelmarker")
            case "shopping":
                cell.locationTypeImage.image = UIImage(named:"shoppingmarker")
            case "recreation":
                cell.locationTypeImage.image = UIImage(named:"recreationmarker")
            default:
                cell.locationTypeImage.image = UIImage(named:"placemarker")
            }
            
            if let isVisited = location.visited {
                cell.accessoryType = isVisited ? .Checkmark : .None
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LocationListTableViewCell
            
            let locationType = locationTypes[locationTypesNumber[indexPath.section]]
            let location = locationType![indexPath.row]
            
            // Configure the cell...
            cell.locationNameLabel.text = location.name
            cell.locationAddressLabel.text = location.address
            cell.locationPhoneNumberLabel.text = location.phoneNumber
            switch location.tags[0] {
            case "bar":
                cell.locationTypeImage.image = UIImage(named:"barmarker")
            case "restaurant":
                cell.locationTypeImage.image = UIImage(named:"restaurantmarker")
            case "hotel":
                cell.locationTypeImage.image = UIImage(named:"hotelmarker")
            case "shopping":
                cell.locationTypeImage.image = UIImage(named:"shoppingmarker")
            case "recreation":
                cell.locationTypeImage.image = UIImage(named:"recreationmarker")
            default:
                cell.locationTypeImage.image = UIImage(named:"placemarker")
            }
            
            if let isVisited = location.visited {
                cell.accessoryType = isVisited ? .Checkmark : .None
            }
            
            return cell
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ListShowDetail" {
            
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            let detailViewController = segue.destinationViewController as! LocationDetailTableViewController
            let location = searchController.active ? searchResults[indexPath.row] : locationTypes[locationTypesNumber[indexPath.section]]![indexPath.row]
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
    
    // MARK :- SearchController
    
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
    
     //會亂掉
    func fullLocationTypes(locations:[Location]){
        for location in locations {
            for type in location.tags{
                if locationTypes[type] == nil {
                    locationTypes[type] = [location]
                    locationTypesNumber.append(type)
                } else {
                    locationTypes[type]?.append(location)
                }
            }
        }
    }
}
