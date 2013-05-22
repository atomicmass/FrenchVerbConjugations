//
//  WordCell.m
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/04/09.
//  Copyright (c) 2013 Blacklemon. All rights reserved.
//

#import "WordCell.h"

@implementation WordCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.labelWord = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, 53)];
        self.labelWord.textColor = [UIColor blackColor];
        self.labelWord.backgroundColor = [UIColor clearColor];
        self.labelWord.textAlignment = NSTextAlignmentCenter;
        self.labelWord.font = [UIFont boldSystemFontOfSize:30];
//        self.labelWord.backgroundColor = [UIColor greenColor];
        self.labelTranslation.numberOfLines = 0;
        [self addSubview:self.labelWord];
        
        self.labelTranslation = [[UILabel alloc]initWithFrame:CGRectMake(20, 52, 280, 96)];
        self.labelTranslation.textColor = [UIColor blueColor];
        self.labelTranslation.backgroundColor = [UIColor clearColor];
        self.labelTranslation.textAlignment = NSTextAlignmentCenter;
        self.labelTranslation.font = [UIFont italicSystemFontOfSize:15];
        self.labelTranslation.numberOfLines = 0;
//        self.labelTranslation.backgroundColor = [UIColor redColor];
        [self addSubview:self.labelTranslation];
        
        self.labelDetails = [[UILabel alloc]initWithFrame:CGRectMake(20, 130, 280, 250)];
        self.labelDetails.textColor = [UIColor blackColor];
        self.labelDetails.backgroundColor = [UIColor clearColor];
        self.labelDetails.textAlignment = NSTextAlignmentCenter;
        self.labelDetails.numberOfLines = 0;
//        self.labelDetails.backgroundColor = [UIColor purpleColor];
        [self addSubview:self.labelDetails];
        
        self.labelDetailTranslation = [[UILabel alloc]initWithFrame:CGRectMake(20, 250, 280, 96)];
        self.labelDetailTranslation.textColor = [UIColor blueColor];
        self.labelDetailTranslation.backgroundColor = [UIColor clearColor];
        self.labelDetailTranslation.textAlignment = NSTextAlignmentCenter;
        self.labelDetailTranslation.font = [UIFont italicSystemFontOfSize:15];
        self.labelDetailTranslation.numberOfLines = 0;
        //        self.labelDetailTranslation.backgroundColor = [UIColor redColor];
        [self addSubview:self.labelDetailTranslation];
    }
    return self;
}

@end
