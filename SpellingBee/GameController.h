//
//  GameController.h
//  SpellingBee
//
//  Created by Albert Pascual on 4/11/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SoundManager.h"
#import "PlayInternetSound.h"
#import "wordList.h"
#import "GADBannerView.h"


@interface GameController : UIViewController <UITextFieldDelegate> {
    
    UITextView *textBox;
    SoundManager *sound;
    PlayInternetSound *internetSound;
    wordList *words;
    NSString *randomWord;
    
    UIImageView *first;
    UIImageView *second;
    UIImageView *third;    
    UITextField *wordField;
    UIButton *nextButton;
    UIButton *helpButton;
    
    int iCountGoods;
    int iTries;
    
    UILabel *lettersLeft;
     GADBannerView *bannerView_;
    
}

@property (nonatomic,retain) IBOutlet UITextView *textBox;
@property (nonatomic,retain) SoundManager *sound;
@property (nonatomic,retain) PlayInternetSound *internetSound;
@property (nonatomic,retain) wordList *words;
@property (nonatomic,retain) NSString *randomWord;

@property (nonatomic,retain) IBOutlet UIImageView *first;
@property (nonatomic,retain) IBOutlet UIImageView *second;
@property (nonatomic,retain) IBOutlet UIImageView *third;    
@property (nonatomic,retain) IBOutlet UITextField *wordField;
@property (nonatomic,retain) IBOutlet UIButton *nextButton;
@property (nonatomic,retain) IBOutlet UIButton *helpButton;
@property (nonatomic,retain) IBOutlet UILabel *lettersLeft;

- (void)PlayRandomWord;
- (void)PlayWord:(NSString *)word;
- (IBAction)repeate;
- (IBAction) next;
- (void)good;
- (void)bad;

@end
