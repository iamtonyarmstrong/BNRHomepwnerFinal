//
//  BNRDetailViewController.m
//  BNRHomepwnerFinal
//
//  Created by Anthony Armstrong on 5/8/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRDateChangeViewController.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation BNRDetailViewController


- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    //ok, take the item that this view gets and populate the fields on the view
    BNRItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.sNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.value];

    //And we need an NSDateFormatter to turn the date into a simple string
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }

    //Use filtered date object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];

    //Get the image for its image from the image store using the UUID key
    //and populate the UIImageView with it
    NSString *itemKey = self.item.itemUUIDKey;
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
    self.imageView.image = imageToDisplay;


}


- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    //Clear first responder
    [self.view endEditing:YES];

    BNRItem *item =self.item;
    item.itemName = self.nameField.text;
    item.sNumber = self.serialNumberField.text;
    item.value = [self.valueField.text intValue];
    
}

//Dismiss the keyboard when user taps on UIView anywhere outside textField
- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - Methods to handle camera functionality
//Notice, this is how to interact with the camera. Check to see if there's a cam available, if not
//select from the photo library.
- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.allowsEditing = YES;
    } else {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    imagePickerController.delegate = self;

    //Place image picker on the screen
    [self presentViewController:imagePickerController
                       animated:YES
                     completion:NULL];
}


- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Get picked image from the info directory
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    if(info[UIImagePickerControllerEditedImage]) image = info[UIImagePickerControllerEditedImage];

    //Store the image in the ImageStore using the UUID as the key
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemUUIDKey];

    //put that image into the UIImageView
    self.imageView.image = image;

    //Now, dismiss the image picker - take it off the screen
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)removeImageFromItem:(id)sender
{
    self.imageView.image = nil;
    [[BNRImageStore sharedStore] deleteImageForKey:self.item.itemUUIDKey];

    [self.view setNeedsDisplay];

}

- (IBAction)changeDateForItem:(id)sender
{
    
    BNRDateChangeViewController *dateViewController = [[BNRDateChangeViewController alloc] init];

    //Give the detail view controller the Item
    dateViewController.item = self.item;
    dateViewController.dvc = self;

    //push the new view controller to the top of the stack when a row is selected.
    [self.navigationController pushViewController:dateViewController animated:YES];
}


#pragma mark - Keyboard functionality
//Kill keyboard if user taps outside of the text field
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


//For keyboards without a RETURN button (or that you can't dismiss otherwise, use this method
//Simply resign the first responder with the first touch outside the of the keyboard.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.valueField resignFirstResponder];
}

@end