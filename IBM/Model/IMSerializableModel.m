//
//  IMSerializableModel.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//
#import <objc/runtime.h>
#import "IMSerializableModel.h"

@implementation IMSerializableModel

- (NSArray *)allPropertyNames
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *rv = [NSMutableArray array];
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    free(properties);
    return rv;
}

-(instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        NSArray *propertyList = [self allPropertyNames];
        NSArray *parsableElements = [self parsableElements];
        NSDictionary *keyMapper = [self keyMapper];
        
        for(NSString *property in propertyList) {
            NSString *dictKey = property;
            
            if([keyMapper.allKeys indexOfObject:property] != NSNotFound) {
                dictKey = keyMapper[property];
            }
            
            id object = [dictionary objectForKey:dictKey];
            
            if([parsableElements indexOfObject:property] != NSNotFound) {
                [self setValue:[self parseObject:object withKey:property] forKey:property];
            } else {
                [self setValue:object forKey:property];
            }
        }
    }
    return self;
}

-(NSArray*)parsableElements
{
    return @[];
}

-(NSDictionary*)keyMapper
{
    return @{};
}

-(id)parseObject:(id)element withKey:(NSString*)hey
{
    return element;
}

@end