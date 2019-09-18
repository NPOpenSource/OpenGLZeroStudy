//
//  PhongLightingViewController.m
//  OpenGLZeroStudyDemo(17)-高级光照之高级光照
//
//  Created by glodon on 2019/9/18.
//  Copyright © 2019 persion. All rights reserved.
//

#import "PhongLightingViewController.h"
#import "PhoneLightingBindObject.h"

static float PL_planeVertices[] = {
    // positions            // normals         // texcoords
    10.0f, -0.5f,  10.0f,  0.0f, 1.0f, 0.0f,  10.0f,  0.0f,
    -10.0f, -0.5f,  10.0f,  0.0f, 1.0f, 0.0f,   0.0f,  0.0f,
    -10.0f, -0.5f, -10.0f,  0.0f, 1.0f, 0.0f,   0.0f, 10.0f,
    
    10.0f, -0.5f,  10.0f,  0.0f, 1.0f, 0.0f,  10.0f,  0.0f,
    -10.0f, -0.5f, -10.0f,  0.0f, 1.0f, 0.0f,   0.0f, 10.0f,
    10.0f, -0.5f, -10.0f,  0.0f, 1.0f, 0.0f,  10.0f, 10.0f
};

@interface PhongLightingViewController ()
@property (nonatomic ,strong) Vertex * vertex ;
@property (nonatomic ,strong) TextureUnit * planeUnit ;
@end

@implementation PhongLightingViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(hit) forControlEvents:UIControlEventTouchDown];
}
static bool PL_bline=NO;
-(void)hit{
    if (PL_bline) {
        PL_bline=NO;
    }else{
        PL_bline=YES;
    }
}

-(void)initSubObject{
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    self.bindObject = [PhoneLightingBindObject new];
}

-(void)loadVertex{
    self.vertex= [Vertex new];
    int vertexNum =6;
    int vertexWidth = 8;
    [self.vertex allocVertexNum:vertexNum andEachVertexNum:vertexWidth];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[vertexWidth];
        for (int j=0; j<vertexWidth; j++) {
            onevertex[j]=PL_planeVertices[i*vertexWidth+j];
        }
        [self.vertex setVertex:onevertex index:i];
    }
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:PL_aPos numberOfCoordinates:3 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:PL_aNormal numberOfCoordinates:3 attribOffset:sizeof(float)*3];
    [self.vertex enableVertexInVertexAttrib:PL_aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*6];
}

- (void)createTextureUnit{
    self.planeUnit = [TextureUnit new];
    [self.planeUnit setImage:[UIImage imageNamed:@"wood.png"] IntoTextureUnit:GL_TEXTURE0 andConfigTextureUnit:^{
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    }];
}


-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glClearColor(1, 1, 1, 1);
    
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(GLKMathDegreesToRadians(35),
                              aspectRatio,
                              0.1f,
                              100.0f);
    glUniformMatrix4fv(self.bindObject->uniforms[PL_uniform_projection], 1, 0,projectionMatrix.m);
    
    GLKMatrix4 viewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 3.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    glUniformMatrix4fv(self.bindObject->uniforms[PL_uniform_view], 1, 0,viewMatrix.m);
       
    GLKVector3 viewPos = GLKVector3Make(0, 0.0, 3.0);
    glUniform3fv(self.bindObject->uniforms[PL_uniform_viewPos], 1, viewPos.v);

    GLKVector3 lightPos = GLKVector3Make(0, 0, 0);
    glUniform3fv(self.bindObject->uniforms[PL_uniform_lightPos], 1, lightPos.v);

    glUniform1i(self.bindObject->uniforms[PL_uniform_blinn], PL_bline);
    
    [self.planeUnit bindtextureUnitLocationAndShaderUniformSamplerLocation:self.bindObject->uniforms[PL_uniform_floorTexture]];
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:6];
}


@end
