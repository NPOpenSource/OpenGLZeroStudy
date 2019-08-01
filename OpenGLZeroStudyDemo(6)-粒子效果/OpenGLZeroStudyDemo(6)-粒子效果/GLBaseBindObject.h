//
//  GLBaseBindObject.h
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/29.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

// Attribute identifiers
typedef enum {
    BeginPosition = 0,
    p_diameter,
    BaseBindLocationEnd
} BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 beginPosition;
        GLfloat p_diameter;
    };
    float t[4];
}BaseBindAttribType;



typedef enum {
    Samplers2D = 0,
    MVPMatrix,
    BaseUniformLocationEnd,
} BaseUniformLocation;

#define uniformsMaxCount 100

NS_ASSUME_NONNULL_BEGIN

@interface GLBaseBindObject : NSObject
{
    @public
     GLint uniforms[uniformsMaxCount];
}

@property (nonatomic ,copy) void(^uniformSetterBlock)(GLuint program);

-(void)BindAttribLocation:(GLuint) program;
-(NSString *)getShaderName;


-(GLint)getUnformIndex:(NSString *)uniform;

@end

NS_ASSUME_NONNULL_END
