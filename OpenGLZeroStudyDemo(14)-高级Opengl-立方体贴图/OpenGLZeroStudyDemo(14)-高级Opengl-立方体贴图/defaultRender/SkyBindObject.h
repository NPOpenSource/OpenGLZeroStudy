//
//  SkyBindObject.h
//  OpenGLZeroStudyDemo(14)-高级Opengl-立方体贴图
//
//  Created by glodon on 2019/9/2.
//  Copyright © 2019 openSource. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
// Attribute identifiers
typedef enum {
    SKB_aPos,
} SKB_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
    };
    float a[3];
}SKB_BindAtt;

typedef enum {
    SKB_uniform_view,
    SKB_uniform_projection,
    SKB_uniform_Texture
} SKB_UniformLocation;

@interface SkyBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
