//
//  ZWServerEnvironmentConfiguration.h
//  Example
//
//  Created by zhangwei on 2018/9/17.
//  Copyright © 2018 zhangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWServerEnvironmentConfiguration : NSObject <NSCopying>
/// 域名
@property (nonatomic, copy) NSString *domain;
/// 其他公共字段："http://www.example/commonField1/commonField2"，这里otherCommonFields = "commonField1/commonField2"
@property (nonatomic, copy) NSString *otherCommonFields;
/// domain + otherCommonFields
@property (nonatomic, copy) NSString *baseURL;




/**
 更新domain或者otherCommonFields。\
 注意！这不是该类的初始化方法，该类的初始化方法已经在ZWServerEnvironmentManager初始化过，调用者无需再次手动初始化。

 @param domainName 更新 domain，传 nil 表示对应位置不需要更新
 @param otherCommonFields 更新 otherCommonFields，传 nil 表示对应位置不需要更新
 @return 返回自身引用
 */
- (instancetype)updateURLStringWithDomainName:(NSString *)domainName
                       otherCommonFields:(NSString *)otherCommonFields, ... NS_REQUIRES_NIL_TERMINATION;



@end
