//
//  LoanResponse.h
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMSerializableModel.h"

@class IMPaging;

@interface IMLoanResponse : IMSerializableModel

@property (nonatomic, strong, readonly) IMPaging    *paging;
@property (nonatomic, strong, readonly) NSArray     *loans;

@end
