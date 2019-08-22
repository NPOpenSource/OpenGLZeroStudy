//
//  Shader.h
//  Pods-OpenGLZeroStudyDemo(1)
//
//  Created by glodon on 2019/7/9.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
NS_ASSUME_NONNULL_BEGIN



@interface Shader : NSObject
@property (nonatomic ,readonly ) GLuint program;
-(void)use;
-(BOOL)compileLinkSuccessShaderName:(NSString *)shader completeBlock:(void(^)(GLuint program))completeBlock;

@end

NS_ASSUME_NONNULL_END
