//
//  CubeDefaultBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    CubeDefaultBindAttribLocationBegin = BaseBindLocationEnd,
    CubeDefaulttBindAttribLocationVertexColor,
} CubeDefaultBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 vertextColor;
    };
    float t[6];
}CubeDefaultBindAttrib;

typedef enum {
    CubeDefaultUniformLocationBegin = BaseUniformLocationEnd,
} CubeDefaultUniformLocation;

@interface CubeDefaultBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
