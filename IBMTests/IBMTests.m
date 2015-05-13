//
//  IBMTests.m
//  IBMTests
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IMURLConnector.h"

@interface IBMTests : XCTestCase

@property (nonatomic, strong) IMURLConnector *connector;

@end

@implementation IBMTests

- (void)setUp {
    [super setUp];
    if(self.connector == nil) {
        self.connector = [[IMURLConnector alloc] initWithURL:[NSURL URLWithString:@"http://api.kivaws.org/"]];
    }
}

- (void)tearDown {
    [super tearDown];
}

-(void)testGetLoans {

}

@end
