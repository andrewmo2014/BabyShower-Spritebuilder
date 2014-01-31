//
//  ModeSelector.m
//  BabyDrop
//
//  Created by Andrew Moran on 1/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ModeSelector.h"
#import "HudDisplay.h"

@implementation ModeSelector{
    CCLabelTTF *_title;
    HudDisplay *_hud;
}

-(void)didLoadCCB{
    
}

-(void) onEnter{
    [super onEnter];
    [_hud changeTextStrong: _title];
    [_hud.userObject runAnimationsForSequenceNamed:@"resetClouds"];

}

- (void) storyMode {
    CCLOG(@"story button pressed");
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"OpeningScene"];
    [[CCDirector sharedDirector] replaceScene: gameLayerScene];
}

- (void) levelMode {
    CCLOG(@"level button pressed");
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"OpeningScene"];
    [[CCDirector sharedDirector] replaceScene: gameLayerScene];
}

- (void) creditMode {
    CCLOG(@"credit button pressed");
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"OpeningScene"];
    [[CCDirector sharedDirector] replaceScene: gameLayerScene];
}


@end
