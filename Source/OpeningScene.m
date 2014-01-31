//
//  Opening.m
//  BabyDrop
//
//  Created by Andrew Moran on 1/26/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "OpeningScene.h"
#import "AnimDelegate.h"
#import "HudDisplay.h"
#import "Banner.h"

@implementation OpeningScene{
    AnimDelegate *_animDel;
    Banner *_banner;
    HudDisplay *_hud;
    CCLabelTTF *_title;
    CCButton *_nextButton;
    CCBAnimationManager *animationManager;
}

-(id)init{
    if (self = [super init]){
    }
    return self;
}

-(void) onEnter{
    [super onEnter];
    [[CCDirector sharedDirector] resume];
    [_hud changeTextStrong:_title];
    [animationManager runAnimationsForSequenceNamed:@"introductionAnim"];

    
}


// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    CCLOG(@"opening read");
    //_hud.myLabel = _title;
    animationManager = self.userObject;
    animationManager.delegate = self;
    _nextButton.visible = NO;
}


- (void) nextScene {
    CCLOG(@"next button pressed");
    
    _nextButton.visible = NO;
    
    //CCBAnimationManager *animationManager = self.userObject;
    
    [animationManager runAnimationsForSequenceNamed:@"dropBabyAnim"];
    [_hud.userObject runAnimationsForSequenceNamed:@"topCloudMoveUp"];
    
    //[self completedAnimationSequenceNamed:@"dropBabyAnim"];


    
    //CCBAnimationManager *animationManager2 = _hud.userObject;
    //CCLOG(@"length %lu", (unsigned long)[[animationManager2 sequences] count]);
    
    //[self performSelector:@selector(startTutorial) withObject:nil afterDelay:2.0f];
    
    
    
    //_animDel = (AnimDelegate*)animationManager2.delegate;
    //[_animDel completedAnimationSequenceNamed:@"dropBabyAnim"];
    
}

//-(void) startTutorial{
//    CCScene *gameLayerScene = [CCBReader loadAsScene:@"DropScene"];
//    [[CCDirector sharedDirector] replaceScene:gameLayerScene];
//
//}

-(void) completedAnimationSequenceNamed:(NSString *)name{
    
    if ([name isEqualToString: @"introductionAnim"]){
        CCLOG(@"yes");
        _nextButton.visible = YES;
    }
    
    if ([name isEqualToString: @"dropBabyAnim"]){
        CCLOG(@"no");
        CCScene *gameLayerScene = [CCBReader loadAsScene:@"DropScene"];
        [[CCDirector sharedDirector] replaceScene:gameLayerScene];
    }
    //if ([name isEqualToString: @"topCloudMoveUp"]){
    //    CCScene *gameLayerScene = [CCBReader loadAsScene:@"DropScene"];
    //    [[CCDirector sharedDirector] replaceScene:gameLayerScene];
    //}
}

@end
