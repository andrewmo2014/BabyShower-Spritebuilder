//
//  AnimDelegate.m
//  BabyDrop
//
//  Created by Andrew Moran on 1/26/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "AnimDelegate.h"

@implementation AnimDelegate

BOOL _doneWithAnim;


-(id)init{
    
    if( (self = [super init])){
        _doneWithAnim = NO;
    }
    return self;
}


- (void) completedAnimationSequenceNamed:(NSString *)name{
    _doneWithAnim = YES;
    CCLOG(@"yes");
}

@end
