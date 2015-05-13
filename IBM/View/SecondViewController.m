//
//  SecondViewController.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import "SecondViewController.h"
#import "IMURLConnector.h"
#import "IMLoanResponse.h"
#import "IMLoan.h"
#import "IMTableViewController.h"
#import "IMLoanCellBinder.h"
#import "IMAnimatedTableViewHandler.h"

@interface SecondViewController ()
@property (nonatomic, strong) IMTableViewController *tableViewController;
@property (nonatomic, strong) IMAnimatedTableViewHandler *tableViewDelegate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IMURLConnector *connector = [[IMURLConnector alloc] init];
    
    self.tableViewController = [[IMTableViewController alloc] initWithTable:self.tableView dataSource:connector andBinder:[IMLoanCellBinder class]];
    self.tableViewDelegate = [[IMAnimatedTableViewHandler alloc] initWithTableView:self.tableView];
    
    [self.tableView setHidden:YES];
    [self.loadingIndicator setHidden:NO];
    
    [connector getLoansWithCompletion:^(NSError *error, IMLoanResponse *loans) {
        if(error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error on loading loans" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        } else {
            [self.tableView reloadData];
            [self.loadingIndicator setHidden:YES];
            [self.tableView setHidden:NO];
        }
    }];
}

@end
