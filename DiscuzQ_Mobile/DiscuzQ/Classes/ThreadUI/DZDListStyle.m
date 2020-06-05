//
//  DZDListStyle.m
//  DiscuzQ
//
//  Created by WebersonGao on 2020/6/3.
//  Copyright © 2020 WebersonGao. All rights reserved.
//

#import "DZDListStyle.h"

@implementation DZDUserStyle

/// @param isBasic 为 YES 时 整体偏小
+(instancetype)DUserStyle:(CGFloat)cellWidth basic:(BOOL)isBasic{
    
    DZDUserStyle *userStyle = [[DZDUserStyle alloc] init];
    
    // 第一部分 用户基本信息
    if (isBasic) {
        
        userStyle.kf_avatar = CGRectMake(kMargin15, kMargin5, 34, 34);
        userStyle.kf_userName = CGRectMake(CGRectGetMaxX(userStyle.kf_avatar) + kMargin10, kMargin15, 150, 14);
        userStyle.kf_userTag = CGRectMake(CGRectGetMaxX(userStyle.kf_avatar)-10, CGRectGetMaxY(userStyle.kf_avatar)-10, 10, 10);
        userStyle.kf_time = CGRectMake(cellWidth-kMargin15 - 180, kMargin15, 180, 14);
        userStyle.kf_bottomLine = CGRectMake(0, CGRectGetMaxY(userStyle.kf_avatar)+kMargin5, cellWidth, 0.5);
        
        userStyle.kf_grade = CGRectZero;
        userStyle.kf_postMore = CGRectZero;
        userStyle.kf_threadTag = CGRectZero;
        
    }else{
        
        userStyle.kf_avatar = CGRectMake(kMargin15, kMargin10, 40, 40);
        userStyle.kf_userTag = CGRectMake(CGRectGetMaxX(userStyle.kf_avatar)-10, CGRectGetMaxY(userStyle.kf_avatar)-10, 10, 10);
        userStyle.kf_userName = CGRectMake(CGRectGetMaxX(userStyle.kf_avatar)+kMargin15, CGRectGetMinX(userStyle.kf_avatar), 250, 15);
        userStyle.kf_grade = CGRectMake(0, 0, 0, 0);
        userStyle.kf_time = CGRectMake(CGRectGetMaxX(userStyle.kf_avatar)+kMargin15, CGRectGetMaxY(userStyle.kf_avatar)-13, 250, 13);
        
        userStyle.kf_postMore = CGRectMake(cellWidth-kMargin15-20, CGRectGetMinX(userStyle.kf_avatar), 20, 18);
        userStyle.kf_threadTag = CGRectMake(cellWidth-kMargin15-kMargin10-(20 * 2), CGRectGetMinX(userStyle.kf_avatar), 20, 18);
        
        userStyle.kf_bottomLine = CGRectMake(0, CGRectGetMaxY(userStyle.kf_avatar)+kMargin10, cellWidth, 0.5);

    }
    
    userStyle.kf_UserHeight = CGRectGetMaxY(userStyle.kf_bottomLine);
    
    
    return userStyle;
}

@end


@implementation DZDGridStyle

+(instancetype)DGridImageStyle:(NSInteger)thumCount{
    
    DZDGridStyle *grid = [[DZDGridStyle alloc] init];
    
    // 行间距 (上下间隔)
    grid.minimumLine = kMargin5-1;
    // 列间距 (左右间隔)
    grid.minimumInteritem = kMargin5-1;
    grid.itemSize = CGSizeMake(kDis_PicCellWH, kDis_PicCellWH);
    grid.gridEdge = UIEdgeInsetsMake(kMargin10, 0, kMargin10, 0);
    
    
    return thumCount ? grid : nil;
}

@end




@implementation DZDContentStyle

// 计算主题（帖子）内容 frame
+(instancetype)DThreadContentStyleWithMaxW:(CGFloat)maxWidth dataModel:(DZQDataThread *)dataModel{
    
    NSString *contentHtml = dataModel.relationships.firstPost.attributes.contentHtml;
    CGFloat localOneH = [self canculateContentDetailHeight:dataModel maxW:maxWidth font:k_One_fontSize];
    
    DZDContentStyle *contentStyle = [self inner_contentStyle:contentHtml localOneH:localOneH contentMaxW:maxWidth font:KBoldFont(k_One_fontSize)];
    
    contentStyle.kf_squareGrid = [DZDGridStyle DGridImageStyle:dataModel.relationships.firstPost.relationships.images.count];
    
    return contentStyle;
}

