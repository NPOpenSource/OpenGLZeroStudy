//
//  MeshVertex.h
//  OpenGLZeroStudyDemo(8)-Assimp(模型加载
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeshVertex : NSObject
@property (nonatomic ,assign)  GLKVector3  Position ;
//@property (nonatomic ,assign)  GLKVector3  Normal ;
@property (nonatomic ,assign)  GLKVector2  TexCoords ;
//@property (nonatomic ,assign)  GLKVector3 Tangent;
//@property (nonatomic ,assign)  GLKVector3 Bitangent;
@end

NS_ASSUME_NONNULL_END
