//
//  GameController.m
//  SpellingBee
//
//  Created by Albert Pascual on 4/11/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "GameController.h"


@implementation GameController

@synthesize textBox, sound, internetSound, words, randomWord;
@synthesize first, second, third, wordField, nextButton, helpButton;
@synthesize lettersLeft;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    
    [self.internetSound release];
    [self.words release];
    [self.randomWord release];
    [self.sound release];
    [bannerView_ release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Create a view of the standard size at the bottom of the screen.
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            self.view.frame.size.height -
                                            GAD_SIZE_320x50.height,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    bannerView_.adUnitID = @"a14e228f71466ef";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:[GADRequest request]];
    
   // Create an array with lots of words 
    
    self.internetSound = [[PlayInternetSound alloc] init];
    self.words = [[wordList alloc] init];
    self.sound = [[SoundManager alloc] init];
    
    //Start the game and show the screen
    self.wordField.delegate = self;
    [self PlayRandomWord];
    
    [self.wordField becomeFirstResponder];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)PlayRandomWord
{
    self.nextButton.hidden = YES;
    self.first.hidden = YES;
    self.second.hidden = YES;
    self.third.hidden = YES;
    iCountGoods = 0;
    iTries = 0;
    
    //http://translate.google.com/translate_tts?q=potato
    
    self.randomWord = [self.words GetRandomWord];
    
    self.lettersLeft.text = [[[NSString alloc] initWithFormat:@"%d", [self.randomWord length]] autorelease];
    
    [self PlayWord:self.randomWord];
}

- (void)PlayWord:(NSString *)word
{
    NSString *wordToPlay = [[NSString alloc] initWithFormat:@"http://translate.google.com/translate_tts?q=%@", word];
    
    [self.internetSound playOneSound:wordToPlay]; 
    
    [wordToPlay release];
}
- (IBAction)repeate
{
    [self PlayWord:self.randomWord];
}

- (IBAction) next
{ 
    self.wordField.text = @"";
    
    self.nextButton.hidden = YES;
    
    [self PlayRandomWord];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"Random %@ with textbox %@ and self %@", self.randomWord, textField.text, self.wordField.text);
    
    NSString *fullString = [[NSString alloc] initWithFormat:@"%@%@", textField.text, string];
    
    NSLog(@"all together %@", fullString);
    
    iTries++;
    if ( iTries > 8 )
        self.nextButton.hidden = NO;
    
    if ( [self.randomWord isEqualToString:fullString] )
    {
        // Finish and good, Congratulations and start witj 
        [self.sound addSoundToQueue:@"congratulations"];
        
        self.nextButton.hidden = NO;
        self.lettersLeft.text = @"0";
        
        return YES;
    }
    
    range.length = 1;
    
    // making sure they don't add lots of letters and crush the app
    if ( range.location >= [self.randomWord length])
        return YES;
        
    NSString *theSub = [self.randomWord substringWithRange:range];
    NSLog(@"The substring is %@", theSub);
    
    if ( [theSub isEqualToString:string] )
    {
        //GOOD
        [self good];
        [self.sound addSoundToQueue:@"yes"];
        [self.sound playQueue];
    }
    else
    {
        //Bad
        [self bad];
        [self.sound addSoundToQueue:@"no"];
        [self.sound playQueue];
    }
    
    NSLog(@"The length of textField is %d and the word length %d", [textField.text length]+1, [self.randomWord length]);
    int cal = [self.randomWord length] - ([textField.text length] + 1);
    NSLog(@"The length cal is %d", cal);
    
    self.lettersLeft.text = [[[NSString alloc] initWithFormat:@"%d", cal]  autorelease];
   
    
    return YES;
}

- (void)good
{
    iCountGoods++;
    if ( iCountGoods > 3 )
        iCountGoods = 3;
    
    switch (iCountGoods) {
        case 1:
            self.first.hidden = NO;
            break;
            
        case 2:
            self.second.hidden = NO;
            break;
            
        case 3:
            self.third.hidden = NO;
            break;
            
        default:
            break;
    }
    
}
- (void)bad
{
    
    iCountGoods--;
    if ( iCountGoods < 0 )
        iCountGoods = 0;
    
    switch (iCountGoods) {
        case 0:
            self.first.hidden = YES;
            break;
            
        case 1:
            self.second.hidden = YES;
            break;
            
        case 2:
            self.third.hidden = YES;
            break;
            
        default:
            break;
    }

}

@end
