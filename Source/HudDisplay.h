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

-(void)changeTextWeak: (NSString *)string;
-(void)changeTextStrong: (CCLabelTTF *)label;

@end
