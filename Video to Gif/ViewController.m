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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
		
	} completionHandler:^(BOOL success, NSError * _Nullable error) {
		
	}];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


@end
