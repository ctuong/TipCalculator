//
//  SettingsViewController.m
//  Tip Calculator
//
//  Created by Calvin Tuong on 12/16/14.
//  Copyright (c) 2014 Calvin Tuong. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *percentagePicker;
@property (strong, nonatomic) NSArray *tipAmounts;

- (void)saveDefaultTipPercentageIndex:(NSInteger)index;

// picker view interface methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
- (NSInteger)getDefaultTipPercentage;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self) {
        self.title = @"Settings";
    }
    
    self.tipAmounts = @[@(10), @(15), @(20)];
    [self selectDefaultTipPercentageInPicker];
}

- (void)viewWillAppear:(BOOL)animated {
    [self selectDefaultTipPercentageInPicker];
}

- (void)selectDefaultTipPercentageInPicker {
    NSInteger index = [self getDefaultTipPercentage];
    [self.percentagePicker selectRow:index inComponent:0 animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self saveDefaultTipPercentageIndex:row];
}

- (void)saveDefaultTipPercentageIndex:(NSInteger)index {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:index forKey:@"default_tip_index"];
    [defaults synchronize];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.tipAmounts count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%ld%%", [self.tipAmounts[row] integerValue]];
}

- (NSInteger)getDefaultTipPercentage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // returns 0 if key doesn't exist, which would correspond to 10%
    return [defaults integerForKey:@"default_tip_index"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
