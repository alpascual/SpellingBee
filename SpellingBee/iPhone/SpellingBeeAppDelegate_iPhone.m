//
//  SpellingBeeAppDelegate_iPhone.m
//  SpellingBee
//
//  Created by Al Pascual on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpellingBeeAppDelegate_iPhone.h"

@implementation SpellingBeeAppDelegate_iPhone

- (void)dealloc
{
	[super dealloc];
}



-(IBAction) startPressed
{
    GameController *game = [[GameController alloc] initWithNibName:@"GameController" bundle:nil];
    
    game.modalPresentationStyle = UIModalPresentationFullScreen;

    [self.window addSubview: game.view];
    [self.window makeKeyAndVisible];
    
}

@end
