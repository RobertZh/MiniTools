//
//  ZWSCNNodeLoader.m
//  Load3DFile
//
//  Created by zhangwei on 2018/8/16.
//  Copyright © 2018年 zhangwei. All rights reserved.
//

#import "ZWSCNNodeLoader.h"
#import <ModelIO/ModelIO.h>
#import <SceneKit/ModelIO.h>



static NSMutableArray *totalModelNodes;

@interface ZWSCNNodeLoader ()

@property (nonatomic, strong) NSMutableArray <ZWModelNode *> *loadedNodes;

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end



@implementation ZWSCNNodeLoader

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (ZWModelNode *)loadDaeFormatModelNodeWithURL:(NSURL *)url
{
    ZWModelNode *node = [ZWModelNode node];
    SCNReferenceNode *referenceNode = [[SCNReferenceNode alloc] initWithURL:url];
    [referenceNode load];
    [node addChildNode:referenceNode];
    
    if (node) {
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        [self.loadedNodes addObject:node];
        dispatch_semaphore_signal(self.semaphore);
    }
    
    return node;
}

- (ZWModelNode *)loadNodeFromScene:(SCNScene *)scene nodeName:(NSString *)nodeName recursively:(BOOL)recursively
{
    return (ZWModelNode *)[scene.rootNode childNodeWithName:nodeName recursively:recursively];
}


- (ZWModelNode *)loadObjFormatModelNodeWithURL:(NSURL *)url
{
    MDLAsset *mdlAsset = [[MDLAsset alloc] initWithURL:url];
    MDLMesh * object = (MDLMesh *)[mdlAsset objectAtIndex:0];
    ZWModelNode *node = [ZWModelNode nodeWithMDLObject:object];
    if (node) {
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        [self.loadedNodes addObject:node];
        dispatch_semaphore_signal(self.semaphore);
    }
    return node;
}


- (NSArray<ZWModelNode *> *)availableNodes
{
    return self.loadedNodes;
}


#pragma mark -- Lazy loading
- (NSMutableArray<ZWModelNode *> *)loadedNodes {
    if (!_loadedNodes) {
        _loadedNodes = [NSMutableArray array];
    }
    return _loadedNodes;
}


- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(1);
    }
    return _semaphore;
}



@end
