//
//  CollectionViewCell.m
//  DiscuzQ
//
//  Created by WebersonGao on 17/10/21.
//  Copyright © 2015年 WebersonGao. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, KScreenWidth-25, 50)];
    self.titleLabel.font = KFont(14);//14
    self.titleLabel.textColor = KTitle_Color;
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame), 100, 15)];
    self.nameLabel.font = KFont(12);//12
    self.nameLabel.textColor = KGreen_Color;
    [self addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 5, self.titleLabel.frame.size.height, 120, 15)];
    self.timeLabel.font = KFont(12);//12
    self.timeLabel.textColor = mRGBColor(180, 180, 180);
    [self addSubview:self.timeLabel];
    
}

- (void)setData:(NSDictionary*)dic {
    
    self.titleLabel.text = [dic objectForKey:@"title"];
    
    if ([DataCheck isValidString:[dic objectForKey:@"author"]])
    {
        self.nameLabel.text = [dic objectForKey:@"author"];
    }
    self.timeLabel.text = [NSDate timeStringFromTimestamp:[dic objectForKey:@"dateline"] format:@"yyyy-MM-dd"];
}

@end
