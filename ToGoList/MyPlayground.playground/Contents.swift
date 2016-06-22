//: Playground - noun: a place where people can play

import UIKit
import CoreLocation
import MapKit

var str = "Hello, playground"

struct Location{
    var name: String
    var tags: [String] = []
    var url: String = ""
    var address: String = ""
    var coordinate: CLLocationCoordinate2D!
    var visited: Bool! = false
    var phoneNumber: String = ""
    var imagePath: String = ""
    
    init(_name: String, _tags: String?, _url: String?, _address: String?, _lati: Double, _long: Double , _visited: Int, _phoneNumber: String?, _imagePath: String?){
        self.name = _name
        if _tags != nil {
            self.tags = _tags!.componentsSeparatedByString(",")
        } else {
            self.tags = []
        }
        if _url != nil{
            self.url = _url!
        } else
            
        if _address != nil{
            self.address = _address!
        }
        
        self.address = _address!
        
        self.coordinate = CLLocationCoordinate2DMake(_lati, _long)
        self.visited = Bool(_visited)
        if _phoneNumber != nil{
            self.phoneNumber = _phoneNumber!
        }
        if _imagePath != nil{
            self.imagePath = _imagePath!
        }
    }
}

var locations:[Location]?
locations = [Location(_name: "覺旅", _tags: "", _url: "", _address: "taipei", _lati: 12, _long: 21, _visited: 0, _phoneNumber: "", _imagePath: ""), Location(_name: "taipei 101", _tags: "", _url: "", _address: "信義路五段7號", _lati: 0, _long: 0, _visited: 0, _phoneNumber: "", _imagePath: "")]

print(locations![0].address)


let geoCoder = CLGeocoder()
var coords: CLLocationCoordinate2D?
for location in locations! {
    geoCoder.geocodeAddressString(location.address, completionHandler: {
        placemarks, error in
        if error != nil {
            print(error)
            return
        }
        if let placemarks = placemarks {
            let placemark = placemarks[0]
            
            if let location = placemark.location {
                coords = location.coordinate
            }
        }
    })
}