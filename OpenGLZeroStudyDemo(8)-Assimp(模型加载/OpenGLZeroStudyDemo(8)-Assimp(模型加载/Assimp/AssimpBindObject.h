//
//  AssimpBindObject.h
//  OpenGLZeroStudyDemo(8)-Assimp(模型加载
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
// Attribute identifiers
typedef enum {
    aPos,
//    aNormal,
    aTexCoords,
} BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
//        GLKVector3 aNormal;
        GLKVector2 aTexCoords;
    };
    float a[5];
}assimpBindAtt;

typedef enum {
    uniform_model,
    uniform_view,
    uniform_projection,
    uniform_diffuse,
    uniform_specular,
    uniform_height
} assimpUniformLocation;

@interface AssimpBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
