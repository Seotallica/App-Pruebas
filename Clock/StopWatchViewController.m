//
//  SSSecondViewController.m
//  Clock
//
//  Created by Scott on 28/09/2013.
//  Copyright (c) 2013 ScottSherwood. All rights reserved.
//

#import "StopWatchViewController.h"
#import "GAIDictionaryBuilder.h"
#import "Flurry.h"
#import "Amplitude.h"

@interface StopWatchViewController ()

@property IBOutlet UILabel *label;
@property IBOutlet UIButton *toggle;

@property NSTimer *timer;
@property NSDateFormatter *dateFormatter;
@property int ticks;

@end

@implementation StopWatchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    if(self.dateFormatter==nil){
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    }
}

-(IBAction)startToggle:(id)sender{
    [self logButtonPress:(UIButton *)sender];
    if(self.timer){
        [self stop:sender];
        [self.toggle setTitle:@"Start" forState:UIControlStateNormal];
    }
    else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
        [self.toggle setTitle:@"Stop" forState:UIControlStateNormal];
    }
}

-(IBAction)reset:(id)sender{
    [self logButtonPress:(UIButton *)sender];
    [self stop:sender];
    [self.toggle setTitle:@"Start" forState:UIControlStateNormal];
    
    self.ticks = 0;
    self.label.text = [NSString stringWithFormat:@"%02d:%02d:%02d",0,0,0];
}



-(void)stop:(id)sender{
    [self.timer invalidate];
    self.timer = nil;
}



-(void)tick:(NSTimer *)t{
    self.ticks++;
    
    int lt = self.ticks % 100;
    int sec = floor((self.ticks / 100)%60);
    int min = floor((self.ticks / 100)/60);
    
    self.label.text = [NSString stringWithFormat:@"%02d:%02d:%02d",min,sec,lt];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Stopwatch"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    [Flurry logEvent:@"Stopwatch"];
    [Amplitude logEvent:@"Stopwatch"];
}

-(void)logButtonPress:(UIButton *)button{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"Stopwatch"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:[button.titleLabel text]
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
}

@end
