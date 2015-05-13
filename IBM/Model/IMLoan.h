//
//  Loan.h
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMSerializableModel.h"

@interface IMLoan : IMSerializableModel

@property (nonatomic, strong, readonly) NSNumber *key;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *status;
@property (nonatomic, strong, readonly) NSString *activity;
@property (nonatomic, strong, readonly) NSString *sector;
@property (nonatomic, strong, readonly) NSString *use;

@end
