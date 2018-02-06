//
//  ViewController.m
//  Video to Gif
//
//  Created by Julian Triveri on 1/24/18.
//  Copyright © 2018 Trevir. All rights reserved.
//

#import "ViewController.h"
#include <Photos/PHPhotoLibrary.h>
#include <Photos/PHAssetChangeRequest.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *sourceScrollView;
@property (weak, nonatomic) IBOutlet UIView *imagePickerContainer;
@property (weak, nonatomic) IBOutlet UIView *cameraViewContainer;
@property (weak, nonatomic) IBOutlet UILabel *framerateLabel;
@property (weak, nonatomic) IBOutlet UISlider *framerateSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *qualityOption;
@property UIImagePickerController *imagePicker;
@property UIImagePickerController *cameraView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.sourceScrollView setContentSize:CGSizeMake(self.sourceScrollView.frame.size.width * 2, self.sourceScrollView.frame.size.height)];
	[self.sourceScrollView setClipsToBounds:NO];
	
	self.imagePicker = UIImagePickerController.new;
	
	[self.imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
	[self.imagePicker setDelegate:self];
	[self.imagePicker setMediaTypes: [[NSArray alloc] initWithObjects: (NSString *)kUTTypeMovie, nil]];
	
	[self.imagePicker.view.layer setCornerRadius:10];
	[self.imagePicker.view setClipsToBounds:true];
	[self.imagePicker.view setFrame:CGRectMake(0,0,self.imagePickerContainer.frame.size.width,self.imagePickerContainer.frame.size.height)];
	
	[self.imagePickerContainer.layer setShadowColor:[UIColor.blackColor CGColor]];
	[self.imagePickerContainer.layer setShadowOffset:CGSizeMake(0, 5)];
	[self.imagePickerContainer.layer setShadowOpacity:0.3];
	[self.imagePickerContainer.layer setShadowRadius:15];
	[self.imagePickerContainer.layer setCornerRadius:10];
	
	self.cameraView = UIImagePickerController.new;
	
	[self.cameraView setSourceType:UIImagePickerControllerSourceTypeCamera];
	[self.cameraView setDelegate:self];
	[self.cameraView setMediaTypes: [[NSArray alloc] initWithObjects: (NSString *)kUTTypeMovie, nil]];
	
	[self.cameraView.view.layer setCornerRadius:10];
	[self.cameraView.view setClipsToBounds:true];
	[self.cameraView.view setFrame:CGRectMake(0,0,self.imagePickerContainer.frame.size.width,self.imagePickerContainer.frame.size.height)];
	
	[self.cameraViewContainer setFrame:CGRectMake(self.imagePickerContainer.frame.size.width + 24, 28, self.cameraViewContainer.frame.size.width, self.cameraViewContainer.frame.size.height)];
	[self.cameraViewContainer.layer setShadowColor:[UIColor.blackColor CGColor]];
	[self.cameraViewContainer.layer setShadowOffset:CGSizeMake(0, 5)];
	[self.cameraViewContainer.layer setShadowOpacity:0.3];
	[self.cameraViewContainer.layer setShadowRadius:15];
	[self.cameraViewContainer.layer setCornerRadius:10];
	
	[self.imagePickerContainer addSubview:self.imagePicker.view];
	[self.cameraViewContainer addSubview:self.cameraView.view];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


@end
