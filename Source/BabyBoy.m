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
    float staticRotation;
    
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
    
    staticRotation = self.rotation;
    
    
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
            pos.x += roll/50.0;
        }
    
        if (_deactiveY == NO){
            if (_slowDown){
                pos.y += 0.0035;
            }
            else{
                pos.y -= 0.00125;
            }
        }
    
        if( pos.x <= ((self.spriteFrame.rect.size.width/2.0)/320)){
            pos.x = ((self.spriteFrame.rect.size.width/2.0)/320);
        }
        else if( pos.x >= ((320 - (self.spriteFrame.rect.size.width/2.0))/320)){
            pos.x = ((320 - (self.spriteFrame.rect.size.width/2.0))/320);
        }
    
        if( pos.y <= .06){
            pos.y = .06;
        }
        else if( pos.y >= .65){
            pos.y = .65;
        }
        
        //CGPoint newPosMine = [self convertToWorldSpace:self.position];
        //CGPoint newPosTemp = [self convertToWorldSpace:pos];
        
        //CCLOG(@"My position is %0.02f %0.02f", pos.x, pos.y );
        //CCLOG(@"My position is %0.02f", self.spriteFrame.rect.size.width/(2*320) );

        //CCLOG(@"My Temp position is %0.02f %0.02f", newPosTemp.x, newPosTemp.y );


        //CCLOG(@"My position is %0.02f %0.02f", self.position.x, self.position.y );
        //CCLOG(@"My sprite Frame is %0.02f %0.02f", self.spriteFrame.rect.size.width, self.spriteFrame.rect.size.height );


    
        self.position = pos;
        self.rotation = staticRotation;
    }
    
}


@end
