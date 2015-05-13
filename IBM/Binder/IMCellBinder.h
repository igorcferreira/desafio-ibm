//
//  IMCellBinder.h
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UITableView;
@class UITableViewCell;

@interface IMCellBinder : NSObject

+(UITableViewCell *)tableView:(UITableView *)tableView cellWithObject:(id)object;

@end
