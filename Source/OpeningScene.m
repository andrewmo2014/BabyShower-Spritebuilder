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
}

-(id)init{
    if (self = [super init]){
    }
    return self;
}

-(void) onEnter{
    [super onEnter];
    _hud.changeCloudText = YES;
}


// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    CCLOG(@"opening read");
    _hud.myLabel = _title;
    
}

- (void) nextScene {
    CCLOG(@"next button pressed");
    
    CCBAnimationManager *animationManager = self.userObject;
    [animationManager runAnimationsForSequenceNamed:@"dropBabyAnim"];
    
    
    CCBAnimationManager *animationManager2 = _hud.userObject;
    [animationManager2 runAnimationsForSequenceNamed:@"topCloudMoveUp"];
    CCLOG(@"length %lu", (unsigned long)[[animationManager2 sequences] count]);
    
    [self performSelector:@selector(startTutorial) withObject:nil afterDelay:2.0f];
    
    
    
    
    //_animDel = (AnimDelegate*)animationManager2.delegate;
    //[_animDel completedAnimationSequenceNamed:@"dropBabyAnim"];
    
}

-(void) startTutorial{
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"DropScene"];
    [[CCDirector sharedDirector] replaceScene:gameLayerScene];

}

@end
