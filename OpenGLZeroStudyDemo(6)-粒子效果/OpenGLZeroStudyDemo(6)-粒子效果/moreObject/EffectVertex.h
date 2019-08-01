//
//  EffectVertex.h
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/30.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "Vertex.h"

NS_ASSUME_NONNULL_BEGIN

@interface EffectVertex : Vertex
@property (nonatomic ,assign) GLKVector3 force ;
@property (nonatomic ,assign) NSTimeInterval beginTime ;
@property (nonatomic ,assign)  GLKVector3 beginVelocity  ;
@end

NS_ASSUME_NONNULL_END
