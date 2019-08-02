//
//  LightBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    LightBindAttribLocationBegin = BaseBindLocationEnd,
   LightBindAttribLocationTexture,
} LightBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector2 texture;
    };
    float t[5];
}LightBindAttrib;

typedef enum {
    LightUniformLocationBegin = BaseUniformLocationEnd,
    LightUniformLocationAmbientLight   //环境光
  
} LightUniformLocation;

@interface LightBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
