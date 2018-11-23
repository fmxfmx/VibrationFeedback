/////////////////////////////////////////////////////////////////////////////////////////////////////
///	
///  @file       VibrationFeedback.m
///  @copyright  Copyright © 2018 小灬豆米. All rights reserved.
///  @brief      VibrationFeedback
///  @date       2018/11/9
///  @author     小灬豆米
///
/////////////////////////////////////////////////////////////////////////////////////////////////////

#import "VibrationFeedback.h"
#import <AudioToolbox/AudioServices.h>

@interface VibrationFeedback ()

@property (nonatomic, strong) UIImpactFeedbackGenerator *feedbackGenerator NS_AVAILABLE_IOS(10_0);
@property (nonatomic, assign) VibrationFeedbackType feedbackType;

@end

@implementation VibrationFeedback

- (instancetype)init
{
    return [self initWithFeedbackType:VibrationFeedbackTypeMedium];
}

- (instancetype)initWithFeedbackType:(VibrationFeedbackType)feedbackType
{
    self = [super init];
    
    if (self) {
        self.feedbackType = feedbackType;
        
        if (@available(iOS 10.0, *)) {
            UIImpactFeedbackStyle newfeedbackType = UIImpactFeedbackStyleLight;
            switch (feedbackType) {
                case VibrationFeedbackTypeContinuous:
                    break;
                case VibrationFeedbackTypeLight:
                    newfeedbackType = UIImpactFeedbackStyleLight;
                    break;
                case VibrationFeedbackTypeMedium:
                    newfeedbackType = UIImpactFeedbackStyleMedium;
                    break;
                case VibrationFeedbackTypeHigh:
                    newfeedbackType = UIImpactFeedbackStyleHeavy;
                    break;
            }
            
            self.feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:newfeedbackType];
        }
    }
    
    return self;
}

- (void)startFeedback
{
    if (self.feedbackType == VibrationFeedbackTypeContinuous) {
        AudioServicesPlaySystemSound(1521);
        return;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wunguarded-availability"
    if (self.feedbackGenerator) {
        [self.feedbackGenerator prepare];
        [self.feedbackGenerator impactOccurred];
    } else {
        switch (self.feedbackType) {
            case VibrationFeedbackTypeMedium:
                AudioServicesPlaySystemSound(1519);
                break;
            case VibrationFeedbackTypeHigh:
                AudioServicesPlaySystemSound(1520);
                break;
            default:
                break;
        }
    }
#pragma clang diagnostic pop
}

+ (void)startFeedbackWith:(VibrationFeedbackType)feedbackType
{
    VibrationFeedback *vibrationFeedback = [[VibrationFeedback alloc] initWithFeedbackType:feedbackType];
    [vibrationFeedback startFeedback];
}

@end
