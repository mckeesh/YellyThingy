//
//  MyScene.h
//  SoundGame
//

//  Copyright (c) 2014 Shane McKee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MicrophoneReciever.h"

@interface MyScene : SKScene
    @property (nonatomic, strong) MicrophoneReciever* microphone;
@end
