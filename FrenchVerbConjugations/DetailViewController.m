//
//  DetailViewController.m
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/03/14.
//  Copyright (c) 2013 Epinion. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize verbList;
@synthesize verbListKeys;
@synthesize currentIndex;


#pragma mark - Managing the detail item

- (void)setVerbList:(NSDictionary*)newVerbList {
    if (verbList != newVerbList) {
        verbList = newVerbList;
        verbListKeys = [self shuffle:[newVerbList allKeys]];
        currentIndex = 0;
    
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    NSLog(@"conf %i", currentIndex);
    // Update the user interface for the detail item.

    if (self.verbList) {
        NSString *key = [verbListKeys objectAtIndex:currentIndex];
        self.detailDescriptionLabel.text = key;
        self.title = key;
        NSArray *p = [[verbList objectForKey:key] componentsSeparatedByString:@"|"];
        
        self.labelTranslation.text = [[p objectAtIndex:0] stringByReplacingOccurrencesOfString:@"~" withString:@"\n"];
        self.labelConjugations.text = [[p objectAtIndex:1] stringByReplacingOccurrencesOfString:@"~" withString:@"\n"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeRight:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:swipeRight];
}

- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
    [self nextWord:nil];
}

- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    [self previousWord];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextWord:(id)sender {
    currentIndex++;
    if(currentIndex >= verbListKeys.count) {
        currentIndex = 0;
    }
    [self configureView];
}

- (void)previousWord {
    currentIndex--;
    if(currentIndex < 0) {
        currentIndex = verbListKeys.count-1;
    }
    [self configureView];
}

- (NSArray *)shuffle:(NSArray *)input
{
    NSMutableArray *keys = [[NSMutableArray alloc] initWithArray:input];
    
    for (int i=0; i<keys.count; i++) {
        int e = keys.count - i;
        int n = (random() % e) + i;
        
        [keys exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return keys;
}
@end
