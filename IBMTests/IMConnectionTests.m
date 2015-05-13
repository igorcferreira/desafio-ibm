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
#import "IMLoanResponse.h"
#import <OHHTTPStubs.h>

#define LOAN_PATH       @"/v1/loans/search.json"
#define LOAN_PARAMETER  @"status=fundraising"

@interface IMConnectionTests : XCTestCase

@property (nonatomic, strong) IMURLConnector *connector;
@property (nonatomic, strong) NSError *responseError;
@property (nonatomic, strong) IMLoanResponse *responseLoans;

@end

@implementation IMConnectionTests

#pragma mark -
#pragma mark Every job behaviour
#pragma mark -

- (void)setUp {
    [super setUp];
    if(self.connector == nil) {
        self.connector = [[IMURLConnector alloc] initWithURL:[NSURL URLWithString:@"http://api.kivaws.org/"]];
    }
    self.responseError = nil;
    self.responseLoans = nil;
}

- (void)tearDown {
    [OHHTTPStubs removeAllStubs];
    [super tearDown];
}

#pragma mark -
#pragma mark Helper method
#pragma mark -

-(void)stubWithResponse:(OHHTTPStubsResponse*)response
{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:LOAN_PATH]
        && [request.URL.query isEqualToString:LOAN_PARAMETER];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return response;
    }];
}

-(void)asyncGetLoans
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Getting Loans"];
    
    [self.connector getLoansWithCompletion:^(NSError *error, IMLoanResponse *loans) {
        self.responseError = error;
        self.responseLoans = loans;
        [expectation fulfill];
    }];
}

-(void)lockAndHandle:(void(^)(NSError* error))handler
{
    NSTimeInterval timeout = 10;
    [self waitForExpectationsWithTimeout:timeout handler:handler];
}

#pragma mark -
#pragma mark Response Builder
#pragma mark -

-(OHHTTPStubsResponse*)validResponse
{
    NSString *valid = OHPathForFile(@"valid.json", self.class);
    return [[OHHTTPStubsResponse responseWithFileAtPath:valid
                                            statusCode:200
                                               headers:@{@"Content-Type":@"application/json"}]
            responseTime:OHHTTPStubsDownloadSpeedEDGE];
}

-(OHHTTPStubsResponse*)emptyResponse
{
    NSString *empty = OHPathForFile(@"emptyLoans.json", self.class);
    return [[OHHTTPStubsResponse responseWithFileAtPath:empty
                                             statusCode:200
                                                headers:@{@"Content-Type":@"application/json"}]
            responseTime:OHHTTPStubsDownloadSpeedEDGE];
}

-(OHHTTPStubsResponse*)invalidResponse
{
    NSString *invalid = OHPathForFile(@"invalid.json", self.class);
    return [[OHHTTPStubsResponse responseWithFileAtPath:invalid
                                             statusCode:200
                                                headers:@{@"Content-Type":@"application/json"}]
            responseTime:OHHTTPStubsDownloadSpeedEDGE];
}

-(OHHTTPStubsResponse*)serverErrorResponse
{
    NSString *serverError = OHPathForFile(@"invalid.json", self.class);
    return [[OHHTTPStubsResponse responseWithFileAtPath:serverError
                                             statusCode:500
                                                headers:@{@"Content-Type":@"application/json"}]
            responseTime:OHHTTPStubsDownloadSpeedEDGE];
}

-(OHHTTPStubsResponse*)errorResponse
{
    NSError* notConnectedError = [NSError errorWithDomain:NSURLErrorDomain code:kCFURLErrorNotConnectedToInternet userInfo:nil];
    return [OHHTTPStubsResponse responseWithError:notConnectedError];
}

#pragma mark -
#pragma mark Test suit
#pragma mark -

-(void)testValidResponse {

    [self stubWithResponse:[self validResponse]];
    
    [self asyncGetLoans];
    
    [self lockAndHandle:^(NSError *error) {
        XCTAssertNil(error, @"Timeout requisition");
        XCTAssertNil(self.responseError, @"The operation returned with error: %@", self.responseError.debugDescription);
        XCTAssertNotNil(self.responseLoans, @"Invalid loans");
        XCTAssertNotNil(self.responseLoans.loans, @"Empty loans");
        XCTAssertTrue(self.responseLoans.loans.count == 20,@"Empty loans");
    }];
}

-(void)testEmptyResponse {
    [self stubWithResponse:[self emptyResponse]];
    
    [self asyncGetLoans];
    
    [self lockAndHandle:^(NSError *error) {
        XCTAssertNil(error, @"Timeout requisition");
        XCTAssertNil(self.responseError, @"Empty loan did dispatch error");
        XCTAssertNotNil(self.responseLoans, @"Empty loan didn't created response array");
        XCTAssertTrue([self.responseLoans.loans count] == 0, @"Loan is not empty");
    }];
}

-(void)testInvalidResponse {
    [self stubWithResponse:[self invalidResponse]];
    
    [self asyncGetLoans];
    
    [self lockAndHandle:^(NSError *error) {
        XCTAssertNil(error, @"Timeout requisition");
        XCTAssertNotNil(self.responseError, @"Empty loan did not dispatch error");
        XCTAssertNil(self.responseLoans, @"Empty loan created response array");
    }];
}

-(void)testServerError {
    [self stubWithResponse:[self serverErrorResponse]];
    
    [self asyncGetLoans];
    
    [self lockAndHandle:^(NSError *error) {
        XCTAssertNil(error, @"Timeout requisition");
        XCTAssertNotNil(self.responseError, @"Empty loan did not dispatch error");
        XCTAssertNil(self.responseLoans, @"Empty loan created response array");
    }];
}

-(void)testErrorResponse {
    [self stubWithResponse:[self errorResponse]];
    
    [self asyncGetLoans];
    
    [self lockAndHandle:^(NSError *error) {
        XCTAssertNil(error, @"Timeout requisition");
        XCTAssertNotNil(self.responseError, @"Empty loan did not dispatch error");
        XCTAssertNil(self.responseLoans, @"Empty loan created response array");
    }];
}

@end
