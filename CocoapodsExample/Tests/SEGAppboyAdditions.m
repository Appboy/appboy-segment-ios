//
//  SEGAppboyAdditions.m
//  Segment-Appboy_Tests
//
//  Created by Xavier Jurado on 15/06/2019.
//  Copyright © 2019 Appboy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SEGAppboyAdditions.h"

@interface SEGAppboyAdditions : XCTestCase

@end

@implementation SEGAppboyAdditions

- (void)testNewEntriesAreReturned {
  NSDictionary *old = @{};
  NSDictionary *new = @{@"name": @"something"};
  NSDictionary *ret = [old sega_newOrDifferentEntriesFrom:new];

  XCTAssertEqualObjects(ret, new);
}

- (void)testDifferentEntriesAreReturned {
  NSDictionary *old = @{@"name": @"old value"};
  NSDictionary *new = @{@"name": @"new value"};
  NSDictionary *ret = [old sega_newOrDifferentEntriesFrom:new];

  XCTAssertEqualObjects(ret, new);
}

- (void)testExistingEntriesAreIgnored {
  NSDictionary *old = @{@"name": @"value"};
  NSDictionary *new = @{@"name": @"value"};
  NSDictionary *ret = [old sega_newOrDifferentEntriesFrom:new];

  XCTAssertTrue([[ret allKeys] count] == 0);
}

- (void)testDifferentExistingEntriesAreIgnored {
  NSDictionary *old = @{@"name": @"value", @"another_name": @"another value"};
  NSDictionary *new = @{@"name": @"value"};
  NSDictionary *ret = [old sega_newOrDifferentEntriesFrom:new];

  XCTAssertTrue([[ret allKeys] count] == 0);
}

@end
