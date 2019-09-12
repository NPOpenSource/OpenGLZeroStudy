//
//  SphereManager.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "SphereManager.h"
#import "sphere.h"

@implementation SphereManager
+(unsigned int)getVertexNum{
    return sphereNumVerts;
}

+(float *)getSphereVerts{
    return sphereVerts;
}

+(float *)getSphereNormals{
    return sphereNormals;
}

+(float *)getSphereTexCoords{
    return sphereTexCoords;
}

@end
