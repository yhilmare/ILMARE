//
//  YHArticleVisitInfo.h
//  ILMARE
//
//  Created by yh_swjtu on 17/7/5.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHArticleVisitInfo : NSObject

@property (nonatomic, copy) NSString *article_id;

@property (nonatomic, copy) NSString *article_title;

@property (nonatomic, strong) NSDate *visit_date;

@property (nonatomic, copy) NSString *visit_id;

@property (nonatomic, copy) NSString *visitor_id;

@end
