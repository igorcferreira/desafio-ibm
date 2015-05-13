//
//  IMDataSource.h
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IMDataSource : NSObject <UITableViewDataSource>
-(id)objectForIndexPath:(NSIndexPath*)indexPath;
@end
