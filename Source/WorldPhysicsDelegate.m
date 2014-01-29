//
//  WorldPhysicsDelegate.m
//  BabyShower
//
//  Created by Andrew Moran on 1/27/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "WorldPhysicsDelegate.h"


@implementation WorldPhysicsDelegate


-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair baby:(CCPhysicsBody *)babyBody bubble:(CCPhysicsBody *)bubbleBody
{
    CCLOG( @"collision occurred");
    //[babyBody.node removeFromParent];
    
    return YES;
}

@end
