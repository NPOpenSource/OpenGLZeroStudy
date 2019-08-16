//
//  AssimpParse.h
//  OpenGLZeroStudyDemo(8)-Assimp(模型加载
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssimpBindObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface AssimpParse : NSObject
-(void)parse;
-(void)draw:(AssimpBindObject * )bindObject;

@end

NS_ASSUME_NONNULL_END
