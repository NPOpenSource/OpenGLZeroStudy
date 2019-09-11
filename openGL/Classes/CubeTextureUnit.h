//
//  CubeTextureUnit.h
//  OpenGLBase
//
//  Created by glodon on 2019/8/30.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CubeTextureUnit : NSObject
@property (nonatomic ,assign) GLuint textureID ;
-(void)bindCubeTexture;
-(void)bindCubeTextureInImageArray:(NSArray *)imageArr;
@end

NS_ASSUME_NONNULL_END
