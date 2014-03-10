//
//  SecondViewController.h
//  PhoneApp1
//
//  Created by Michael Dice on 3/6/14.
//  Copyright (c) 2014 Michael Dice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    IBOutlet UIButton *searchButton;
    IBOutlet UITextField *searchQueryField;
    IBOutlet UISwitch *myLocationSwitch;
    IBOutlet UITableView *searchResultTableView;
}
@property (strong, nonatomic)NSMutableArray *lastLocationSearchResult;
@property (strong, nonatomic)UITableView *searchResultTableView;
@property (strong, nonatomic)UITextField *searchQueryField;
-(IBAction)useMyLocationChanged:(id)sender;
-(IBAction)searchForLocationClicked:(id)sender;
-(void)setControlState:(bool)useMyLocation;
-(void)parseJsonResponse:(NSDictionary*)jsonResponse;
-(void)updateSearchResultUI;
@end
