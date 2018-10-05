// Copyright (C) 2018 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

#import <XCTest/XCTest.h>
#import "Person.h"
#import <objc/objc-runtime.h>

@interface Tests : XCTestCase
@end

@implementation Tests

- (void)setUp    { putchar('\n'); }
- (void)tearDown { putchar('\n'); }

- (void)testMessageSend
{
    Person *fred = [[Person alloc] initWithFirstName:@"Fred"
                                            lastName:@"Smith"
                                                 age:32];
    
    id (* sendMessage)(id, SEL, ...) = (id (*)(id, SEL, ...))objc_msgSend;
    SEL print = @selector(print);
    
    sendMessage(fred, print);
    sendMessage(fred, @selector(setFirstName:), @"Chip");
    [fred print];
    
    Class PersonClass = [Person class];
    Person *sue = sendMessage(PersonClass, @selector(alloc));
    sue = sendMessage(sue, @selector(initWithFirstName:lastName:age:), @"Sue", @"Yu", 42);
    [sue print];
}

@end
