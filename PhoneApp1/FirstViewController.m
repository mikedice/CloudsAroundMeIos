//
//  FirstViewController.m
//  PhoneApp1
//
//  Created by Michael Dice on 3/6/14.
//  Copyright (c) 2014 Michael Dice. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
BOOL twitterIsRunning;
NSTimer* queryTimer;
NSArray *tableData;
const char* twitterApiKey = "cxBaohiWOa1M6sAvAjUHA";
const char* twitterApiSecret = "8niqmJiHDyzAKqtJcptLaqpoPS0Xj3XGjaT2i9XHCk";
NSDate* lastLocationCheck;
NSTimeInterval locationCheckDelayInSeconds = 30.0;
CLLocationManager* locationManager;


- (void)viewDidLoad
{
    [super viewDidLoad];
    twitterIsRunning = false;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"main screen appeared");
    [self startQueryLoop];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"main screen disappeared");
    [self stopQueryLoop];

}


-(void) startQueryLoop
{
    NSLog(@"startQueryLoop called");
    queryTimer = [NSTimer scheduledTimerWithTimeInterval: 30
                                            target:self
                                            selector:@selector(handleTimer:)
                                            userInfo:nil
                                            repeats:YES];
    [self beginQueryTwitter];
}

-(void) stopQueryLoop
{
    NSLog(@"stopQueryLoop called");
}

-(void)handleTimer: (id) sender
{
    NSLog(@"handleTimer called");
}

-(void)beginQueryTwitter
{
    if (!twitterIsRunning)
    {
        LocationSearchResult* locationToUse = [self getLocationToUse];
        
//        twitterIsRunning = true;
//        // Format the search URL
//        searchQuery = [searchQuery stringByReplacingOccurrencesOfString:@" " withString:@"+"];
//        NSString* url = [[NSString alloc] initWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?query=%@&sensor=false&key=AIzaSyAkfpcO1Fox6IP3DGKJ3GMT-tv7TYWdE5o", searchQuery];
//        
//        // Create the request object and set its properties
//        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
//        [request setValue: @"mikediceNet"  forHTTPHeaderField:@"referer"];
//        request.HTTPMethod = @"GET";
//        
//        // Attach the request to the operation manager
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
//                                                                             success:^(AFHTTPRequestOperation *operation, id responseObject)
//                                             {
//                                                 NSLog(@"JSON: %@", responseObject);
//                                                 [self parseJsonResponse:responseObject];
//                                             }
//                                                                             failure:^(AFHTTPRequestOperation *operation, NSError *error)
//                                             {
//                                                 NSLog(@"Error: %@", error);
//                                             }];
//        
//        // Put the request in the operation manager's queue to start it processing.
//        [manager.operationQueue addOperation:operation];
        
    }

}

// If using 'My' location and we either haven't ever looked up the current user's location
// or, we have looked up the user's current location but sufficient time has passed since last time
// we looked up their location then go ahead and look up the user's location
- (LocationSearchResult*) getLocationToUse
{
    AppSettings* settings = [AppSettings loadAppSettings];
    if (settings->useMyLocation)
    {
        bool shouldCheck = false;
        NSLog(@"Settings says use 'My' location");
        if (lastLocationCheck != Nil)
        {
            NSLog(@"lastLocationCheck is not null");
            NSTimeInterval interval = [lastLocationCheck timeIntervalSinceNow];
            NSLog(@"location check time interval %f", interval);
            if (interval > locationCheckDelayInSeconds)
            {
                NSLog(@"location should check is true, interval was exceeded");
                shouldCheck = true;
            }
            else
            {
                NSLog(@"location should check is false, interval not exceeded");
            }
        }
        else
        {
            NSLog(@"location should check is true. Location has never been checked");
            shouldCheck = true;
        }
        
        if (shouldCheck)
        {
            // Create the location manager if this object does not
            // already have one.
            if (nil == locationManager)
            {
                locationManager = [[CLLocationManager alloc] init];
                locationManager.distanceFilter = kCLDistanceFilterNone;
                locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                locationManager.delegate = self;
                NSLog(@"Initialized new location manager");
            }
            
            [locationManager startUpdatingLocation];
            NSLog(@"started udpating location using location manager");
        }
    }
    return Nil;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    NSLog(@"Location manager finished updating location lat,lon [%f , %f]", location.coordinate.latitude, location.coordinate.longitude);
    lastLocationCheck = [NSDate date];
    [locationManager stopUpdatingLocation];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize pauseResumeButton;
@synthesize dataTableView;

@end
