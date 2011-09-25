//
//  SwitchView.m
//  LightOn
//
//  Created by Al Pascual on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SwitchView.h"


@implementation SwitchView

@synthesize OnOffSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    flashlightOn = NO;
    
    self.title = @"Lighting On";
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) pressButton {
    // Turn on off the light
    
    if (flashlightOn == NO)
    {
        flashlightOn = YES;
        //[flashlightButton setBackgroundImage:[UIImage imageNamed:@"TorchOff.png"] forState:UIControlStateNormal];
        [self toggleFlashlight:0];
    }
    else
    {
        flashlightOn = NO;
        //[flashlightButton setBackgroundImage:[UIImage imageNamed:@"TorchOn.png"] forState:UIControlStateNormal];
        [self offLight];
    }
}

// This is the master, try to do the same thing in different intervals.
- (IBAction)firstLight
{
    [self setAndCheckTypeOfLight:1];
    
    // Alert Light
    if (flashlightOn == NO)
    {
        flashlightOn = YES;
        levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    }
    else
    {
        [self offLight];
    }    
    
}
- (IBAction)secondLight
{
     [self setAndCheckTypeOfLight:2];
    // Alert Light
    if (flashlightOn == NO)
    {
        flashlightOn = YES;
        levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.0 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    }
    else
    {
        [self offLight];
    }
}
- (IBAction)thirdLight
{
     [self setAndCheckTypeOfLight:3];
    if (flashlightOn == NO)
    {
        flashlightOn = YES;
        levelTimer = [NSTimer scheduledTimerWithTimeInterval: 3.0 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    }
    else
    {
        [self offLight];
    }
}
- (IBAction)forthLight
{
     [self setAndCheckTypeOfLight:4];
    //[self toggleFlashlight:4];
    // lighting house
    if (flashlightOn == NO)
    {
        flashlightOn = YES;
        levelTimer = [NSTimer scheduledTimerWithTimeInterval: 1.5 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    }
    else
    {        
        [self offLight];
    }  
}

- (void)levelTimerCallback:(NSTimer *)timer {
    
    [self toggleFlashlight:9];
    
}

- (void) setAndCheckTypeOfLight:(NSInteger)typeOfLightPassed
{
    if ( typeOfLight != typeOfLightPassed)
    {
        if ( flashlightOn == YES )
        {
            if ( [levelTimer isValid] )
                [levelTimer invalidate];
            
            if (session != nil){
                [session stopRunning];
            [session release], session = nil;
            }
            
            flashlightOn = NO;
        }
    }
    
    typeOfLight = typeOfLightPassed;
}

- (void)toggleFlashlight:(NSInteger)buttonNumber
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (device.torchMode == AVCaptureTorchModeOff)
    {
        self.OnOffSwitch.text = @"ON";
        
        // Create an AV session
        session = [[AVCaptureSession alloc] init];
        
        // Create device input and add to current session
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error: nil];
        [session addInput:input];
        
        // Create video output and add to current session
        AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
        [session addOutput:output];
        
        // Start session configuration
        [session beginConfiguration];
        [device lockForConfiguration:nil];
        
        // Set torch to on
        [device setTorchMode:AVCaptureTorchModeOn];
        
        [device unlockForConfiguration];
        [session commitConfiguration];
        
        // Start the session
        [session startRunning];
        
        // Keep the session around
        //[self setAVSession:session];
        
        [output release];
    }
    else
    {
        if (session != nil)
        [session stopRunning];
        [session release], session = nil;
    }
}

-(void)offLight
{
    flashlightOn = NO;
    [levelTimer invalidate];
    
    if (session != nil){
        [session stopRunning];
        [session release], session = nil;
    }
    
    self.OnOffSwitch.text = @"OFF";
}

-(IBAction)aboutPressed
{
    //AboutView *about = [[AboutView alloc] initWithNibName:@"AboutView" bundle:nil];
    
    //[self navigationController:about];
}

@end
