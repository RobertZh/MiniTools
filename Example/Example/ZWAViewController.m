//
//  ZWAViewController.m
//  Example
//
//  Created by zhangwei on 2018/9/17.
//  Copyright © 2018 zhangwei. All rights reserved.
//

#import "ZWAViewController.h"
#import "ZWServerEnvironmentManager.h"

@interface ZWAViewController ()



@end

@implementation ZWAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZWAViewController";
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self changeDomainName];
}


- (void)changeDomainName {
    [ZWServerEnvironmentManager.manager updateCurrentEnvironmentConfigurationForOnce:YES configuration:^ZWServerEnvironmentConfiguration *(ZWServerEnvironmentConfiguration *configuration) {
        [configuration updateURLStringWithDomainName:@"http://www.temp2-domain01" otherCommonFields:nil, nil];
        return configuration;
    }];
    
    
    
    
}


@end
