//
//  CPViewController_MainController.h
//  Can I Pass?
//
//  Created by Rechee Jozil on 1/3/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPViewController_MainController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextInputTraits>


@property (strong, nonatomic) IBOutlet UILabel *Label_PercentageTotal;

@property (strong, nonatomic) IBOutlet UIButton *Button_CalculateGrade;
- (IBAction)CalculateGradePressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *GradeList;

@property (strong, nonatomic) IBOutlet UIButton *Button_AddNewGrade;

- (IBAction)AddNewGradePressed:(id)sender;
@end
