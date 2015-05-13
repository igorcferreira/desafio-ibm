//
//  FirstViewController.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import "FirstViewController.h"
#import "IMTableViewController.h"
#import "IMGeneralNumberDataSource.h"
#import "IMNumberCellBinder.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IMTableViewController *controller;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.controller = [[IMTableViewController alloc] initWithTable:self.tableView dataSource:[[IMGeneralNumberDataSource alloc] init] andBinder:[IMNumberCellBinder class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
