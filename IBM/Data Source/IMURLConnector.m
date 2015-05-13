//
//  IMURLConnector.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import "IMURLConnector.h"
#import <AFNetworking.h>
#import "IMLoanResponse.h"

#define SERVER_URL [NSURL URLWithString:@"http://api.kivaws.org"]

#define LOAN_PATH       @"v1/loans/search.json"
#define LOAN_PARAMETER  @{@"status":@"fundraising"}

@interface IMURLConnector()

@property (nonatomic, strong) AFHTTPSessionManager* sessionManager;

@end

@implementation IMURLConnector

-(instancetype)init {
    self = [super init];
    if(self) {
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:SERVER_URL];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

-(void)getLoansWithCompletion:(void(^)(NSError *error, IMLoanResponse *loans))completion
{
    [self.sessionManager GET:LOAN_PATH parameters:LOAN_PARAMETER success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(responseObject == nil || ![responseObject isKindOfClass:[NSDictionary class]]) {
            [self dispatchInvalidFormat:completion];
            return;
        }

        if(completion) {
            _response = [[IMLoanResponse alloc] initWithDictionary:responseObject];
            completion(nil, self.response);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        _response = nil;
        if(completion) {
            completion(error, nil);
        }
    }];
}

-(id)objectForIndexPath:(NSIndexPath*)indexPath
{
    return self.response.loans[indexPath.row];
}

-(void)dispatchInvalidFormat:(void(^)(NSError *error, IMLoanResponse *loans))completion
{
    _response = nil;
    if(completion) {
        completion([NSError errorWithDomain:@"Invalid Response" code:500 userInfo:nil], nil);
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.response) {
        return [self.response.loans count];
    } else {
        return 0;
    }
}

@end
