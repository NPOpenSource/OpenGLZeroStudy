//
//  VertexElement.h
//  OpenGLUtils
//
//  Created by glodon on 2019/7/12.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface VertexElement : NSObject
-(void)allocWithIndexNum:(GLsizei)count  indexArr:(GLuint*)indexArr;
-(void)releaseIndexs;
-(void)drawElementIndexWithMode:(GLenum)mode;

+ (void)drawElementIndexWithMode:(GLenum)mode indexNum:(GLsizei)count  indexArr:(GLuint*)indexArr;
@end

NS_ASSUME_NONNULL_END
