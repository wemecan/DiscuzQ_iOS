//
//  DZThreadArticle.h
//  DiscuzQ
//
//  Created by WebersonGao on 2020/5/23.
//  Copyright © 2020 WebersonGao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZDDetailStyle.h"

NS_ASSUME_NONNULL_BEGIN

@interface DZThreadArticle : UIView

- (void)updateThreadArticle:(DZQDataThread *)Model style:(DZDHeadStyle *)localStyle;



@end

NS_ASSUME_NONNULL_END
