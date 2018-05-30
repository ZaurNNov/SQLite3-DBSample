//
//  EditInfoViewController.h
//  SQLite3 DBSample
//
//  Created by Zaur Giyasov on 30/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;
@property (weak, nonatomic) IBOutlet UITextField *txtLastname;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;

- (IBAction)saveInfo:(UIBarButtonItem *)sender;


@end
