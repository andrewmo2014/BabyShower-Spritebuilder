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
    CCNode *_tiltLeft;
    CCNode *_tiltRight;
    CCNode *_pressDown;
    CCNode *_pressUp;
    CCBAnimationManager *animationManager;
    
}

@synthesize happyMeterLength;
@synthesize happyMeterResizing;

-(id)init{
    if(self=[super init]){
        
    }
    return self;
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
    
    _tiltLeft.visible = NO;
    _tiltRight.visible = NO;
    _pressDown.visible = NO;
    _pressUp.visible = NO;
    

}

-(void)setCloudIm: (NSString*)string2: (BOOL)val{
    CCLOG( @"setting cloud pic");
    if( [string2 isEqualToString:@"TiltLeft"]){
        _tiltLeft.visible = val;
    }
    if( [string2 isEqualToString:@"TiltRight"]){
        _tiltRight.visible = val;
    }
    if( [string2 isEqualToString:@"PressDown"]){
        _pressDown.visible = val;
    }
    if( [string2 isEqualToString:@"PressUp"]){
        _pressUp.visible = val;
    }

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

-(float) getHappyScore{
    return _happyMeter.contentSize.width;
}

-(void)update:(CCTime)delta{

    if( happyMeterResizing == YES){
        happyMeterLength = clampf(happyMeterLength-.0008, 0.0f, 1.0f);

        [_happyMeter setContentSize: CGSizeMake(200 * happyMeterLength,
                                                _happyMeter.contentSize.height)];
    }
    
}








@end
