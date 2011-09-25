//
//  SwitchView.h
//  LightOn
//
//  Created by Al Pascual on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>

#import "AboutView.h"

@interface SwitchView : UIViewController {
    
    BOOL flashlightOn;
    AVCaptureSession *session;
    NSTimer *levelTimer;
    NSInteger typeOfLight;
    
    UILabel *OnOffSwitch;
}

@property (nonatomic,retain) IBOutlet UILabel *OnOffSwitch;

- (IBAction) pressButton;
- (void)toggleFlashlight:(NSInteger)buttonNumber;
- (void) setAndCheckTypeOfLight:(NSInteger)typeOfLightPassed;


- (IBAction)firstLight;
- (IBAction)secondLight;
- (IBAction)thirdLight;
- (IBAction)forthLight;

-(IBAction)aboutPressed;
-(void)offLight;

@end
