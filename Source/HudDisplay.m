//
//  HUD.m
//  BabyDrop
//
//  Created by Andrew Moran on 1/26/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "HudDisplay.h"


@implementation HudDisplay{
    CCNode *_topCloud;
    CCNode *_topCloudPic;
    CCLabelTTF *_topCloudText;
    CCNode *_bottomCloud;
    CCNode *_happyMeter;
    CCNode *_pauseButton;
    
}

-(id)init{
    if(self=[super init]){
        _changeCloudText = NO;
    }
    return self;
}

- (void)didLoadFromCCB {
    // tell this scene to accept touches
    CCLOG(@"hud read");
    //_myLabel = _topCloudText;

}

-(void)update:(CCTime)delta{
    if ( _changeCloudText == YES ){
        [_topCloudText setString: _myLabel.string];
        [_topCloudText setFontColor: _myLabel.fontColor];
        [_topCloudText setFontName: _myLabel.fontName];
        [_topCloudText setFontSize: _myLabel.fontSize];
        [_topCloudText setHorizontalAlignment: _myLabel.horizontalAlignment];
        [_topCloudText setOutlineColor: _myLabel.outlineColor];
        [_topCloudText setColor: _myLabel.color];
        _changeCloudText = NO;
    }
}








@end
