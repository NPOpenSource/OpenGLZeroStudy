//
//  FaceCullingDefaultBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
// Attribute identifiers
typedef enum {
    FCD_aPos,
    //    aNormal,
    FCD_aTexCoords,
} FCD_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexCoords;
    };
    float a[5];
}FCD_BindAtt;

typedef enum {
    FCD_uniform_model,
    FCD_uniform_view,
    FCD_uniform_projection,
     FCD_uniform_Texture
} FCD_UniformLocation;

@interface FaceCullingDefaultBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
