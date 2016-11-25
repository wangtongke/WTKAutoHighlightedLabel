//
//  ViewController.m
//  WTKAutoHighlightedLabelDemo
//
//  Created by 王同科 on 2016/11/24.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "ViewController.h"
#import "WTKAutoHighLightLabel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet WTKAutoHighLightLabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_label wtk_setText:@"sadsadfsadasasdasda@dasdgisagfdhsfjdsvfjsd asd" withClickBlock:^(NSString *text) {
        
    }];
}

- (IBAction)btnClick:(id)sender {
    _label.w_normalColor = [UIColor blackColor];
    _label.w_highColor = [UIColor greenColor];
    _label.w_selectedColor = [UIColor yellowColor];
    [_label wtk_setText:self.textView.text withClickBlock:^(NSString *text) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
