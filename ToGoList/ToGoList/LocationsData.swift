//
//  LocationsData.swift
//  ToGoList
//
//  Created by TsungYen Su on 5/30/16.
//  Copyright © 2016 group7. All rights reserved.
//

import Foundation
import SQLite
import CoreLocation
import CoreLocation
import AddressBookUI

struct Location{
    var name: String
    var tags: [String] = []
    var url: String = ""
    var address: String = ""
    var coordinate: CLLocationCoordinate2D?
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
        }
        // 原本有寫錯 無法正常輸入address
        if _address != nil{
            self.address = _address!
//            setCoordinate(_address!)
        }
        //原本宗彥寫的 設定coordinate
        self.coordinate = CLLocationCoordinate2DMake(_lati, _long)
        //紹瑾改的
//        self.forwardGeocoding(self.address)
        
        self.visited = Bool(_visited)
        if _phoneNumber != nil{
            self.phoneNumber = _phoneNumber!
        }
        if _imagePath != nil{
            self.imagePath = _imagePath!
        }
    }
    
    func tagsToStr() -> String {
        if tags != []{
            return self.tags.joinWithSeparator(",")
        } else {
            return ""
        }
    }
    
    func getLati() -> Double {
        return self.coordinate!.latitude
    }
    
    func getLong() -> Double {
        return self.coordinate!.longitude
    }
    
    mutating func setCoordinate(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

struct LocationTable {
    static let table = Table("locations")
    static let itemId = Expression<Int64>("id")
    static let name = Expression<String>("name")
    static let tags = Expression<String>("tags")
    static let url = Expression<String>("url")
    static let address = Expression<String>("address")
    static let lati = Expression<Double>("lati")
    static let long = Expression<Double>("long")
    static let visited = Expression<Int>("visited")
    static let phoneNumber = Expression<String>("phoneNumber")
    static let imagePath = Expression<String>("imagePath")
}

class LocationsSource{
    
    var locations: [Location]!
    let fileName: String = "TGLISTDB"
    var filePath: String {
        let documentFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let filePath = (documentFolder as NSString).stringByAppendingPathComponent("\(fileName).sqlite3")
        return filePath
    }
    var databaseConnection: Connection?
    
    static let sharedInstance = LocationsSource()
    
    private init() {
        self.openDatabase()
        self.locations = []
    }
    
    func openDatabase(){
        do {
            self.databaseConnection = try Connection(filePath)
            
            try self.databaseConnection!.run(LocationTable.table.create(ifNotExists: true) { t in
                t.column(LocationTable.itemId, primaryKey: .Autoincrement)
                t.column(LocationTable.name)
                t.column(LocationTable.tags)
                t.column(LocationTable.url)
                t.column(LocationTable.address)
                t.column(LocationTable.lati)
                t.column(LocationTable.long)
                t.column(LocationTable.visited)
                t.column(LocationTable.phoneNumber)
                t.column(LocationTable.imagePath)
                })
        } catch {
            print("Cannot open database")
            exit(1)
        }
    }
    
    func loadFromDB(){
        var _list: [Location] = []
        do{
            for l in try databaseConnection!.prepare(LocationTable.table) {
                let l = Location(_name: l[LocationTable.name],
                                 _tags: l[LocationTable.tags],
                                 _url: l[LocationTable.url],
                                 _address: l[LocationTable.address],
                                 _lati: l[LocationTable.lati],
                                 _long: l[LocationTable.long],
                                 _visited: l[LocationTable.visited],
                                 _phoneNumber: l[LocationTable.phoneNumber],
                                 _imagePath: l[LocationTable.imagePath])
                _list.append(l)
            }
        } catch{
            print("Cannot read locations from DB")
        }
        self.locations = _list
    }
    
    func getLocationList() -> [Location] {
        return self.locations
    }
    
    func insertLocationToList(newLocation: Location){
        self.locations.append(newLocation)
        self.writeBacktoDB()
    }
    
    func removeLocationFromList(targetLocation: Location){
        if let indexOfTarget = locations.indexOf({$0.name == targetLocation.name}){
            self.locations.removeAtIndex(indexOfTarget)
        } else {
            print("Target location to remove not found")
        }
        self.writeBacktoDB()
    }
    
    func writeBacktoDB(){
        if self.databaseConnection == nil {
            return
        }
        // should be called when App is closed
        do {
            // first delete all rows in db
            try self.databaseConnection!.run(LocationTable.table.delete())
            // then insert from list
            do{
                for l in self.locations{
                    try self.databaseConnection!.run(LocationTable.table.insert(
                        LocationTable.name <- l.name,
                        LocationTable.tags <- l.tagsToStr(),
                        LocationTable.url <- l.url,
                        LocationTable.address <- l.address,
                        LocationTable.lati <- l.getLati(),
                        LocationTable.long <- l.getLong(),
                        LocationTable.visited <- Int(l.visited),
                        LocationTable.phoneNumber <- l.phoneNumber,
                        LocationTable.imagePath <- l.imagePath))
                }
            } catch {
                print("Cannot insert data")
            }
            
        } catch {
            print("Cannot write back to database")
            exit(1)
        }
    }
}
/*
 
 sample usage
 
 let home = Location(_name: "home", _tags: nil, _url: nil, _address: nil, _lati: 0.0, _long: 0.0, _visited: 0, _phoneNumber: nil, _imagePath: nil)
 let school = Location(_name: "school", _tags: "aa,bb,cccc,d", _url: "www.com.tw", _address: "taipei city", _lati: 1.0, _long: 2.0, _visited: 0, _phoneNumber: "22334455", _imagePath: "/xxx/xxx.jpg")
 
 
 
 LocationsSource.sharedInstance.loadFromDB() this func should be called when app is activated
 LocationsSource.sharedInstance.getLocationList()
 LocationsSource.sharedInstance.insertLocationToList(home)
 LocationsSource.sharedInstance.insertLocationToList(school)
 LocationsSource.sharedInstance.getLocationList()
 LocationsSource.sharedInstance.writeBacktoDB() this func should be called when app is being closed
 
*/

