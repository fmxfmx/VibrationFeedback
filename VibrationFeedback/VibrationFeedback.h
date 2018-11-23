/////////////////////////////////////////////////////////////////////////////////////////////////////
///	
///  @file       VibrationFeedback.h
///  @copyright  Copyright © 2018 小灬豆米. All rights reserved.
///  @brief      VibrationFeedback
///  @date       2018/11/9
///  @author     小灬豆米
///
/////////////////////////////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, VibrationFeedbackType) {
    VibrationFeedbackTypeLight,
    VibrationFeedbackTypeMedium,
    VibrationFeedbackTypeHigh,
    VibrationFeedbackTypeContinuous
};

@interface VibrationFeedback : NSObject

- (instancetype)initWithFeedbackType:(VibrationFeedbackType)feedbackType NS_DESIGNATED_INITIALIZER;

- (void)startFeedback;

+ (void)startFeedbackWith:(VibrationFeedbackType)feedbackType;

@end

NS_ASSUME_NONNULL_END
