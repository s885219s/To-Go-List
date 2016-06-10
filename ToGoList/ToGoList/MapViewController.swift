//
//  MapViewController.swift
//  ToGoList
//
//  Created by 林紹瑾 on 2016/6/9.
//  Copyright © 2016年 group7. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
//    var locations:Location = []
    
//    @IBOutlet weak var mapSearchBar: UISearchBar!
//    @IBOutlet weak var searchBar: UISearchBar!
    
    //現在位置
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    
//    var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithTarget((locationManager.location?.coordinate)!, zoom: 15.0)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
//        let mapView = GMSMapView.mapWithFrame(CGRect(x: 0, y: 108, width: 375, height: 515), camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        
//        self.view.bringSubviewToFront(searchBar)
        
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.sizeToFit()
//        definesPresentationContext = true
//        self.view.bringSubviewToFront
        
        
        
//        let camera = GMSCameraPosition.cameraWithLatitude(-33.86,
//                                                          longitude: 151.20, zoom: 6)
//        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
//        mapView.myLocationEnabled = true
//        self.view = mapView
//        
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Google Map SDK
//    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
//        if !didFindMyLocation {
//            let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
//            self.mapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 10.0)
//            mapView.settings.myLocationButton = true
//            
//            didFindMyLocation = true
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
