//
//  ZWServerEnvironmentManager.h
//  Example
//
//  Created by zhangwei on 2018/9/15.
//  Copyright © 2018 zhangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWServerEnvironmentConfiguration.h"


/// 当调用 `- updateCurrentEnvironmentConfigurationForOnce`方法时会 post 该通知
FOUNDATION_EXPORT NSString *const ZWServerEnvironmentDidChangeBaseURLNotification;

@interface ZWServerEnvironmentManager : NSObject

/// 获取当前环境信息
@property (nonatomic, readonly, strong) ZWServerEnvironmentConfiguration *currentEnvironmentConfiguration;

/// 保存最近一次临时更新过的 baseURL（最近一次会覆盖上一次的tempBaseURL）
@property (nonatomic, readonly, copy) NSString *tempBaseURL;

/// 单例
+ (instancetype)manager;


#pragma mark -- 全局切换环境
/// 切换到 debug
- (void)switchToDebug;
/// 切换到 debug
- (void)switchToRelease;
/// 切换到自定义环境中
- (void)switchToCustomEnvironment:(ZWServerEnvironmentConfiguration *)environmentConfiguration;

#pragma mark -- 初始化环境



/// 典型初始化/默认初始化

- (void)typicalInitialization:(void(^)(ZWServerEnvironmentConfiguration *debugEnvironmentConfiguration,
                                       ZWServerEnvironmentConfiguration *releaseEnvironmentConfiguration))config;

/// 更新环境信息

/**
 更新当前所在环境信息

 @param isOnce 会不会影响全局
 @param callback 在该回调中更新环境信息
 */
- (void)updateCurrentEnvironmentConfigurationForOnce:(BOOL)isOnce configuration:(ZWServerEnvironmentConfiguration * (^)(ZWServerEnvironmentConfiguration *configuration))callback;



@end
