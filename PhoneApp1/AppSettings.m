//
//  AppSettings.m
//  PhoneApp1
//
//  Created by Michael Dice on 3/6/14.
//  Copyright (c) 2014 Michael Dice. All rights reserved.
//

#import "AppSettings.h"

@implementation AppSettings

+(AppSettings*)loadAppSettings
{
    AppSettings* settings = [AppSettings alloc];
    NSUserDefaults* standardDefaults = [NSUserDefaults standardUserDefaults];
    settings->useMyLocation = [standardDefaults boolForKey:@"useMyLocation"];
    NSLog(@"AppSettings loaded value of %d", settings->useMyLocation);
    return settings;
}

+(void)saveAppSettings:(AppSettings*)settings
{
    NSUserDefaults* standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setBool:settings->useMyLocation forKey:@"useMyLocation"];
    [standardDefaults synchronize];
    NSLog(@"AppSettings saved value of %d", settings->useMyLocation);
}

@end