//
//  ViewController.m
//  Example
//
//  Created by zhangwei on 2018/9/15.
//  Copyright © 2018 zhangwei. All rights reserved.
//

#import "ViewController.h"
#import "ZWServerEnvironmentManager.h"
#import "ZWAViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZWServerEnvironmentManager *mgr = [ZWServerEnvironmentManager manager];
    
    [mgr updateCurrentEnvironmentConfigurationForOnce:YES configuration:^ZWServerEnvironmentConfiguration *(ZWServerEnvironmentConfiguration *configuration) {
        configuration.domain = @"http://www.temp-domain01";
        [configuration updateURLStringWithDomainName:@"http://www.temp-domain02" otherCommonFields:@"v1", @"news", nil];
        NSLog(@"------------------------------------------------");
        NSLog(@"url : %@", configuration.baseURL);
        NSLog(@"------------------------------------------------");
        return configuration;
    }];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"------------------------------------------------");
    NSLog(@"url : %@", ZWServerEnvironmentManager.manager.currentEnvironmentConfiguration.baseURL);
    NSLog(@"------------------------------------------------");
    
}

- (IBAction)pushA:(id)sender {
    ZWAViewController *avc = ZWAViewController.new;
    [self.navigationController pushViewController:((void)(avc.view.backgroundColor = UIColor.whiteColor), avc) animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"------------------------------------------------");
    NSLog(@"url : %@", [ZWServerEnvironmentManager manager].currentEnvironmentConfiguration.baseURL);
    NSLog(@"------------------------------------------------");
}


@end
