//
//  ZWServerEnvironmentManager.m
//  ExampleTests
//
//  Created by zhangwei on 2018/9/15.
//  Copyright © 2018 zhangwei. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZWServerEnvironmentManager.h"


@interface ZWServerEnvironmentManagerTest : XCTestCase

@end

@implementation ZWServerEnvironmentManagerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
//    NSString *url = [[ZWServerEnvironmentManager manager] globalURLStringWithDomainName:@"http://domain/" commonModule:@"first", @"second", nil];
//    NSLog(@"final url is [%@]", url);
    
    ZWServerEnvironmentManager *mgr = [ZWServerEnvironmentManager manager];
    
    [mgr typicalInitialization:^(ZWServerEnvironmentConfiguration *debugEnvironmentConfiguration, ZWServerEnvironmentConfiguration *releaseEnvironmentConfiguration) {
        debugEnvironmentConfiguration.domainName = @"debugEnvironmentConfiguration.domainName";
        debugEnvironmentConfiguration.otherCommonName = @"debugEnvironmentConfiguration.otherCommonName";
        
        releaseEnvironmentConfiguration.domainName = @"releaseEnvironmentConfiguration.domainName";
        releaseEnvironmentConfiguration.otherCommonName = @"releaseEnvironmentConfiguration.otherCommonName";
    }];
    
    [mgr switchToDebug];
    
    NSLog(@"current info : %@", mgr.currentEnvironmentConfiguration);
    NSLog(@"#####################################");
    [mgr switchToRelease];
    NSLog(@"current info : %@", mgr.currentEnvironmentConfiguration);
    
    mgr.currentEnvironmentConfiguration.domainName = @"111";
//    mgr.currentEnvironmentConfiguration = nil;
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
