//
//  IMURLConnector.h
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMDataSource.h"

@class IMLoanResponse;

@interface IMURLConnector : IMDataSource

@property (nonatomic, strong) IMLoanResponse *response;

-(void)getLoansWithCompletion:(void(^)(NSError *error, IMLoanResponse *loans))completion;

@end
