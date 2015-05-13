//
//  IMTableViewController.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import "IMTableViewController.h"
#import "IMCellBinder.h"
#import "IMDataSource.h"
#import <UIKit/UIKit.h>

@interface IMTableViewController() <UITableViewDataSource>

@property (nonatomic, strong) IMDataSource *dataSource;
@property (nonatomic, strong) Class cellBinder;

@end

@implementation IMTableViewController

-(instancetype)initWithTable:(UITableView*)tableView dataSource:(IMDataSource*)dataSource andBinder:(Class)binder
{
    self = [super init];
    if(self) {
        tableView.dataSource = self;
        self.dataSource = dataSource;
        self.cellBinder = binder;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource numberOfSectionsInTableView:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource tableView:tableView numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellBinder tableView:tableView cellWithObject:[self.dataSource objectForIndexPath:indexPath]];
}

@end
