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

NSArray *tableData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    tableData = [NSArray arrayWithObjects:
                 @"Eggs Benedict",
                 @"Mushroom Risotto",
                 @"Full Breakfast",
                 @"Hamburger",
                 @"Ham and Egg Sandwich",
                 @"Creme Brelee",
                 @"White Chocolate Donut",
                 @"Starbucks Coffee",
                 @"Vegetable Curry",
                 @"Instant Noodle with Egg",
                 @"Noodle with BBQ Pork",
                 @"Japanese Noodle with Pork",
                 @"Green Tea",
                 @"Thai Shrimp Cake",
                 @"Angry Birds Cake",
                 @"Ham and Cheese Panini",
                 nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
