//
//  ZWSCNNodeLoader.h
//  Load3DFile
//
//  Created by zhangwei on 2018/8/16.
//  Copyright © 2018年 zhangwei. All rights reserved.
//

#import <ARKit/ARKit.h>
#import "ZWModelNode.h"

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(ios(11.0))
@interface ZWSCNNodeLoader : NSObject

@property (nonatomic, strong, readonly) NSArray <ZWModelNode *>* availableNodes;


/**
 从 dae 文件中加载模型
 
 @param url 模型路径
 @return 返回SCNNode节点
 */
- (nullable ZWModelNode *)loadDaeFormatModelNodeWithURL:(nonnull NSURL *)url;


/**
 从指定场景中加载节点

 @param scene 指定的场景
 @param nodeName 模型中节点名称
 @param recursively 是否递归查找
 @return 返回SCNNode节点
 */
- (nullable ZWModelNode *)loadNodeFromScene:(nonnull SCNScene *)scene nodeName:(nonnull NSString *)nodeName recursively:(BOOL)recursively;


/**
 从 obj 文件中加载模型

 @param url 模型路径
 @return 返回SCNNode节点
 */
- (nullable ZWModelNode *)loadObjFormatModelNodeWithURL:(nonnull NSURL *)url;



@end

NS_ASSUME_NONNULL_END
