//
//  SpellingBeeAppDelegate.h
//  SpellingBee
//
//  Created by Al Pascual on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundManager.h"

@interface SpellingBeeAppDelegate : NSObject <UIApplicationDelegate> {

    SoundManager *sound;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) SoundManager *sound;

@end
