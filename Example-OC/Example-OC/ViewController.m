/////////////////////////////////////////////////////////////////////////////////////////////////////
///	
///  @file       ViewController.m
///  @copyright  Copyright © 2018 小灬豆米. All rights reserved.
///  @brief      ViewController
///  @date       2018/11/9
///  @author     小灬豆米
///
/////////////////////////////////////////////////////////////////////////////////////////////////////

#import "ViewController.h"
#import "VibrationFeedback.h"

static NSString * const kCellIdentifier = @"cellIdentifier";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *datas;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
    
    self.datas = @[@[@"UIImpactFeedbackStyleLight", @"UIImpactFeedbackStyleMedium", @"UIImpactFeedbackStyleHeavy"],
                   @[@"UISelectionFeedbackGenerator"],
                   @[@"UINotificationFeedbackTypeError", @"UINotificationFeedbackTypeSuccess", @"UINotificationFeedbackTypeWarning"]];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.datas[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                [VibrationFeedback startFeedbackWith:VibrationFeedbackTypeLight];
            }
            
            if (indexPath.row == 1) {
                [VibrationFeedback startFeedbackWith:VibrationFeedbackTypeMedium];
            }
            
            if (indexPath.row == 2) {
                [VibrationFeedback startFeedbackWith:VibrationFeedbackTypeHigh];
            }
        }
            break;
        case 1:
        {
            UISelectionFeedbackGenerator *selectionFeedback = [[UISelectionFeedbackGenerator alloc] init];
            [selectionFeedback prepare];
            [selectionFeedback selectionChanged];
        }
            break;
        case 2:
        {
            UINotificationFeedbackGenerator *notificationFeedback = [[UINotificationFeedbackGenerator alloc] init];
            [notificationFeedback prepare];
            
            if (indexPath.row == 0) {
                [notificationFeedback notificationOccurred:UINotificationFeedbackTypeError];
            }
            
            if (indexPath.row == 1) {
                [notificationFeedback notificationOccurred:UINotificationFeedbackTypeSuccess];
            }
            
            if (indexPath.row == 2) {
                [notificationFeedback notificationOccurred:UINotificationFeedbackTypeWarning];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - Customized

- (void)initUI
{
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Getters

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

@end
