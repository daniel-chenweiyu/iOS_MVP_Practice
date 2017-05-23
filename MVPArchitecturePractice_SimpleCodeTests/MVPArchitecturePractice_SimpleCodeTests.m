//
//  MVPArchitecturePractice_SimpleCodeTests.m
//  MVPArchitecturePractice_SimpleCodeTests
//
//  Created by DanielChen on 2017/5/19.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BookPresenter.h"

@interface MVPArchitecturePractice_SimpleCodeTests <BookViewDelegate> : XCTestCase
@property BookPresenter *presenter;
@end

@implementation MVPArchitecturePractice_SimpleCodeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _presenter = [BookPresenter new];
    [_presenter attachView:self];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [_presenter detachView];
    _presenter = nil;
    [super tearDown];
}

- (void)testGetBooks {
    
    [[NSUserDefaults standardUserDefaults] setObject:@[@"tt"] forKey:@"books"];
    //    NSMutableArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"books"];
    XCTestExpectation *expectation = [self expectationWithDescription:@"catch is called"];
    NSLog(@"=====================Test 3");
    dispatch_async(dispatch_queue_create("createQueue", NULL), ^{
        NSLog(@"=====================Test 4");
        [_presenter getBooks];
        [NSThread sleepForTimeInterval:5];
        NSLog(@"=====================Test 5");
        NSMutableArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"books"];
        XCTAssertEqual(array.count, 2,@"NSUserDefaults must have 2 componts");
        [expectation fulfill];
    });
    NSLog(@"=====================Test 6");
    [self waitForExpectationsWithTimeout:6 handler:^(NSError *error) {
        NSLog(@"=====================Test 7");
        if (error) {
            XCTFail(@"wait for over 6 sec");
        }
        
    }];
    NSLog(@"=====================Test 7");
}
@end
