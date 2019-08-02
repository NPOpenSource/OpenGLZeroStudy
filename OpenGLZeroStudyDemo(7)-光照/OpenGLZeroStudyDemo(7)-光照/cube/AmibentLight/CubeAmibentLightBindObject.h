//
//  CubeAmibentLightBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    CubeAmibentLightBindAttribLocationBegin = BaseBindLocationEnd,
    CubeAmibentLightBindAttribLocationVertexColor,
} CubeAmibentLightBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 vertextColor;
    };
    float t[6];
}CubeAmibentLightBindAttrib;

typedef enum {
    CubeDefaultUniformLocationBegin = BaseUniformLocationEnd,
    CubeDefaultUniformLocationAmbientLight
} CubeAmibentLightUniformLocation;

@interface CubeAmibentLightBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
