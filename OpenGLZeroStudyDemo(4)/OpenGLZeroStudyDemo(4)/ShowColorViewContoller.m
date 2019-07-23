//
//  ShowColorViewContoller.m
//  OpenGLZeroStudyDemo(4)
//
//  Created by glodon on 2019/7/18.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "ShowColorViewContoller.h"

#import "OpenGLUtilsHeader.h"
@interface ShowColorViewContoller ()
@property (nonatomic ,strong) UIViewController * tapVc;
@property (nonatomic ,strong) EAGLContext * eagcontext;
@property (nonatomic ,assign) GLuint  program;
@property (nonatomic ,strong) Shader * shader ;
@property (nonatomic ,strong) Vertex * vertex ;
@property (nonatomic ,strong) TextureUnit * textureUnit0 ;
@property (nonatomic ,strong) TextureUnit * textureUnit1 ;

@end

@implementation ShowColorViewContoller

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
        glBindAttribLocation(program, GLKVertexAttribPosition, "position");
        glBindAttribLocation(program, GLKVertexAttribTexCoord0, "texCoord0");
    }];
    glGetUniformLocation(self.shader.program, "sam2DR");
    
    
}


#define VertexNum 4
#define eachVertexNum 4

static GLfloat s_vertex[4*4] = {
    1,1, 0,1, //1
    -1,1,1,1,//0
    -1,-1,1,0, //2
    1,-1,0,0//3
};

-(void)loadVertex{
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
    float pixels[] = {
        0.0f, 0.0f, 0.0f,   1.0f, 1.0f, 1.0f,
        1.0f, 1.0f, 1.0f,   0.0f, 0.0f, 0.0f
    };
    [self.textureUnit0 setPixels:pixels pixelsWidth:2 pixelsHeight:2 IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:nil PixelFormat:GL_RGB];
    int a =  glGetUniformLocation(self.shader.program, "sam2DR");
    [self.textureUnit0 bindtextureUnitLocationAndShaderUniformSamplerLocation:a];
    
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:GLKVertexAttribPosition  numberOfCoordinates:2 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:GLKVertexAttribTexCoord0 numberOfCoordinates:2 attribOffset:2*sizeof(GLfloat)];
}
- (void*)getImageData:(UIImage*)image{
    CGImageRef imageRef = [image CGImage];
    size_t imageWidth = CGImageGetWidth(imageRef);
    size_t imageHeight = CGImageGetHeight(imageRef);
    GLubyte *imageData = (GLubyte *)malloc(imageWidth*imageHeight*4);
    memset(imageData, 0,imageWidth *imageHeight*4);
    CGContextRef imageContextRef = CGBitmapContextCreate(imageData, imageWidth, imageHeight, 8, imageWidth*4, CGImageGetColorSpace(imageRef), kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(imageContextRef, 0, imageHeight);
    CGContextScaleCTM(imageContextRef, 1.0, -1.0);
    CGContextDrawImage(imageContextRef, CGRectMake(0.0, 0.0, (CGFloat)imageWidth, (CGFloat)imageHeight), imageRef);
    CGContextRelease(imageContextRef);
    return  imageData;
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    static NSInteger count = 0;
    // 清除颜色缓冲区
    
    glClearColor(1,1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glEnable(GL_TEXTURE_2D);
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
