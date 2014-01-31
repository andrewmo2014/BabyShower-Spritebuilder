//
//  Credits.m
//  BabyShower
//
//  Created by Andrew Moran on 1/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Credits.h"

@implementation Credits


-(void)back{
    [[CCDirector sharedDirector] resume];
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"ModeSelector"];
    [[CCDirector sharedDirector] replaceScene: gameLayerScene];
}

@end
