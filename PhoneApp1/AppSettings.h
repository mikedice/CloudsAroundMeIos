//
//  AppSettings.h
//  PhoneApp1
//
//  Created by Michael Dice on 3/6/14.
//  Copyright (c) 2014 Michael Dice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSettings : NSObject
{
@public
    BOOL useMyLocation;
}
+(AppSettings*)loadAppSettings;
+(void)saveAppSettings:(AppSettings*)settings;
@end
