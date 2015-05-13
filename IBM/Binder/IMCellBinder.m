//
//  IMCellBinder.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import "IMCellBinder.h"

@implementation IMCellBinder

+(UITableViewCell *)tableView:(UITableView *)tableView cellWithObject:(id)object
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @throw [NSException exceptionWithName:@"Invalid Binder" reason:@"The binder need to be implemented" userInfo:nil];
}

@end
