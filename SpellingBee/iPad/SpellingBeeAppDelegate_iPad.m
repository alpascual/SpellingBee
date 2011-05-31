//
//  SpellingBeeAppDelegate_iPad.m
//  SpellingBee
//
//  Created by Al Pascual on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpellingBeeAppDelegate_iPad.h"

@implementation SpellingBeeAppDelegate_iPad

- (void)dealloc
{
	[super dealloc];
}

-(IBAction) startPressed
{
    GameController *game = [[GameController alloc] initWithNibName:@"iPadGameController" bundle:nil];
    
    game.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self.window addSubview: game.view];
    [self.window makeKeyAndVisible];
    
}

@end
