//
//  MicrophoneReciever.m
//  SoundGame
//
//  Created by Shane McKee on 5/27/14.
//  Copyright (c) 2014 Shane McKee. All rights reserved.
//

#import "MicrophoneReciever.h"
#import <AEAudioController.h>

#define SENSITIVITY 700000  //The higher the number, the less sensitive it is
static int value = 250;

@implementation MicrophoneReciever
static void receiverCallback(id                        receiver,
                             AEAudioController        *audioController,
                             void                     *source,
                             const AudioTimeStamp     *time,
                             UInt32                    frames,
                             AudioBufferList          *audio) {
    
    

    for(int i = 0; i < audio->mNumberBuffers; i++){
        AudioBuffer buffer = audio->mBuffers[i];
        int *bufferData = buffer.mData;
        value = *bufferData/SENSITIVITY;
//        NSLog(@"%d",*bufferData/SENSITIVITY);
    }

}

+ (int) buffervalue { return value; }

-(AEAudioControllerAudioCallback)receiverCallback {
    return receiverCallback;
}

@end
