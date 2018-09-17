//
//  ZWServerEnvironmentConfiguration.m
//  Example
//
//  Created by zhangwei on 2018/9/17.
//  Copyright © 2018 zhangwei. All rights reserved.
//

#import "ZWServerEnvironmentConfiguration.h"

@implementation ZWServerEnvironmentConfiguration

NS_INLINE void deleteLastSlashIfExists(NSString *__autoreleasing *string)
{
    if ([*string characterAtIndex:(*string).length - 1] == '/')
        *string = [*string substringToIndex:(*string).length - 1];
}


- (instancetype)updateURLStringWithDomainName:(NSString *)domainName otherCommonFields:(NSString *)commonModule, ... {
    deleteLastSlashIfExists(&domainName);
    NSMutableArray *urlCompents = [NSMutableArray array];
    [urlCompents addObject:domainName];
    if (commonModule) {
        [urlCompents addObject:commonModule];
        va_list argvs;
        NSString *argv;
        va_start(argvs, commonModule);
        while ((argv = va_arg(argvs, NSString *))) {
            [urlCompents addObject:argv];
        }
        va_end(argvs);
    }
    
    _baseURL = [urlCompents componentsJoinedByString:@"/"];
    _domain = domainName;
    [urlCompents removeObject:domainName];
    _otherCommonFields = [urlCompents componentsJoinedByString:@"/"];
    
    return self;
}


- (void)setDomain:(NSString *)domainName {
    _domain = domainName;
    if (!([domainName characterAtIndex:domainName.length - 1] == '/')) {_domain = [_domain stringByAppendingString:@"/"];}
    if (!_otherCommonFields) { _otherCommonFields = @"";}
    _baseURL = [_domain stringByAppendingString:_otherCommonFields];
}

- (void)setOtherCommonFields:(NSString *)otherCommonName {
    _otherCommonFields = otherCommonName;
    _baseURL = [_domain stringByAppendingString:otherCommonName];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"{ \"domainName\" : %@, \"otherCommonFields\" : %@, \"baseURL\" : %@}", self.domain, self.otherCommonFields, self.baseURL];
}


- (id)copyWithZone:(NSZone *)zone {
    ZWServerEnvironmentConfiguration *confi = [ZWServerEnvironmentConfiguration new];
    confi.baseURL = _baseURL;
    confi.domain = _domain;
    confi.otherCommonFields = _otherCommonFields;
    return confi;
}

@end
