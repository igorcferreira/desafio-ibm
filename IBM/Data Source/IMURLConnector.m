//
//  IMURLConnector.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import "IMURLConnector.h"
#import <AFNetworking.h>

#define LOAN_PATH       @"v1/loans/search.json"
#define LOAN_PARAMETER  @{@"status":@"fundraising"}

@interface IMURLConnector()

@property (nonatomic, strong) AFHTTPSessionManager* sessionManager;

@end

@implementation IMURLConnector

-(instancetype)initWithURL:(NSURL*)url {
    self = [super init];
    if(self) {
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

-(void)getLoansWithCompletion:(void(^)(NSError *error, NSArray *loans))completion
{
    [self.sessionManager GET:LOAN_PATH parameters:LOAN_PARAMETER success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(responseObject == nil || ![responseObject isKindOfClass:[NSDictionary class]]) {
            [self dispatchInvalidFormat:completion];
            return;
        }

        if(completion) {
            NSArray* loans = responseObject[@"loans"];
            completion(nil, loans);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(completion) {
            completion(error, nil);
        }
    }];
}

-(void)dispatchInvalidFormat:(void(^)(NSError *error, NSArray *loans))completion
{
    if(completion) {
        completion([NSError errorWithDomain:@"Invalid Response" code:500 userInfo:nil], nil);
    }
}

@end
