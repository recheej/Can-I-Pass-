//
//  CPViewController_MainController.m
//  Can I Pass?
//
//  Created by Rechee Jozil on 1/3/14.
//  Copyright (c) 2014 Rechee Jozil. All rights reserved.
//

#import "CPViewController_MainController.h"

@interface CPViewController_MainController ()

@end

@implementation CPViewController_MainController
{
    NSInteger numberOfRows;
    BOOL isDeleting;
 //   BOOL alreadyEdited;
    int gradeWeightEntered;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    numberOfRows = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
  //  [self.GradeList setEditing:YES animated:NO];
    
	// Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isDeleting == true)
    {
        numberOfRows-= 1;
    }
    else
    {
         numberOfRows+= 1;
    }
    
   
    return numberOfRows;
    
}


- (void) keyboardWasShown : (NSNotification*) notification
{
    NSDictionary *additionObjects = [notification userInfo];
    
    CGSize keyboardSize = [[additionObjects objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0);
    
    self.GradeList.contentInset = contentInset;
    self.GradeList.scrollIndicatorInsets = contentInset;
    
    
    NSLog(@"Keyboard came up");
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GradeCalculator"];
    
    
    return cell;
    
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField tag] == 1)
        return;
    
    [self addUpCells];
    
    
    /**
    double newGradePercentage = [textField.text doubleValue];
    double gradePercentageTotal = [self.Label_PercentageTotal.text doubleValue];
    
    
    if([textField tag] == 2 && alreadyEdited == false)
    {
        
        self.Label_PercentageTotal.text = [NSString stringWithFormat:@"%f", newGradePercentage + gradePercentageTotal];
    }
    else if([textField tag] == 2 && alreadyEdited == true)
    {
        double newValue = (gradePercentageTotal - gradeWeightEntered) + newGradePercentage;
        self.Label_PercentageTotal.text = [NSString stringWithFormat:@"%f", newValue];
    }
     */
}




- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    /**
    if([textField hasText])
    {
        gradeWeightEntered = [textField.text intValue];
        alreadyEdited = true;
    }
    else
    {
        alreadyEdited = false;
    }
     */
    
    int c = 5;
    int (^myBlock) (int one);
    
     myBlock = ^ int (int one)
    {
        return c + one;
        
        
    };
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    isDeleting = true;
    
    NSArray *newRowArary = [[NSArray alloc] initWithObjects:indexPath, nil];
    
    
    UITableViewCell *cellSelected = [self.GradeList cellForRowAtIndexPath:indexPath];
    UITextField *grade = (UITextField *) [cellSelected viewWithTag:1];
    UITextField *gradeWeight = (UITextField *) [cellSelected viewWithTag:2];
    
    
    if([grade hasText] || [gradeWeight hasText])
    {
        [self clear:grade :gradeWeight];
    }
    
    
    [self.GradeList beginUpdates];
    [self.GradeList deleteRowsAtIndexPaths:newRowArary withRowAnimation:UITableViewRowAnimationFade];
    [self.GradeList endUpdates];
    
    
    [self addUpCells];

    
}


- (void) addUpCells
{
    NSArray *remainingCells = [self.GradeList visibleCells];
    
    
    if([remainingCells count] == 0)
    {
        self.Label_PercentageTotal.text = @"0";
    }
    else
    {
        double gradeTotal = 0;
        UITextField *gradeWeight;
        
        for(UITableViewCell *cell in remainingCells)
        {
            gradeWeight = (UITextField *) [cell viewWithTag:2];
            gradeTotal+= [gradeWeight.text doubleValue];
        }
        
        self.Label_PercentageTotal.text = [NSString stringWithFormat:@"%f", gradeTotal];
    }
}

- (void) clear : (UITextField *) grade : (UITextField *) gradeWeight
{
    /**

    double gradePercentageTotal = [self.Label_PercentageTotal.text doubleValue];
    double gradeWeightInt = [gradeWeight.text doubleValue];
     */
    
    
    grade.text = @"";
    gradeWeight.text = @"";
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}




- (IBAction)CalculateGradePressed:(id)sender
{
    
    double gradeGrandTotal = 0.0;
    double totalWeightPercentage = 0.0;
    
    for(UITableViewCell *cell in [self.GradeList visibleCells])
    {
        UITextField *gradeWeightTextField = (UITextField *) [cell viewWithTag:2];
        UITextField *gradeValueTextField = (UITextField *) [cell viewWithTag:1];
        
        totalWeightPercentage += [gradeWeightTextField.text doubleValue];
        
        double gradeWeightDecimal = [gradeWeightTextField.text doubleValue] / 100;
        
        
        double tempValueText = [gradeValueTextField.text doubleValue];
        
        gradeGrandTotal += (gradeWeightDecimal * [gradeValueTextField.text doubleValue]);
    }
    
    
    double weightedGrandTotal = (gradeGrandTotal / totalWeightPercentage) * 100;
    
    
    double percentageRemaining = 100.00 - totalWeightPercentage;
    
    double gradeDesired = 80.0;
    
    
    double gradeNeeded = (gradeDesired - gradeGrandTotal) / percentageRemaining;
    
    gradeNeeded*= 100;
    
    
    NSLog([NSString stringWithFormat:@"Remaining percentage is: %f", percentageRemaining]);
}





- (IBAction)AddNewGradePressed:(id)sender
{
    isDeleting = false;
    NSArray *newRowArary = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:numberOfRows inSection:0], nil];
    
    
    
    [self.GradeList beginUpdates];
    [self.GradeList insertRowsAtIndexPaths:newRowArary withRowAnimation:UITableViewRowAnimationRight];
    [self.GradeList endUpdates];
}
@end
