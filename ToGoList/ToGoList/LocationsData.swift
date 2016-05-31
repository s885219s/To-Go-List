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


struct Location{
    var name: String
    var tags: [String]?
    var url: NSURL?
    var address: String?
    var coordinate: CLLocationCoordinate2D!
    var visitDate: NSDate?
    var phoneNumber: String?
    var imagePath: String?
}

struct LocationsSource{
    
    
    var locations: [Location]!
    let fileName: String
    var filePath: String {
        let documentFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let filePath = (documentFolder as NSString).stringByAppendingPathComponent("\(self.fileName).sqlite3")
        return filePath
    }
    var databaseConnection: Connection?
    
    init(fileName: String) {
        self.fileName = fileName
        
        self.openDatabase()
    }
    
    private mutating func openDatabase(){
        do {
            self.databaseConnection = try Connection(self.filePath)
            let locations = Table("locations")
            
            try self.databaseConnection!.run(locations.create(ifNotExists: true) { t in
                t.column(Expression<String>("name"), primaryKey: true)
                t.column(Expression<String>("tags"))
                t.column(Expression<String>("url"))
                t.column(Expression<String>("address"))
                t.column(Expression<String>("coordinate"))
                t.column(Expression<String>("visitDate"))
                t.column(Expression<String>("phoneNumber"))
                t.column(Expression<String>("imagePath"))
                })
        } catch {
            print("Cannot create database")
            exit(1)
        }
    }
    
    func getLocationList() -> [Location]{
        return locations
    }
    
    mutating func insertLocationToList(newLocation: Location){
        locations.append(newLocation)
    }
    
    mutating func removeLocationFromList(targetLocation: Location){
        if let indexOfTarget = locations.indexOf({$0.name == targetLocation.name}){
            locations.removeAtIndex(indexOfTarget)
        } else {
            print("Target location to remove no found")
        }
    }
}