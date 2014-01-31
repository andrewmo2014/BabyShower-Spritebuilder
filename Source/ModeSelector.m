//
//  ModeSelector.m
//  BabyDrop
//
//  Created by Andrew Moran on 1/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ModeSelector.h"
#import "HudDisplay.h"
#import "DropScene.h"

@implementation ModeSelector {
    CCLabelTTF *_title;
    HudDisplay *_hud;
    
    CCButton *_creditsButton;
    CCButton *_tutorialButton;
    CCButton *_newGameButton;

    

}

-(void)didLoadCCB{
    
}

-(void) onEnter{
    [super onEnter];
    [[CCDirector sharedDirector] resume];
    [_hud changeTextStrong: _title];
    _newGameButton.enabled = NO;
    _tutorialButton.enabled = NO;
    _creditsButton.enabled = NO;

}

- (void) storyMode {
    CCLOG(@"story button pressed");
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"OpeningScene"];
    [[CCDirector sharedDirector] replaceScene: gameLayerScene];
}

- (void) levelMode {
    CCLOG(@"level button pressed");
    /*
    DropScene *gameLayerScene = (DropScene *)[CCBReader loadAsScene:@"DropScene"];
    [[CCDirector sharedDirector] replaceScene: gameLayerScene ];
    gameLayerScene.isTutorial = NO;
     */
    CCLOG(@"story button pressed");
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"OpeningScene"];
    [[CCDirector sharedDirector] replaceScene: gameLayerScene];

}

- (void) creditMode {
    CCLOG(@"credit button pressed");
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"Credits"];
    [[CCDirector sharedDirector] replaceScene: gameLayerScene];
}

-(void)update:(CCTime)delta{
    if([_hud doneDrop] == YES){
        CCLOG(@"checking drop");
        _newGameButton.enabled = YES;
        _tutorialButton.enabled = YES;
        _creditsButton.enabled = YES;

    }
}


@end
