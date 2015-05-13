//
//  IMLoanCellBinder.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import "IMLoanCellBinder.h"
#import "IMLoan.h"
#import <UIKit/UIKit.h>

@implementation IMLoanCellBinder

+(UITableViewCell *)tableView:(UITableView *)tableView cellWithObject:(id)object
{
    static NSString *cellIdentifier = @"loanName";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if([object isKindOfClass:[IMLoan class]]) {
        [cell.textLabel setText:((IMLoan*)object).name];
    }
    
    return cell;
}

@end
