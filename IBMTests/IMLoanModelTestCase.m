//
//  IMLoanModelTestCase.m
//  IBM
//
//  Created by Igor Ferreira on 5/13/15.
//  Copyright (c) 2015 Igor Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IMLoan.h"

@interface IMLoanModelTestCase : XCTestCase

@end

@implementation IMLoanModelTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(NSDictionary*)retrieveJsonInformationForFile:(NSString*)file
{
    NSString *loanPath = [[NSBundle bundleForClass:[self class]] pathForResource:file ofType:@"json"];
    NSData *loanData = [NSData dataWithContentsOfFile:loanPath];
    
    NSError *error;
    NSDictionary *loanDictionary = [NSJSONSerialization JSONObjectWithData:loanData options:NSJSONReadingAllowFragments error:&error];
    
    XCTAssertNil(error,@"Error on parse json");
    
    return loanDictionary;
}

- (void)testParseLoan {
    NSDictionary *loanDictionary = [self retrieveJsonInformationForFile:@"loan"];
    
    XCTAssertNotNil(loanDictionary, @"Error on parse json");
    
    IMLoan* loan = [[IMLoan alloc] initWithDictionary:loanDictionary];
    
    XCTAssertNotNil(loan, @"Error on parse");
    XCTAssertEqualObjects(loan.name, @"Flocerfida", @"Invalid Name");
    XCTAssertEqualObjects(loan.key, @883595, @"Invalid Id");
    XCTAssertEqualObjects(loan.status, @"fundraising", @"Invalid Status");
    XCTAssertEqualObjects(loan.activity, @"General Store", @"Invalid Activity");
    XCTAssertEqualObjects(loan.sector, @"Retail", @"Invalid Sector");
    XCTAssertEqualObjects(loan.use, @"to buy items to sell like canned goods, personal care products, noodles, spices, coffee, milk, and other products.", @"Invalid Use");
}

@end
