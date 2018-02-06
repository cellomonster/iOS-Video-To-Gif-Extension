//
//  ActionViewController.m
//  Gif-Converter
//
//  Created by Julian Triveri on 1/24/18.
//  Copyright © 2018 Trevir. All rights reserved.
//

#import "ActionViewController.h"
#import "NSGIF.h"
#import <MobileCoreServices/MobileCoreServices.h>
#include <Photos/PHPhotoLibrary.h>
#include <Photos/PHAssetChangeRequest.h>

@interface ActionViewController()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation ActionViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
		
	}];
	
	//Items picked
	for (NSExtensionItem *item in self.extensionContext.inputItems) {
		for (NSItemProvider *itemProvider in item.attachments) {
			//Check if the picked item is a movie
			if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeMovie]) {
				//If so, load the movie
				[itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeMovie options:nil completionHandler:^(NSURL *movieURL, NSError *error) {
					//Make sure it isnt nil
					if(movieURL){
						//Request a video to gif conversion
						NSGIFRequest * request = [NSGIFRequest requestWithSourceVideo:movieURL];
						request.scalePreset = NSGIFScaleVeryLow;
						request.framesPerSecond = 12;
						//Log progress of the gif conversion
						request.progressHandler = ^(double progress, NSUInteger position, NSUInteger length, CMTime time, BOOL *stop, NSDictionary *frameProperties) {
							NSLog(@"%f - %lu - %lu - %lld - %@", progress, position, length, time.value, frameProperties);
							[self performSelectorOnMainThread:@selector(setProgress:) withObject:[NSNumber numberWithFloat:progress] waitUntilDone:YES];
						};
						
						//On conversion completion
						[NSGIF create:request completion:^(NSURL *gifURL) {
							//Check it isnt nil
							if(gifURL)
								//Save to the camera roll
								[PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
									[PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:gifURL];
								} completionHandler:^(BOOL success, NSError * _Nullable error) {
									NSLog(@"：%d",success);
								}];
							//Close the UI
							[self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
						}];
					}
				}];
				break;
			}
		}
		break;
	}
}

- (void)setProgress:(NSNumber *)number
{
	[self.progressView setProgress:number.floatValue animated:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
