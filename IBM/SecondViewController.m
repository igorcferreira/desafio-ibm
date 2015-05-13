//
//  SecondViewController.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import "SecondViewController.h"
#import "IMURLConnector.h"

#define SERVER_URL [NSURL URLWithString:@"http://api.kivaws.org"]

@interface SecondViewController ()

@property (nonatomic, strong) IMURLConnector *connector;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *loans;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.connector = [[IMURLConnector alloc] initWithURL:SERVER_URL];
    [self.tableView setHidden:YES];
    [self.loadingIndicator setHidden:NO];
    self.loans = @[];
    [self.connector getLoansWithCompletion:^(NSError *error, NSArray *loans) {
        if(error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error on loading loans" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        } else {
            self.loans = loans;
            [self.tableView reloadData];
            [self.loadingIndicator setHidden:YES];
            [self.tableView setHidden:NO];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *loan = self.loans[indexPath.row];
    
    cell.textLabel.text = loan[@"name"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.loans count];
}

@end
