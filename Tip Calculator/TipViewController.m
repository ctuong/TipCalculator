//
//  TipViewController.m
//  Tip Calculator
//
//  Created by Calvin Tuong on 12/15/14.
//  Copyright (c) 2014 Calvin Tuong. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (nonatomic) NSInteger defaultTipIndex;

- (IBAction)onTap:(id)sender;
- (void)billValueChanged;
- (void)updateValues;
- (void)onSettingsButton;
- (void)loadDefaultTipPercentage;
- (NSString *)formatWithCommas:(float)amount;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self) {
        self.title = @"Tip Calculator";
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    // add target for when anything in the bill text field changes
    [self.billTextField addTarget:self action:@selector(billValueChanged) forControlEvents:UIControlEventEditingChanged];
    
    [self loadDefaultTipPercentage];
    [self updateValues];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadDefaultTipPercentage];
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)billValueChanged {
    [self updateValues];
}

- (void)updateValues {
    double billAmount = [self.billTextField.text doubleValue];
    
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    double tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] doubleValue];
    double totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [self formatWithCommas:tipAmount];
    self.totalLabel.text = [self formatWithCommas:totalAmount];
}

- (NSString *)formatWithCommas:(float)amount {
    NSMutableString *amountString = [NSMutableString stringWithFormat:@"%0.2f", amount];
    
    // guaranteed to have a decimal point and two decimal places
    NSInteger numDigits = [amountString length] - 3;
    NSInteger numCommas = (numDigits - 1) / 3;
    NSInteger numLeadingDigits = ((numDigits - 1) % 3) + 1;
    NSInteger index = numLeadingDigits;
    
    while (numCommas > 0) {
        // insert the comma at the appropriate index
        [amountString insertString:@"," atIndex:index];
        numCommas--;
        index = index + 4; // a comma plus 3 more digits
    }
    
    [amountString insertString:@"$" atIndex:0];
    return amountString;
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)loadDefaultTipPercentage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // returns 0 if key doesn't exist, which would correspond to 10%
    self.defaultTipIndex = [defaults integerForKey:@"default_tip_index"];
    self.tipControl.selectedSegmentIndex = self.defaultTipIndex;
}

@end
