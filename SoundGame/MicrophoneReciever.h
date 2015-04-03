//
//  MicrophoneReciever.h
//  SoundGame
//
//  Created by Shane McKee on 5/27/14.
//  Copyright (c) 2014 Shane McKee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AEAudioController.h>

@interface MicrophoneReciever : NSObject <AEAudioReceiver>
    + (int) buffervalue;
@end
