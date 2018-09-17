//
//  ZWServerEnvironmentManager.m
//  Example
//
//  Created by zhangwei on 2018/9/15.
//  Copyright © 2018 zhangwei. All rights reserved.
//

#import "ZWServerEnvironmentManager.h"

NSString *const ZWServerEnvironmentDidChangeBaseURLNotification = @"ZWServerEnvironmentDidChangeBaseURLNotification";

@interface ZWServerEnvironmentManager()


@property (nonatomic, strong) ZWServerEnvironmentConfiguration *privateCurrentEnvironmentConfiguration;

@property (nonatomic, strong) ZWServerEnvironmentConfiguration *debugEnvironmentConfiguration;

@property (nonatomic, strong) ZWServerEnvironmentConfiguration *releaseEnvironmentConfiguration;


@end

@implementation ZWServerEnvironmentManager

static ZWServerEnvironmentManager *_manager = nil;
+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [self new];
    });
    return _manager;
}



- (void)typicalInitialization:(void (^)(ZWServerEnvironmentConfiguration *, ZWServerEnvironmentConfiguration *))config {
    __weak typeof(self)weakSelf = self;
    self.debugEnvironmentConfiguration = [ZWServerEnvironmentConfiguration new];
    self.releaseEnvironmentConfiguration = [ZWServerEnvironmentConfiguration new];
    if (config) {
        config(weakSelf.debugEnvironmentConfiguration, self.releaseEnvironmentConfiguration);
    }
}

- (void)updateCurrentEnvironmentConfigurationForOnce:(BOOL)isOnce
                                             configuration:(ZWServerEnvironmentConfiguration * (^)(ZWServerEnvironmentConfiguration *configuration))callback {
    if (!callback) {return;}
    
    ZWServerEnvironmentConfiguration *copiedConfiguration = [self.privateCurrentEnvironmentConfiguration copy];
    copiedConfiguration = callback(copiedConfiguration);
    if (!isOnce) {
        self.privateCurrentEnvironmentConfiguration = copiedConfiguration;
    }
    self->_tempBaseURL = copiedConfiguration.baseURL;
}


- (void)switchToDebug {
    [self switchToCustomEnvironment:self.debugEnvironmentConfiguration];
}

- (void)switchToRelease {
    [self switchToCustomEnvironment:self.releaseEnvironmentConfiguration];
}

- (void)switchToCustomEnvironment:(ZWServerEnvironmentConfiguration *)environmentConfiguration {
    self.privateCurrentEnvironmentConfiguration = environmentConfiguration;
    [[NSNotificationCenter defaultCenter] postNotificationName:ZWServerEnvironmentDidChangeBaseURLNotification object:environmentConfiguration];
}

- (ZWServerEnvironmentConfiguration *)currentEnvironmentConfiguration {
    return self.privateCurrentEnvironmentConfiguration;
}



@end
