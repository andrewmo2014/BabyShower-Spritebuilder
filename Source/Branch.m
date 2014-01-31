//
//  Branch.m
//  BabyShower
//
//  Created by Andrew Moran on 1/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Branch.h"

@implementation Branch

@synthesize speed;


-(id) init{
    if (self = [super init]){
        speed = 0.0f;
    }
    return self;
}

-(void)didLoadFromCCB {
    CCLOG( @"branch logged");
    self.physicsBody.collisionType = @"branch";
}

-(void)update:(CCTime)delta{
    CGPoint pos = self.position;
    pos.y += speed;
    self.position  = pos;
}


@end
