//
//  AddLocationTableViewController.swift
//  ToGoList
//
//  Created by 陳宥丞 on 2016/6/7.
//  Copyright © 2016年 group7. All rights reserved.
//

import UIKit
import GoogleMaps
//for foward and reverse Geoceding
import CoreLocation
import AddressBookUI

class AddLocationTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GMSMapViewDelegate, CLLocationManagerDelegate {
    //曲現在位置用
    let locationManager = CLLocationManager()
    
    //儲存資料用
    var locationCoordinate: CLLocationCoordinate2D?

    var locationVisited = 0
    var didSetNewImage = false
    var imageFileLocation = ""

    var locationName:String?
    var locationType:String?
    var locationPhoneNumber:String?
    var locationAddress:String?
    var locationLink:String?
    
    //判斷用
    var checkSetCurrentLocation: Bool = false
    var checkPlacePickerButton: Bool = false
    
    //storyboard 物件

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typesTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationVisitButton: UIButton!
    @IBOutlet weak var setCurrentCoordinateButton: UIButton!
    @IBOutlet weak var placePickerButton: UIButton!
    
    @IBAction func locationVisited(sender: AnyObject) {
        if locationVisited == 0 {
//            locationVisitButton.imageView?.image = UIImage(named: "beenHere")
            locationVisitButton.setImage(UIImage(named: "beenHere"), forState: .Normal)
            print("set locationVisited true")
            locationVisited = 1
        } else {
//            locationVisitButton.imageView?.image = UIImage(named: "BeenHereGray")
            locationVisitButton.setImage(UIImage(named: "BeenHereGray"), forState: .Normal)
            print("set locationVisited false")
            locationVisited = 0
        }
    }
    //從google map pick place to textField
    @IBAction func searchLocationInfoFromGoogleMap(sender: AnyObject) {
//        //若鍵盤在的話 關掉鍵盤
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        view.addGestureRecognizer(tap)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if checkPlacePickerButton == false {
            let center = CLLocationCoordinate2DMake((locationManager.location?.coordinate.latitude)!, (locationManager.location?.coordinate.longitude)!)
            let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
            let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
            let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
            let config = GMSPlacePickerConfig(viewport: viewport)
            let placePicker = GMSPlacePicker(config: config)
            
            placePicker.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
                if let error = error {
                    print("Pick Place error: \(error.localizedDescription)")
                    return
                }
                
                if let place = place {
                    print("Place name \(place.name)")
                    print("Place address \(place.formattedAddress)")
                    print("Place attributions \(place.attributions)")
                    self.nameTextField.text = place.name
                    self.locationName = place.name
                    
                    self.addressTextField.text = place.formattedAddress
                    self.locationAddress = place.formattedAddress
                    
                    if place.phoneNumber != nil {
                        self.phoneNumberTextField.text = place.phoneNumber!
                        self.locationPhoneNumber = place.phoneNumber
                    }
                    
                    self.typesTextField.text = place.types[0]
                    self.locationType = place.types[0]
                    
                    if place.website != nil {
                        self.linkTextField.text = place.website?.absoluteString
                        self.locationLink = place.website?.absoluteString
                    }
                    
                    self.locationCoordinate = place.coordinate
                    
                } else {
                    print("No place selected")
                }
            })
            checkPlacePickerButton = true
            placePickerButton.setImage(UIImage(named: "placePickerBlue"), forState: .Normal)
        } else {
            checkPlacePickerButton = false
            placePickerButton.setImage(UIImage(named: "placePickerGray"), forState: .Normal)
        }
