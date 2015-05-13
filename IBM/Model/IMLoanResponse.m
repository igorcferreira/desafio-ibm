//
//  LoanResponse.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import "IMLoanResponse.h"
#import "IMPaging.h"
#import "IMLoan.h"

@implementation IMLoanResponse

-(NSArray *)parsableElements
{
    return @[@"paging",@"loans"];
}

-(id)parseObject:(id)element withKey:(NSString *)hey
{
    if([hey isEqualToString:@"paging"]) {
        return [[IMPaging alloc] initWithDictionary:element];
    } else if([hey isEqualToString:@"loans"]) {
        
        NSMutableArray *elements = [[NSMutableArray alloc] init];
        for(NSDictionary *loan in element) {
            [elements addObject:[[IMLoan alloc] initWithDictionary:loan]];
        }
        
        return [NSArray arrayWithArray:elements];
    } else {
        return element;
    }
}

@end
