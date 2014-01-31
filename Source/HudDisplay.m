//
//  HUD.m
//  BabyDrop
//
//  Created by Andrew Moran on 1/26/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "HudDisplay.h"

float happyMeterMaxWidth;


@implementation HudDisplay{
    CCNode *_topCloud;
    CCNode *_topCloudPic;
    CCLabelTTF *_topCloudText;
    CCNode *_bottomCloud;
    CCNode *_happyMeter;
    CCNode *_pauseButton;
    CCBAnimationManager *animationManager;
    
}

@synthesize happyMeterLength;
@synthesize happyMeterResizing;

-(id)init{
    if(self=[super init]){
        
    }
    return self;
}

-(void) setPauseButtonVisible{
    _pauseButton.visible = YES;
}

-(void) setHappyMeter:(bool)val{
    _happyMeter.visible = YES;
    happyMeterResizing = YES;
}

- (void)didLoadFromCCB {
    // tell this scene to accept touches
    CCLOG(@"hud read");
    //_myLabel = _topCloudText;
    animationManager = self.userObject;
    animationManager.delegate = self;
    //[animationManager runAnimationsForSequenceNamed:@"topCloudMoveDown"];
    
    happyMeterMaxWidth = _happyMeter.contentSize.width;
    happyMeterResizing = NO;
    happyMeterLength = 1;
    

}

-(void)changeTextWeak: (NSString *)string{
    [_topCloudText setString: string];
}
-(void)changeTextStrong: (CCLabelTTF *)myLabel{
    [_topCloudText setString: myLabel.string];
    [_topCloudText setFontColor: myLabel.fontColor];
    [_topCloudText setFontName: myLabel.fontName];
    [_topCloudText setFontSize: myLabel.fontSize];
    [_topCloudText setHorizontalAlignment: myLabel.horizontalAlignment];
    [_topCloudText setOutlineColor: myLabel.outlineColor];
    [_topCloudText setColor: myLabel.color];
}

-(void) completedAnimationSequenceNamed:(NSString *)name{
    if ([name isEqualToString:@"topCloudMoveDown"]){
        CCLOG(@"initial drop is over");
    }
}

-(void)update:(CCTime)delta{

    if( happyMeterResizing == YES){
        happyMeterLength = clampf(happyMeterLength-.0008, 0.0f, 1.0f);

        [_happyMeter setContentSize: CGSizeMake(200 * happyMeterLength,
                                                _happyMeter.contentSize.height)];
    }
    
}








@end
