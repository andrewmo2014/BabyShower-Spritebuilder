//
//  HUD.h
//  BabyDrop
//
//  Created by Andrew Moran on 1/26/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface HudDisplay : CCNode <CCBAnimationManagerDelegate>

@property NSString* mynewCloudText;
//@property BOOL changeCloudText;
//@property CCLabelTTF* myLabel;

@property float happyMeterLength;
@property BOOL happyMeterResizing;
@property BOOL doneDrop;

-(void)changeTextWeak: (NSString *)string;
-(void)changeTextStrong: (CCLabelTTF *)label;
-(void)setHappyMeter: (bool) val;
-(void)setCloudIm: (NSString*)string2: (BOOL)val;
-(float)getHappyScore;

@end
