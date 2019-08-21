//
//  GLBaseViewController.h
//  OpenGLZeroStudyDemo(5)-图形变换
//
//  Created by glodon on 2019/7/24.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "OpenGLUtilsHeader.h"
#import "GLBaseBindObject.h"


NS_ASSUME_NONNULL_BEGIN



@interface GLBaseViewController : GLKViewController
@property (nonatomic ,strong) EAGLContext * eagcontext;
@property (nonatomic ,assign) GLuint  program;
@property (nonatomic ,strong) Shader * shader ;
@property (nonatomic ,strong) GLBaseBindObject * bindObject ;

///眼的位置在 0,0,1 看向 原点 ,眼的正方向是y轴,   看的区域是0.1 到20   角度是85
-(GLKMatrix4 )mvp;

-(void)loadVertex;
-(void)initSubObject;
-(void)createTextureUnit;
@end

NS_ASSUME_NONNULL_END
