//
//  BabyBoy.m
//  BabyDrop
//
//  Created by Andrew Moran on 1/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "BabyBoy.h"

@implementation BabyBoy{

    CMMotionManager *motionManager;
    CMGyroData *myGyro;
    
}


-(id)init{
    
    if( (self = [super init])){
        motionManager = [[CMMotionManager alloc] init];
        motionManager.deviceMotionUpdateInterval = 1.0/60.0;
        if( motionManager.isDeviceMotionAvailable ){
            [motionManager startDeviceMotionUpdates];
        }
        _slowDown = NO;
        _isDeactive = NO;
        _deactiveX = NO;
        _deactiveX = NO;

    }
    return self;
}

// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    CCLOG( @"baby logged ");

    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    self.physicsBody.collisionType = @"baby";
    
    
}

-(void) update:(CCTime)delta
{
    //Baby Movement
    //CCLOG(@"Deactive is %hhd", _isDeactive );
    if ( _isDeactive == NO ){
    
        //CCLOG(@"SlowDown is %hhd", _slowDown );

    
        CMDeviceMotion *currentDeviceMotion = motionManager.deviceMotion;
        CMAttitude *currentAttitude = currentDeviceMotion.attitude;
    
        float roll = currentAttitude.roll;
        float pitch = currentAttitude.pitch;
        float yaw = currentAttitude.yaw;
    
        //CCLOG(@"Gyro at %0.02f %0.02f %0.02f", roll, pitch, yaw);
    
        CGPoint pos = self.position;
        
        if( _deactiveX == NO ){
            pos.x += roll/10.0;
        }
    
        if (_deactiveY == NO){
            if (_slowDown){
                pos.y += 0.004;
            }
            else{
                pos.y -= 0.002;
            }
        }
    
        if( pos.x <= 0){
            pos.x = 0;
        }
        else if( pos.x >= 1){
            pos.x = 1;
        }
    
        if( pos.y <= 0){
            pos.y = 0;
        }
        else if( pos.y >= 1){
            pos.y = 1;
        }
    
        //CCLOG(@"My position is %0.02f %0.02f", self.position.x, self.position.y );

    
        self.position = pos;
    }
    
}


@end
