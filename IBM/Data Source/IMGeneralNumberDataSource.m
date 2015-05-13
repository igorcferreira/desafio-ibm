//
//  IMGeneralNumberDataSource.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import "IMGeneralNumberDataSource.h"

@implementation IMGeneralNumberDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

-(id)objectForIndexPath:(NSIndexPath *)indexPath
{
    return [NSNumber numberWithInteger:(indexPath.row + 1)];
}

@end