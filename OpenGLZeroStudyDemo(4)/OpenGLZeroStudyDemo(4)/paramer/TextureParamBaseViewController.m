//
//  TextureParamBaseViewController.m
//  OpenGLZeroStudyDemo(4)
//
//  Created by glodon on 2019/7/23.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "TextureParamBaseViewController.h"

@interface TextureParamBaseViewController ()
@property (nonatomic ,strong) TextureUnit * textureUnit0 ;
@end

@implementation TextureParamBaseViewController

-(void)createEagContext{
    self.eagcontext = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.eagcontext];
}

-(void)configure{
    GLKView *view = (GLKView*)self.view;
    view.context = self.eagcontext;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
}

-(void)createShader{
    self.shader = [Shader new];
    [self.shader compileLinkSuccessShaderName:@"Shader1" completeBlock:^(GLuint program) {
        glBindAttribLocation(program, GLKVertexAttribPosition, "position");  // 0代表枚举位置
        glBindAttribLocation(program, GLKVertexAttribTexCoord0, "texCoord0");
    }];
    _vertexcolor =  glGetUniformLocation(self.shader.program, "color");
    
}


#define VertexNum 4
#define eachVertexNum 4

#define textureFloat 5.0
static GLfloat s_vertex[4*4] = {
    1,1, 0,textureFloat, //1
    -1,1,textureFloat,textureFloat,//0
    -1,-1,textureFloat,0, //2
    1,-1,0,0//3
};

#define checkImageWidth 64
#define checkImageHeight 64
static float checkImage[checkImageHeight][checkImageWidth][4];
//产生纹理的函数
void makeCheckImage(void)
{
    int i, j;
    for ( i = 0; i < checkImageHeight; ++i )
        for( j = 0; j < checkImageWidth; ++j )
        {
            int m =  i/16+1;
            int n = j/16+1;
            if ((m+n)%2==0) {
                checkImage[i][j][0] = 0.0;
                checkImage[i][j][1] = 0.0;
                checkImage[i][j][2] = 0.0;
                checkImage[i][j][3] = 1.0;
            }else{
                checkImage[i][j][0] = 1.0;
                checkImage[i][j][1] = 1.0;
                checkImage[i][j][2] = 1.0;
                checkImage[i][j][3] = 1.0;
            }
            
        }
}
-(void)loadVertex{
    
}

-(void)loadVertexConfig:(GLfloat)config{
    self.vertex = [Vertex new];
    [self.vertex allocVertexNum:VertexNum andEachVertexNum:eachVertexNum];
    for (int i =0; i<VertexNum; i++) {
        GLfloat vertex[4];
        vertex[0] = s_vertex[i*VertexNum];
        vertex[1] = s_vertex[i*VertexNum+1];
        vertex[2] = s_vertex[i*VertexNum+2];
        vertex[3] = s_vertex[i*VertexNum+3];
        [self.vertex setVertex:vertex index:i];
    }
    self.textureUnit0 = [TextureUnit new];
//    makeCheckImage();
//    [self.textureUnit0 setPixels:checkImage pixelsWidth:checkImageWidth pixelsHeight:checkImageHeight IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:^{
//        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
//        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
//        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, config);
//        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, config);
//    } PixelFormat:GL_RGBA];
    UIImage *  image = [UIImage imageNamed:@"1.jpg"];
    [self.textureUnit0 setImage:image IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:^{
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
                glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, config);
                glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, config);
            }];

    int a =  glGetUniformLocation(self.shader.program, "sam2DR");
    [self.textureUnit0 bindtextureUnitLocationAndShaderUniformSamplerLocation:a];
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:GLKVertexAttribPosition  numberOfCoordinates:2 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:GLKVertexAttribTexCoord0 numberOfCoordinates:2 attribOffset:2*sizeof(GLfloat)];
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    static NSInteger count = 0;
    // 清除颜色缓冲区
    
    glClearColor(1,1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    count ++;
    if (count > 50 ) {
        count = 0;
        // 根据颜色索引值,设置颜色数据，就是刚才我们从着色器程序中获取的颜色索引值
    }
    // 使用着色器程序
    glUseProgram(self.shader.program);
    // 绘制
    [self.vertex drawVertexWithMode:GL_TRIANGLE_FAN startVertexIndex:0 numberOfVertices:VertexNum];
    
}




-(void)viewDidLoad{
    [super viewDidLoad];
    [self createEagContext];
    [self configure];
    [self createShader];
    [self loadVertex];
    
}



@end
