//
//  SecondViewController.m
//  PhoneApp1
//
//  Created by Michael Dice on 3/6/14.
//  Copyright (c) 2014 Michael Dice. All rights reserved.
//

#import "SecondViewController.h"
#import "AppSettings.h"
#import "LocationSearchResult.h"

@interface SecondViewController ()


@end

@implementation SecondViewController


-(IBAction)useMyLocationChanged:(id)sender
{
    UISwitch* uiSwitch = (UISwitch*)sender;
    
    NSLog(@"value one changed %@", uiSwitch.on ? @"Yes" : @"No");

    [self setControlState:uiSwitch.on];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)searchForLocationClicked:(id)sender
{
    [searchQueryField resignFirstResponder];
    NSString* searchQuery = [searchQueryField text];
    
    if (searchQuery != NULL && searchQuery.length > 0)
    {
        // Format the search URL
        searchQuery = [searchQuery stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSString* url = [[NSString alloc] initWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?query=%@&sensor=false&key=AIzaSyAkfpcO1Fox6IP3DGKJ3GMT-tv7TYWdE5o", searchQuery];
        
        // Create the request object and set its properties
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [request setValue: @"mikediceNet"  forHTTPHeaderField:@"referer"];
        request.HTTPMethod = @"GET";

        // Attach the request to the operation manager
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                     success:^(AFHTTPRequestOperation *operation, id responseObject)
                     {
                         NSLog(@"JSON: %@", responseObject);
                         [self parseJsonResponse:responseObject];
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
                     {
                         NSLog(@"Error: %@", error);
                     }];
        
        // Put the request in the operation manager's queue to start it processing.
        [manager.operationQueue addOperation:operation];
    }
}

-(void)parseJsonResponse:(NSDictionary*)jsonResponse
{
    // first if there are no results don't do anything else
    NSArray* results = [jsonResponse valueForKey:@"results"];
    if (results == NULL || results.count <= 0)
    {
        return;
    }
    
    // reset this object's current search result data structure
    self.lastLocationSearchResult = [[NSMutableArray alloc] init];
    
    NSLog(@"Found %d JSON results", results.count);
    
    // parse the JSON and fill up a new instance of the data structure
    for(NSDictionary* resultDictionary in results)
    {
        NSString *locationName = [resultDictionary valueForKey:@"name"];
        NSString *lat;
        NSString *lon;
        NSArray* types;
        NSDictionary* geometryDic = [resultDictionary valueForKey:@"geometry"];
        if (geometryDic != NULL && geometryDic.count > 0)
        {
            NSDictionary* locationDic = [geometryDic valueForKey:@"location"];
            if (locationDic != NULL && locationDic.count > 0)
            {
                lat = [locationDic valueForKey:@"lat"];
                lon = [locationDic valueForKey:@"lng"];
            }
        }
        
        types = [resultDictionary valueForKey:@"types"];

        NSLog(@"Found location named %@ at LAT,LON (%@,  %@) of types %@",locationName, lat, lon, types	);
    
        LocationSearchResult *searchResult = [[LocationSearchResult alloc] init];
        searchResult.locationName = locationName;
        searchResult.lat = lat;
        searchResult.lon = lon;
        searchResult.types = types;
        [self.lastLocationSearchResult addObject:searchResult];
    }
    
    // refresh the search result list
    [self updateSearchResultUI];
}

-(void)updateSearchResultUI
{
    // if there are no results we can return.
    if(self.lastLocationSearchResult == NULL || self.lastLocationSearchResult.count <= 0)
    {
        return;
    }
    
    // tell the table view to reload its data.
    [searchResultTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.lastLocationSearchResult == NULL || self.lastLocationSearchResult.count <= 0)
    {
        return 0;
    }

    return self.lastLocationSearchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"LocationSearchTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    LocationSearchResult *searchResult = [self.lastLocationSearchResult objectAtIndex:indexPath.row];
    
    cell.textLabel.text = searchResult.locationName;
    return cell;
}

-(void)setControlState:(bool)useMyLocation
{
    AppSettings* settings = [AppSettings loadAppSettings];
    
    if(useMyLocation == TRUE)
    {
        searchButton.enabled = false;
        searchQueryField.enabled = false;
        settings->useMyLocation = true;
        self.searchQueryField.text = @"";
        [self.lastLocationSearchResult removeAllObjects];
        [searchResultTableView reloadData];
    }
    else{
        searchButton.enabled = true;
        searchQueryField.enabled = true;
        settings->useMyLocation = FALSE;
    }
    
    [AppSettings saveAppSettings:settings];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    AppSettings* settings = [AppSettings loadAppSettings];

    if (settings->useMyLocation)
    {
        [myLocationSwitch setOn:YES];
        [self setControlState:true];
        NSLog(@"SecondView controller initialized and switch is ON");
    }
    else
    {
        [myLocationSwitch setOn:NO];
        [self setControlState:false];
        NSLog(@"SecondView controller initialized and switch is OFF");
    }
    self.searchQueryField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@synthesize searchResultTableView;
@synthesize searchQueryField;
@end
