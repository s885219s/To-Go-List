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
    
    @IBOutlet weak var searchController: UISearchBar!
    
    var locations:[Location]?
    
    //現在位置
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapView")
        
        //抓DB資料
        locations = LocationsSource.sharedInstance.getLocationList()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView!.myLocationEnabled = true
        mapView!.settings.myLocationButton = true
        
        self.mapView.delegate = self
        
        //顯示標記
        for location in locations! {
            print("location name\(location.name) lati\(location.coordinate!.latitude) long\(location.coordinate!.longitude)")
            forwardGeocoding(location.address, findedLocation: location)
        }
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
            print("location\(location.name) address\(location.address) lat\(location.coordinate?.latitude) lon\(location.coordinate?.longitude)")
        }
    }
    
    // MARK: GMSMapViewDelegate
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        UIApplication.sharedApplication().sendAction("resignFirstResponder", to:nil, from:nil, forEvent:nil)
    }
    
    func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
        print("tap \(marker.title)")
        print("didTapInfoWindowOfMarker")
        let name = marker.title
        performSegueWithIdentifier("MapLocationShowDetail", sender: name)
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
                    marker.icon = self.markerIcon(findedLocation.tags[0])
                    marker.map = self.mapView
                } else {
                    print("No area of interest found.")
                    marker.icon = self.markerIcon(findedLocation.tags[0])
                    marker.title = findedLocation.name
                    marker.snippet = findedLocation.phoneNumber
                    marker.map = self.mapView
                }
                let cirlce = GMSCircle(position: position, radius: 200)
                cirlce.fillColor = UIColor.redColor().colorWithAlphaComponent(0.5)
                cirlce.map = self.mapView
            }
        })
    }
    
    func markerIcon(type: String) -> UIImage {
        switch type {
        case "bar":
            return UIImage(named:"barmarker")!
        case "restaurant":
            return UIImage(named:"restaurantmarker")!
        case "hotel":
            return UIImage(named:"hotelmarker")!
        case "shopping":
            return UIImage(named:"shoppingmaker")!
        case "recreation":
            return UIImage(named:"recreationmarker")!
        default:
            return UIImage(named:"placemarker")!
        }
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
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            mapView!.myLocationEnabled = true
            mapView!.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            mapView!.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            locationManager.stopUpdatingLocation()
        }
        
    }
}
