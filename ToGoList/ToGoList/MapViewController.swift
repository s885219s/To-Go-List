//
//  MapViewController.swift
//  ToGoList
//
//  Created by 林紹瑾 on 2016/6/9.
//  Copyright © 2016年 group7. All rights reserved.
//

import UIKit
import GoogleMaps
//import MapKit
import CoreLocation
import AddressBookUI

class MapViewController: UIViewController, GMSMapViewDelegate {
//    var locations:Location = []
//    var locations:[Location]?
    @IBOutlet weak var searchController: UISearchBar!
    
    
//    var locations1 = [Location(_name: "home", _tags: "", _url: "", _address: "台北市內湖區成功路五段450巷21弄33號7樓", _lati: 12, _long: 21, _visited: 0, _phoneNumber: "0987654321", _imagePath: ""), Location(_name: "taipei 101", _tags: "", _url: "", _address: "臺北市信義區西村里8鄰信義路五段7號", _lati: 0, _long: 0, _visited: 0, _phoneNumber: "", _imagePath: ""), Location(_name: "覺旅", _tags: "", _url: "", _address: "114台北市內湖區瑞光路583巷24號", _lati: 0, _long: 0, _visited: 0, _phoneNumber: "1234567890", _imagePath: "")]
    var locations:[Location]?
    //for google map reverce geocodeing
//    let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    
    //現在位置
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapView")
        
        //抓DB資料
        print(LocationsSource.sharedInstance.getLocationList())
//        print(locations1)
        locations = LocationsSource.sharedInstance.getLocationList()
        //測試DB  把資料塞到db
        /*
        print(LocationsSource.sharedInstance.filePath)
        for location in locations {
            LocationsSource.sharedInstance.insertLocationToList(location)
        }
        LocationsSource.sharedInstance.writeBacktoDB()
        */
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // 4
        locationManager.startUpdatingLocation()
        
        //5
        mapView!.myLocationEnabled = true
        mapView!.settings.myLocationButton = true
        
        self.mapView.delegate = self
        
        //顯示標記
//        print("location1")
//        for location in locations1 {
//            print("location name\(location.name) lati\(location.coordinate!.latitude) long\(location.coordinate!.longitude)")
//        }
//        print("location2")
        for location in locations! {
            print("location name\(location.name) lati\(location.coordinate!.latitude) long\(location.coordinate!.longitude)")
            forwardGeocoding(location.address, findedLocation: location)
        }
        //暫時無法用
//        showMarker(locations)
    }
    
    override func viewWillAppear(animated: Bool) {
        locations = LocationsSource.sharedInstance.getLocationList()
        // clear all locations on map
        self.mapView.clear()
        for location in locations! {
            print("location name\(location.name) lati\(location.coordinate!.latitude) long\(location.coordinate!.longitude)")
            forwardGeocoding(location.address, findedLocation: location)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     // MARK: - Google Map SDK
    func showMarker(locations: [Location]) {
        for location in locations {
//            let marker = GMSMarker(position: location.coordinate!)
//            marker.title = location.name
//            marker.snippet = location.phoneNumber
//            marker.map = self.mapView
            print("location\(location.name) address\(location.address) lat\(location.coordinate?.latitude) lon\(location.coordinate?.longitude)")
        }
    }
    
//    override func loadView() {
//        var camera = GMSCameraPosition.cameraWithLatitude(1.285,
//                                                          longitude:103.848, zoom:12)
//        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
//        mapView.delegate = self
//        self.view = mapView
//    }
    
    // MARK: GMSMapViewDelegate
    
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
    }
    
    func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
        print("tap \(marker.title)")
        print("didTapInfoWindowOfMarker")
        let name = marker.title
        performSegueWithIdentifier("MapLocationShowDetail", sender: name)
        //search from db
        /*
        for location in locations {
            if location.name == name{
                /*
                if let pageDetailController = storyboard?.instantiateViewControllerWithIdentifier("MapViewDetailController") as? MapLocationDetailTableViewController {
                    let navigationController = UINavigationController(rootViewController: pageDetailController)
//                    pageDetailController as! LocationDetailTableViewController
                    pageDetailController.location = location
                    self.presentViewController(navigationController, animated: true, completion: nil)
                }
                 */
//                let loc = location as! AnyObject
                performSegueWithIdentifier("MapLocationShowDetail", sender: location.name)
            }
        }
        */
    }
    
    //Calls this function when the tap is recognized.  收回鍵盤用
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    
    // MARK: - Apple MapKit
    func forwardGeocoding(address: String, findedLocation: Location) {
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                let  position = CLLocationCoordinate2DMake((coordinate?.latitude)!, (coordinate?.longitude)!)
                let marker = GMSMarker(position: position)
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                if placemark?.areasOfInterest?.count > 0 {
                    let areaOfInterest = placemark!.areasOfInterest![0]
                    print(areaOfInterest)
                    marker.title = findedLocation.name
                    marker.snippet = findedLocation.phoneNumber
                    marker.icon = UIImage(named: "place")
                    marker.map = self.mapView
                } else {
                    print("No area of interest found.")
                    marker.icon = UIImage(named: "place")
                    marker.title = findedLocation.name
                    marker.snippet = findedLocation.phoneNumber
                    marker.map = self.mapView
                }
            }
        })
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "MapLocationShowDetail" {
            let controller = segue.destinationViewController as! MapLocationDetailTableViewController
            for location in locations! {
                let name = sender as! String
                if location.name == name {
                    controller.location = location
                }
            }
//            controller.location =
        }
        
    }
 

}

// MARK: - CLLocationManagerDelegate
//1
extension MapViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .AuthorizedWhenInUse {
            
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            mapView!.myLocationEnabled = true
            mapView!.settings.myLocationButton = true
        }
    }
    
    // 6
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // 7
            mapView!.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
            locationManager.stopUpdatingLocation()
        }
        
    }
}
