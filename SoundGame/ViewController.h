//
//  ViewController.h
//  SoundGame
//

//  Copyright (c) 2014 Shane McKee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <AEAudioController+Audiobus.h>

@interface ViewController : UIViewController
    @property (nonatomic, strong) AEAudioController *audioController;
@end
