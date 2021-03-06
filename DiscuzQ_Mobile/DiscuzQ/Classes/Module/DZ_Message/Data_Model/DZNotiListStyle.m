//
//  DZNotiListStyle.m
//  DiscuzQ
//
//  Created by WebersonGao on 2020/6/2.
//  Copyright © 2020 WebersonGao. All rights reserved.
//

#import "DZNotiListStyle.h"

@implementation DZNotiListStyle

+(DZNotiListStyle *)inner_dataStyle:(DZQDataNoti *)dataModel{
    
    DZNotiListStyle *localStyle = [DZNotiListStyle DNotiContentStyleWithCellWidth:KScreenWidth dataModel:dataModel];
    
    return localStyle;
    
}


// 计算 通知 内容 frame
+(instancetype)DNotiContentStyleWithCellWidth:(CGFloat)cellWidth dataModel:(DZQDataNoti *)dataModel{
    
    CGFloat leftX = kMargin15 + 34 + kMargin10;
    NSString *Noti_HtmlString = [self contentWithType:dataModel.attributes];
    
    // 开始计算布局
    DZNotiListStyle *localStyle = [[DZNotiListStyle alloc] init];
    
    localStyle.kf_oneFont = nil;
    
    localStyle.frame_Noti_user = [DZDUserStyle DUserStyle:cellWidth basic:YES];
    localStyle.frame_Noti_user.nameAttributedString = [NSString attributeWithLineSpaceing:0 text:dataModel.attributes.user_name font:KFont(14.f)];
    
    localStyle.kf_oneFrame = CGRectMake(0, 0, cellWidth, localStyle.frame_Noti_user.kf_UserHeight);
    localStyle.kf_twoMaxRect = CGRectMake(leftX, CGRectGetHeight(localStyle.kf_oneFrame) + kMargin10, cellWidth-leftX-kMargin15, CGFLOAT_MAX);
    
    localStyle.kf_timeString = [dataModel.attributes.created_at dateFormatWithAccurate:unAccurate];
    localStyle.kf_twoItem = [DZHtmlItem canculateHtmlStyle:Noti_HtmlString maxRect:localStyle.kf_twoMaxRect];
    
    localStyle.kf_twoFrame = CGRectMake(leftX, CGRectGetHeight(localStyle.kf_oneFrame)+kMargin10, cellWidth-leftX-kMargin15, localStyle.kf_twoItem.frame.size.height);
    
    localStyle.kf_ContentHeight = CGRectGetHeight(localStyle.kf_oneFrame) + CGRectGetHeight(localStyle.kf_twoFrame) + kMargin20;
    
    
    return localStyle;
    
}

+(NSString *)contentWithType:(DZQNotiModel *)model{
    
    NSString *contentStr = nil;
    if ([model.type isEqualToString:@"system"]) {
        // 系统
        contentStr = model.content;
    }else if ([model.type isEqualToString:@"replied"]){
        // 回复
        contentStr = model.post_content;
    }else if ([model.type isEqualToString:@"liked"]){
        // 点赞
        contentStr = model.post_content;
    }else if ([model.type isEqualToString:@"rewarded"]){
        // 打赏
        contentStr = model.content;
    }else if ([model.type isEqualToString:@"related"]){
        // @我的
        contentStr = model.post_content;
    }else if ([model.type isEqualToString:@"withdrawal"]){
        // 提现
        contentStr = @"提现通知的临时展示文字，后期需要拼接字符串";
    }
    
    return contentStr;
}


@end






