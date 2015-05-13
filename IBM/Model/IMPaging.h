//
//  IMPaging.h
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMSerializableModel.h"

@interface IMPaging : IMSerializableModel

@property (nonatomic, strong, readonly) NSNumber *page;
@property (nonatomic, strong, readonly) NSNumber *total;
@property (nonatomic, strong, readonly) NSNumber *pageSize;
@property (nonatomic, strong, readonly) NSNumber *pages;

@end
