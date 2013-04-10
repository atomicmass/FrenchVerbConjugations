//
//  WordCell.m
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/04/09.
//  Copyright (c) 2013 Epinion. All rights reserved.
//

#import "WordCell.h"

@implementation WordCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.labelWord = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, 53)];
        self.labelWord.textColor = [UIColor blackColor];
        self.labelWord.backgroundColor = [UIColor clearColor];
        self.labelWord.textAlignment = NSTextAlignmentCenter;
        self.labelWord.font = [UIFont boldSystemFontOfSize:30];
        [self addSubview:self.labelWord];
        
        self.labelTranslation = [[UILabel alloc]initWithFrame:CGRectMake(20, 52, 280, 48)];
        self.labelTranslation.textColor = [UIColor blueColor];
        self.labelTranslation.backgroundColor = [UIColor clearColor];
        self.labelTranslation.textAlignment = NSTextAlignmentCenter;
        self.labelTranslation.font = [UIFont italicSystemFontOfSize:15];
        [self addSubview:self.labelTranslation];
        
        self.labelDetails = [[UILabel alloc]initWithFrame:CGRectMake(20, 121, 280, 363)];
        self.labelDetails.textColor = [UIColor blackColor];
        self.labelDetails.backgroundColor = [UIColor clearColor];
        self.labelDetails.textAlignment = NSTextAlignmentCenter;
        self.labelDetails.numberOfLines = 0;
        [self addSubview:self.labelDetails];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
