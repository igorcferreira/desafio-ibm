//
//  IMNumberCellBinder.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import "IMNumberCellBinder.h"
#import <UIKit/UIKit.h>

@implementation IMNumberCellBinder

+(UITableViewCell *)tableView:(UITableView *)tableView cellWithObject:(id)object
{
    static NSString *cellIdentifier = @"numberCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *cellText = @"";
    
    if([object integerValue] % 5 == 0) {
        cellText = [cellText stringByAppendingString:@"Hey"];
    }
    
    if([object integerValue] % 3 == 0) {
        cellText = [cellText stringByAppendingString:@" Buu"];
    }
    
    [cell.textLabel setText:[cellText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return cell;
}

@end
