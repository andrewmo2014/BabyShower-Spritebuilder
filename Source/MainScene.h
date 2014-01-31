//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCNode.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface MainScene : CCNode <CCBAnimationManagerDelegate>{
        AVAudioPlayer *audioPlayer;
}

@property(nonatomic, retain) AVAudioPlayer *audioPlayer;


@end
