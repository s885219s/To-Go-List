// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.8 clang-703.0.31)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import GoogleMaps;
@import CoreLocation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class CLLocationManager;
@class NSString;
@class UITableView;
@class NSIndexPath;
@class UIImagePickerController;
@class UITextField;
@class UIImageView;
@class UIButton;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC8ToGoList30AddLocationTableViewController")
@interface AddLocationTableViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, GMSMapViewDelegate, CLLocationManagerDelegate>
@property (nonatomic, readonly, strong) CLLocationManager * _Nonnull locationManager;
@property (nonatomic) NSInteger locationVisited;
@property (nonatomic) BOOL didSetNewImage;
@property (nonatomic, copy) NSString * _Nonnull imageFileLocation;
@property (nonatomic, copy) NSString * _Nullable locationName;
@property (nonatomic, copy) NSString * _Nullable locationType;
@property (nonatomic, copy) NSString * _Nullable locationPhoneNumber;
@property (nonatomic, copy) NSString * _Nullable locationAddress;
@property (nonatomic, copy) NSString * _Nullable locationLink;
@property (nonatomic) BOOL checkSetCurrentLocation;
@property (nonatomic) BOOL checkPlacePickerButton;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified nameTextField;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified typesTextField;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified phoneNumberTextField;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified addressTextField;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified linkTextField;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified imageView;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified locationVisitButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified setCurrentCoordinateButton;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified placePickerButton;
- (IBAction)locationVisited:(id _Nonnull)sender;
- (IBAction)searchLocationInfoFromGoogleMap:(id _Nonnull)sender;
- (IBAction)setCurrentCoordinate:(id _Nonnull)sender;
- (IBAction)clickSaveButton:(id _Nonnull)sender;
- (NSString * _Nonnull)getDocumentsDirectory;
- (void)viewDidLoad;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)dismissKeyboard;
- (void)imagePickerController:(UIImagePickerController * _Nonnull)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> * _Nonnull)info;
- (void)reverseGeocoding:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIWindow;
@class UIApplication;
@class NSObject;

SWIFT_CLASS("_TtC8ToGoList11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary * _Nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC8ToGoList31EditLocationTableViewController")
@interface EditLocationTableViewController : UITableViewController
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified nameTextField;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified typesTextField;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified phoneNumberTextField;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified addressTextField;
@property (nonatomic, weak) IBOutlet UITextField * _Null_unspecified linkTextField;
- (void)viewDidLoad;
- (IBAction)clickSvaeButton:(id _Nonnull)sender;
- (void)viewWillDisappear:(BOOL)animated;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UILabel;

SWIFT_CLASS("_TtC8ToGoList33LocationDetailTableViewController")
@interface LocationDetailTableViewController : UITableViewController
@property (nonatomic) NSInteger locationVisited;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified LocationPhoto;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified LocationName;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified LocationPhone;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified LocationAddress;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified LocationTypes;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified LocationWebsite;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified LocationVisitButton;
- (void)viewDidLoad;
- (IBAction)LocationVisited:(id _Nonnull)sender;
- (void)fillData;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC8ToGoList25LocationListTableViewCell")
@interface LocationListTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified locationNameLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified locationAddressLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified locationPhoneNumberLabel;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified locationTypeImage;
- (void)awakeFromNib;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIStoryboardSegue;

SWIFT_CLASS("_TtC8ToGoList31LocationListTableViewController")
@interface LocationListTableViewController : UITableViewController
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)prepareForSegue:(UIStoryboardSegue * _Nonnull)segue sender:(id _Nullable)sender;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC8ToGoList36MapLocationDetailTableViewController")
@interface MapLocationDetailTableViewController : UITableViewController
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified locationNameLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified locationTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified locationPhoneNumberLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified locationAddressLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified locationWebsiteLabel;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified locationVisitedButton;
- (IBAction)callLocationPhoneNumber:(id _Nonnull)sender;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class GMSMapView;
@class GMSMarker;
@class UISearchBar;

SWIFT_CLASS("_TtC8ToGoList17MapViewController")
@interface MapViewController : UIViewController <GMSMapViewDelegate>
@property (nonatomic, weak) IBOutlet UISearchBar * _Null_unspecified searchController;
@property (nonatomic, readonly, strong) CLLocationManager * _Nonnull locationManager;
@property (nonatomic, weak) IBOutlet GMSMapView * _Null_unspecified mapView;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)mapView:(GMSMapView * _Nonnull)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)mapView:(GMSMapView * _Nonnull)mapView didTapInfoWindowOfMarker:(GMSMarker * _Nonnull)marker;
- (void)prepareForSegue:(UIStoryboardSegue * _Nonnull)segue sender:(id _Nullable)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class CLLocation;

@interface MapViewController (SWIFT_EXTENSION(ToGoList)) <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations;
@end

#pragma clang diagnostic pop
