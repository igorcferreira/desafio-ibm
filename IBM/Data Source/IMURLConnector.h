//
//  IMURLConnector.h
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IMLoanResponse;

@interface IMURLConnector : NSObject

-(instancetype)initWithURL:(NSURL*)url;
-(void)getLoansWithCompletion:(void(^)(NSError *error, IMLoanResponse *loans))completion;

@end