//        let center = CLLocationCoordinate2DMake((locationManager.location?.coordinate.latitude)!, (locationManager.location?.coordinate.longitude)!)
//        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
//        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
//        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
//        let config = GMSPlacePickerConfig(viewport: viewport)
//        let placePicker = GMSPlacePicker(config: config)
//        
//        placePicker.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let place = place {
//                print("Place name \(place.name)")
//                print("Place address \(place.formattedAddress)")
//                print("Place attributions \(place.attributions)")
//                self.nameTextField.text = place.name
//                self.locationName = place.name
//                
//                self.addressTextField.text = place.formattedAddress
//                self.locationAddress = place.formattedAddress
//                
//                if place.phoneNumber != nil {
//                    self.phoneNumberTextField.text = place.phoneNumber!
//                    self.locationPhoneNumber = place.phoneNumber
//                }
//                
//                self.typesTextField.text = place.types[0]
//                self.locationType = place.types[0]
//                
//                if place.website != nil {
//                    self.linkTextField.text = place.website?.absoluteString
//                    self.locationLink = place.website?.absoluteString
//                }
//                
//                self.locationCoordinate = place.coordinate
//                
//            } else {
//                print("No place selected")
//            }
//        })
    }
    
    @IBAction func setCurrentCoordinate(sender: AnyObject) {

        if checkSetCurrentLocation == false {
            print("now location coordinate lat:\(locationManager.location?.coordinate.latitude) lon:\(locationManager.location?.coordinate.longitude)")
            locationCoordinate = locationManager.location?.coordinate
            reverseGeocoding((locationCoordinate?.latitude)!, longitude: (locationCoordinate?.longitude)!)
            checkSetCurrentLocation = true
//            setCurrentCoordinateButton.imageView?.image = UIImage(named: "navigationBlue")
            setCurrentCoordinateButton.setImage(UIImage(named: "navigationBlue"), forState: .Normal)
        } else {
            checkSetCurrentLocation = false
//            setCurrentCoordinateButton.imageView?.image = UIImage(named: "navigationBlueLine")
            setCurrentCoordinateButton.setImage(UIImage(named: "navigationBlueLine"), forState: .Normal)
        }
    }
    
    @IBAction func clickSaveButton(sender: AnyObject) {
        if (nameTextField.text == nil || nameTextField.text == ""){
            let alertController = UIAlertController(title: "Alert", message: "Need a name for new location", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if (addressTextField.text == nil || addressTextField.text == ""){
            let alertController = UIAlertController(title: "Alert", message: "Location(Address) not set", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        if didSetNewImage{
            if let image = self.imageView.image{
                if let data = UIImagePNGRepresentation(image){
                    self.imageFileLocation = getDocumentsDirectory().stringByAppendingPathComponent(nameTextField.text! + ".png")
                    data.writeToFile(imageFileLocation, atomically: true)
                }
            }
        }

        let newLocation = Location(_name: nameTextField.text!, _tags: typesTextField.text, _url: linkTextField.text, _address: addressTextField.text, _lati: locationCoordinate!.latitude, _long: locationCoordinate!.longitude, _visited: locationVisited, _phoneNumber: phoneNumberTextField.text, _imagePath: self.imageFileLocation)
        
        LocationsSource.sharedInstance.insertLocationToList(newLocation)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Looks for single or multiple taps.   偵測點擊位置 為了收回鍵盤
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        view.addGestureRecognizer(tap)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //點選照片蘭增加照片
        if indexPath.row == 0 {
            //照片建立動作清單
            let optionMenu = UIAlertController(title: nil, message: "Where do you want to choose photo?", preferredStyle: .ActionSheet)
            
            //定義從圖庫加入照片動作 或是 利用相機來輸入照片
            let photoLibraryActionHandler = { (action:UIAlertAction!) -> () in
                if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .PhotoLibrary
                    
                    self.presentViewController(imagePicker, animated: true, completion: nil)
                }
            }
            
            let cameraActionHandler = { (action:UIAlertAction!) -> () in
                if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .Camera
                    
                    self.presentViewController(imagePicker, animated: true, completion: nil)
                }
            }
            
            
            //加入動作制清單
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            optionMenu.addAction(cancelAction)
            
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .Default, handler: photoLibraryActionHandler)
            optionMenu.addAction(photoLibraryAction)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: cameraActionHandler)
            optionMenu.addAction(cameraAction)
            
            //顯示動作清單
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.  收回鍵盤用
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.didSetNewImage = true
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - MAPkit
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            else if placemarks?.count > 0 {
                let pm = placemarks![0]
                let address = ABCreateStringWithAddressDictionary(pm.addressDictionary!, false)
                
                self.addressTextField.text = address
                self.locationAddress = address
                
                print("\n\(address)")
                if pm.areasOfInterest?.count > 0 {
                    let areaOfInterest = pm.areasOfInterest?[0]
                    print(areaOfInterest!)
                } else {
                    print("No area of interest found.")
                }
            }
        })
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
