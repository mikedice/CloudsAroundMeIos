//
//  FirstViewController.h
//  PhoneApp1
//
//  Created by Michael Dice on 3/6/14.
//  Copyright (c) 2014 Michael Dice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationSearchResult.h"
#import "AppSettings.h"

@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate	>
{
    IBOutlet UIButton* pauseResumeButton;
    IBOutlet UITableView* dataTableView;
}

@property(strong, nonatomic) UIButton* pauseResumeButton;
@property(strong, nonatomic) UITableView* dataTableView;

- (void)viewDidDisappear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)startQueryLoop;
- (void)stopQueryLoop;
- (void) beginQueryTwitter;
- (LocationSearchResult*) getLocationToUse;
@end

