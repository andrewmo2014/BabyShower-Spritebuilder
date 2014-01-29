//
//  ModeSelector.m
//  BabyDrop
//
//  Created by Andrew Moran on 1/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ModeSelector.h"

@implementation ModeSelector

- (void) storyMode {
    CCLOG(@"story button pressed");
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"OpeningScene"];
    [[CCDirector sharedDirector] replaceScene: gameLayerScene];
}


@end
