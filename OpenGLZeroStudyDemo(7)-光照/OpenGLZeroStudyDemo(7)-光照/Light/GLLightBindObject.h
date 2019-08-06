//
//  GLLightBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/6.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    LightBindAttribLocationBegin = BaseBindLocationEnd,
    LightBindAttribLocationVertexColor,
    LightBindAttribLocationNormal
}LightBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 vertextColor;
    };
    float t[6];
}LightBindAttrib;

typedef union{
    struct {
        GLKVector3 lightPos;
        GLKVector3 ambient;
        GLKVector3 diffuse;
        GLKVector3 specular;
    };
    float m[12];
}Light;

typedef union{
    struct {
        GLKVector3 ambient;
        GLKVector3 diffuse;
        GLKVector3 specular;
        float shininess;
    };
    float m[10];
}MaterialObject;



typedef enum {
    LightUniformLocationBegin = BaseUniformLocationEnd,
    LightUniformLocationModel,
    LightUniformLocationInvermodel,
    LightUniformLocationviewPos,
    LightUniformLocationLightPos, //
    LightUniformLocationLightAmbient, //材质
    LightUniformLocationLightDiffuse,
    LightUniformLocationLightsSpecular,
    MaterialObjectUniformLocationMaterialAmbient, //材质
    MaterialObjectUniformLocationMaterialDiffuse,
    MaterialObjectUniformLocationMaterialsSpecular,
    MaterialObjectUniformLocationMaterialShininess
}LightUniformLocation;

@interface GLLightBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
