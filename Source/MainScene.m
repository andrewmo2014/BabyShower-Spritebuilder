//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "HudDisplay.h"

@implementation MainScene{
    HudDisplay *_hud;
    CCLabelTTF *_title;
    CCButton *_playButton;
}

-(id)init{
    if (self = [super init]){
    }
    return self;
}

- (void)didLoadFromCCB {
    _hud.myLabel = _title;
    _playButton.visible = NO;
}

-(void) onEnter{
    [super onEnter];
   _hud.changeCloudText = YES;
    [self schedule:@selector(activatePlayButton) interval:2.0f repeat:0 delay:2.0f];
}

-(void)activatePlayButton{
    _playButton.visible = YES;
}

- (void) play {
    CCLOG(@"start button pressed");
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"ModeSelector"];
    [[CCDirector sharedDirector] replaceScene:gameLayerScene];
}

@end
