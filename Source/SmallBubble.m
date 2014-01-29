//
//  SmallBubble.m
//  BabyShower
//
//  Created by Andrew Moran on 1/27/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SmallBubble.h"

@implementation SmallBubble

@synthesize speed;

-(id) init{
    if (self = [super init]){
        speed = 0.0f;
    }
    return self;
}

-(void)didLoadFromCCB {
    CCLOG( @"bubble logged ");
    self.physicsBody.collisionType = @"bubble";
}

-(void)update:(CCTime)delta{
    CGPoint pos = self.position;
    pos.y += speed;
    self.position = pos;
}


@end
