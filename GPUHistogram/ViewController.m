//
//  ViewController.m
//  GPUHistogram
//
//  Created by Nikolas Gelo on 10/21/14.
//  Copyright (c) 2014 Nikolas Gelo. All rights reserved.
//

#import "ViewController.h"

#import <GPUImage/GPUImage.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet GPUImageView *videoCameraView;

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;

@end

@implementation ViewController

#pragma mark - UIViewController
#pragma mark Managing the View

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    self.videoCamera.outputImageOrientation = self.interfaceOrientation;
    
    GPUImageHistogramFilter *histogramFilter = [[GPUImageHistogramFilter alloc] initWithHistogramType:kGPUImageHistogramRGB];
    
    GPUImageHistogramGenerator *histogramGraph = [[GPUImageHistogramGenerator alloc] init];
    [histogramGraph forceProcessingAtSize:self.videoCameraView.frame.size];
    
    [self.videoCamera addTarget:histogramFilter];
    [histogramFilter addTarget:histogramGraph];
    [histogramGraph addTarget:self.videoCameraView];
}

#pragma mark Responding to View Events

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.videoCamera startCameraCapture];
}

#pragma mark Handling Memory Warnings

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
