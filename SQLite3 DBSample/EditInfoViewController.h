//
//  EditInfoViewController.h
//  SQLite3 DBSample
//
//  Created by Zaur Giyasov on 30/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditInfoViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;
@property (weak, nonatomic) IBOutlet UITextField *txtLastname;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;

@property (nonatomic, strong) id<EditInfoViewControllerDelegate> selfDelegate;

- (IBAction)saveInfo:(UIBarButtonItem *)sender;

@end

@protocol EditInfoViewControllerDelegate

-(void)editingInfoWasFinished;

@end
