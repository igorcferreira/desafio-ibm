//
//  IMTableViewController.h
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class IMCellBinder;
@class IMDataSource;

@interface IMTableViewController : NSObject

-(instancetype)initWithTable:(UITableView*)tableView dataSource:(IMDataSource*)dataSource andBinder:(Class)binder;

@end
