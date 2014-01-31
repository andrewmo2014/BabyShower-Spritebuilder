//
//  DropScene.h
//  BabyDrop
//
//  Created by Andrew Moran on 1/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCScene.h"
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface DropScene : CCScene <CCPhysicsCollisionDelegate, CCBAnimationManagerDelegate>{
    NSMutableArray *bubbles;
    NSMutableArray *levelContainer;

    BOOL nextLevel;
    //AVAudioPlayer *audioPlayer;

}

//@property(nonatomic, retain) AVAudioPlayer *audioPlayer;


@end
