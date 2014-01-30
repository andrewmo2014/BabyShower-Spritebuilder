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
    CCBAnimationManager *animationManager;
}

-(id)init{
    if (self = [super init]){
    }
    return self;
}

- (void)didLoadFromCCB {
    _playButton.visible = NO;
    animationManager = self.userObject;
    animationManager.delegate = self;
}

-(void) onEnter{
    [super onEnter];
    [_hud changeTextStrong:_title];
    
}

- (void) play {
    CCLOG(@"start button pressed");
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"ModeSelector"];
    [[CCDirector sharedDirector] replaceScene:gameLayerScene];
}

-(void) completedAnimationSequenceNamed:(NSString *)name{
    if ([name isEqualToString:@"TitleAnim"]){
        _playButton.visible = YES;
    }
}

@end
