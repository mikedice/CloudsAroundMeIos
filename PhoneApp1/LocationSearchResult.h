//
//  LocationSearchResult.h
//  PhoneApp1
//
//  Created by Michael Dice on 3/7/14.
//  Copyright (c) 2014 Michael Dice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationSearchResult : NSObject
@property (strong, nonatomic) NSString *locationName;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;
@property (strong, nonatomic) NSArray* types;
@end