// 计算评论内容 frame
+(instancetype)DPostContentStyleWithMaxW:(CGFloat)maxWidth dataModel:(DZQDataPost *)dataModel{
    
    NSString *contentHtml = dataModel.attributes.contentHtml;
    CGFloat localOneH = [self canculatePostContentHeight:dataModel];
    
    DZDContentStyle *contentStyle = [self inner_contentStyle:contentHtml localOneH:localOneH contentMaxW:maxWidth font:KFont(14.f)];
    
    contentStyle.kf_squareGrid = [DZDGridStyle DGridImageStyle:dataModel.relationships.images.count];
    
    return contentStyle;
}

+(instancetype)inner_contentStyle:(NSString *)contentHtml localOneH:(CGFloat)localOneH contentMaxW:(CGFloat)contenMaxWidth font:(UIFont *)font{
    
    DZDContentStyle *contStyle = [[DZDContentStyle alloc] init];
    
    CGFloat oneMarginY = localOneH ? kMargin10 : 0;
    CGFloat twoMarginY = localOneH ? kMargin15 : kMargin10;
    
    contStyle.kf_oneFrame = CGRectMake(kMargin15, oneMarginY, contenMaxWidth, localOneH);
    // CGFLOAT_HEIGHT_UNKNOWN 不可替换
    contStyle.kf_twoMaxRect = CGRectMake(kMargin15, CGRectGetMaxY(contStyle.kf_oneFrame)+twoMarginY, contenMaxWidth, CGFLOAT_HEIGHT_UNKNOWN);
    contStyle.kf_twoItem = [DZHtmlItem canculateHtmlStyle:contentHtml maxRect:contStyle.kf_twoMaxRect];
    contStyle.kf_twoFrame = contStyle.kf_twoItem.frame;
    contStyle.kf_oneFont = font ? font : [UIFont systemFontOfSize:14.f];
    
    CGFloat contentMargin = (contStyle.kf_oneFrame.size.height && contStyle.kf_twoFrame.size.height) ? kMargin35 : kMargin20;
    
    contStyle.kf_ContentHeight = (contStyle.kf_oneFrame.size.height + contStyle.kf_twoItem.frame.size.height) + contentMargin;
    
    return contStyle;
}

// 返回的 只有第一部分的高度
+ (CGFloat)canculateContentDetailHeight:(DZQDataThread *)dataModel maxW:(CGFloat)maxWidth font:(CGFloat)titleSize{
    
    // 文章类型(0 普通 1 长文 2 视频)
    CGFloat oneHeight = 0;
    NSInteger modelType = dataModel.attributes.type;
    
    if (modelType == 0) {
        // 第一部分 只能是 图片
        NSInteger imageCount = dataModel.relationships.firstPost.relationships.images.count;
        
        CGFloat imageHeight = ((int)(ceilf(imageCount/3.f))) * (kDis_PicCellWH + kMargin5)+kMargin15;
        
        oneHeight = imageCount ? imageHeight : 0;
        
    }else if (modelType == 1){
        // 长文章 的标题
        oneHeight = [NSString cacaulteStringHeight:dataModel.attributes.title fontSize:titleSize width:maxWidth lineSpacing:5];
    }else if (modelType == 2){
        // 视频预览图
        CGFloat videoHeight = (maxWidth/1920.0)*1080.0;  // 视频宽高比 1920 x 1080
        
        oneHeight = dataModel.relationships.threadVideo.attributes.cover_url.length ? videoHeight : 0;
    }
    
    // 只返回第一个 高度
    return oneHeight;
}

// 返回的 只有第一部分的高度
+ (CGFloat)canculatePostContentHeight:(DZQDataPost *)dataModel{
    
    // 回复内容（目前只支持 图片回复）
    
    NSInteger imageCount = dataModel.relationships.images.count;
    
    CGFloat imageHeight = ((int)(ceilf(imageCount/3.f))) * (kDis_PicCellWH + kMargin5)+kMargin15;
    
    CGFloat oneHeight = imageCount ? imageHeight : 0;
    
    return oneHeight;
}

@end


@implementation DZDToolBarStyle

+(instancetype)DToolBarStyle:(CGFloat)cellWidth{
    
    DZDToolBarStyle *barStyle = [[DZDToolBarStyle alloc] init];
    
    barStyle.kf_left = CGRectMake(0, 0, (cellWidth)/3.0, kMiniBarHeight);
    barStyle.kf_center = CGRectMake((cellWidth)/3.0, 0, (cellWidth)/3.0, kMiniBarHeight);
    barStyle.kf_right = CGRectMake(((cellWidth)/3.0)*2.0, 0, (cellWidth)/3.0, kMiniBarHeight);
    barStyle.kf_barLine = CGRectMake(0, CGRectGetMaxY(barStyle.kf_right), cellWidth, 1);
    
    barStyle.kf_ToolBarHeight = CGRectGetHeight(barStyle.kf_right)+1;
    
    return barStyle;
}


@end