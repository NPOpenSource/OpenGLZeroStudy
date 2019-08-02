//
//  CubeManager.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 201.09/8/2.
//  Copyright © 201.09 glodon. All rights reserved.
//

#import "CubeManager.h"

unsigned int cubeNumVerts = 8;
float cubeVerts[]={
    0.5, 0.5, 0.5,
    -0.5, 0.5, 0.5,
    -0.5,-0.5, 0.5,
    0.5,-0.5, 0.5,
    
    0.5, 0.5, -0.5,
    -0.5, 0.5, -0.5,
    -0.5,-0.5,-0.5,
    0.5,-0.5,-0.5,
};
float cubeNormals[]={
    0.5, 0.5, 0.5,
    -0.5, 0.5, 0.5,
    -0.5,-0.5, 0.5,
    0.5,-0.5, 0.5,
    
    0.5, 0.5, -0.5,
    -0.5, 0.5, -0.5,
    -0.5,-0.5,-0.5,
    0.5,-0.5,-0.5,
};
float cubeColors[]={
    1.0,0.0,0.0,
    1.0,0.0,0.0,
    1.0,0.0,0.0,
    1.0,0.0,0.0,
    1.0,0.0,0.0,
    1.0,0.0,0.0,
    1.0,0.0,0.0,
    1.0,0.0,0.0,
};

GLuint tfan1[12 * 3] =
{
    0,2,1,
    0,2,3,
    0,7,4,
    0,7,3,
    0,5,4,
    0,5,1,
    
    6,1,5,
    6,1,2,
    6,3,2,
    6,3,7,
    6,4,5,
    6,4,7
};


unsigned int cubeNormalNumVerts = 36;
float cubeNormalVertices[]={
    -0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,1.0f,  0.0f, 0.0f,
    0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,1.0f,  0.0f, 0.0f,
    0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,1.0f,  0.0f, 0.0f,
    0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,1.0f,  0.0f, 0.0f,
    -0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,1.0f,  0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,1.0f,  0.0f, 0.0f,

    -0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,1.0f,  0.0f, 0.0f,
    0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,1.0f,  0.0f, 0.0f,
    0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,1.0f,  0.0f, 0.0f,
    0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,1.0f,  0.0f, 0.0f,
    -0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,1.0f,  0.0f, 0.0f,
    -0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,1.0f,  0.0f, 0.0f,

    -0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,
    -0.5f,  0.5f, -0.5f, -1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,
    -0.5f, -0.5f,  0.5f, -1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,
    -0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,

    0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,
    0.5f,  0.5f, -0.5f,  1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,
    0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,
    0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,
    0.5f, -0.5f,  0.5f,  1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,
    0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,1.0f,  0.0f, 0.0f,

    -0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,1.0f,  0.0f, 0.0f,
    0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,1.0f,  0.0f, 0.0f,
    0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,1.0f,  0.0f, 0.0f,
    0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,1.0f,  0.0f, 0.0f,
    -0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,1.0f,  0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,1.0f,  0.0f, 0.0f,

    -0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,1.0f,  0.0f, 0.0f,
    0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,1.0f,  0.0f, 0.0f,
    0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,1.0f,  0.0f, 0.0f,
    0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,1.0f,  0.0f, 0.0f,
    -0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,1.0f,  0.0f, 0.0f,
    -0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,1.0f,  0.0f, 0.0f
};



@implementation CubeManager
+(unsigned int)getNormalVertexNum{
    return cubeNormalNumVerts;
}
+(float *)getNormalVertexs{
    return cubeNormalVertices;
}

#pragma mark  - vertex
+(unsigned int)getVertexNum{
    return cubeNumVerts;
}

+(float *)getCubeVerts{
    return cubeVerts;
}

+(float *)getCubeNormals{
    return cubeNormals;
}

+(float *)cubeColors{
    return cubeColors;
}

+(GLuint *)getVertexElements{
    return tfan1;
}

+(unsigned int)getVertexElementsNum{
    return 36;
}



@end
