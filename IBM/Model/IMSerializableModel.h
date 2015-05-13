//
//  IMSerializableModel.h
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMSerializableModel : NSObject

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;
-(NSDictionary*)keyMapper;
-(NSArray*)parsableElements;
-(id)parseObject:(id)element withKey:(NSString*)hey;

@end
