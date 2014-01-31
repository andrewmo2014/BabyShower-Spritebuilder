//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "HudDisplay.h"
#import "OALSimpleAudio.h"

@implementation MainScene{
    HudDisplay *_hud;
    CCLabelTTF *_title;
    CCButton *_playButton;
    CCBAnimationManager *animationManager;
}

@synthesize audioPlayer;


-(id)init{
    if (self = [super init]){
        NSString *mp3Path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"spring_fantasy.mp3"];
        NSURL *mp3Url = [NSURL fileURLWithPath:mp3Path];
        
        AVAudioPlayer *audPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3Url error:NULL];
        [self setAudioPlayer:audPlayer];
        audioPlayer.numberOfLoops = -1;
        audioPlayer.volume = 0.05;
        //[audioPlayer play];
    }
    return self;
}

- (void)didLoadFromCCB {
    //_playButton.visible = NO;
    animationManager = self.userObject;
    animationManager.delegate = self;
    _playButton.visible = YES;
    _playButton.enabled = NO;
    
    
    
}

-(void) onEnter{
    [super onEnter];
    [[CCDirector sharedDirector] resume];

    [_hud changeTextStrong:_title];
    [animationManager runAnimationsForSequenceNamed:@"TitleAnim"];

    
    
}

- (void) play {
    CCLOG(@"start button pressed");
    CCScene *gameLayerScene = [CCBReader loadAsScene:@"ModeSelector"];
    [[CCDirector sharedDirector] replaceScene:gameLayerScene];
}

-(void) completedAnimationSequenceNamed:(NSString *)name{
    if ([name isEqualToString:@"TitleAnim"]){
        _playButton.enabled = YES;
    }
}

@end
