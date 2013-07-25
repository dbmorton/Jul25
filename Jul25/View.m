//
//  View.m
//  Jul25
//
//  Created by david morton on 7/25/13.
//  Copyright (c) 2013 David Morton Enterprises. All rights reserved.
//

#import "View.h"
#import "ViewController.h"

@implementation View

/*
 - (id) initWithFrame: (CGRect) frame
 {
 self = [super initWithFrame: frame];
 if (self) {
 // Initialization code
 }
 return self;
 }
 */

- (id) initWithFrame: (CGRect) frame controller: (ViewController *) c bandData:(BandData *)bd{
	self = [super initWithFrame: frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor blackColor];
		self.editable = NO;	//Don't pop up a keyboard.
		self.font = [UIFont fontWithName: @"Courier" size: 14]; //monospace
		self.bandData=bd;
		viewController = c;
	}
	return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void) drawRect: (CGRect) rect
{
	
	NSLog(@"self.bounds.size.width=%f",self.bounds.size.width);
	//NSLog(@"height=%f",self.bounds.size.height);
	
	NSString *string = _bandData.bandName;
	UIFont *font = [UIFont systemFontOfSize: 32];
	CGSize size = [string sizeWithFont: font];
	
	CGRect f = CGRectMake(
						  self.bounds.size.width/2-size.width/2,
						  self.bounds.origin.y,
						  size.width,
						  size.height
						  );
	
	label = [[UILabel alloc] initWithFrame: f];
	label.backgroundColor = [UIColor blackColor];
	label.textColor=[UIColor whiteColor];
	label.font = font;
	label.text = string;
	[self addSubview: label];
	
	
	if (_bandData.bandImage == nil) {
		NSLog(@"could not find the image");
	}else{
		CGPoint point = CGPointMake(0,size.height);
		[_bandData.bandImage drawAtPoint: point];
	}
	
	float textViewStart=size.height+_bandData.bandImage.size.height;
	NSLog(@"textViewStart=%f",textViewStart);
	
	CGRect g = CGRectMake(
						  0,
						  textViewStart,
						  self.bounds.size.width,
						  self.bounds.size.height-textViewStart
						  );
	
	textView = [[UITextView alloc] initWithFrame: g];
	textView.backgroundColor = [UIColor blackColor];
	textView.textColor = [UIColor whiteColor];
	textView.font = [UIFont fontWithName: @"Times New Roman" size: 15.75];
	textView.editable = NO;	//Don't pop up a keyboard.
	
	textView.text =_bandData.bio;
	
	[self addSubview: textView];

	/*
	// Drawing code
	self.text = [viewController.text stringByAppendingString: @"\n"];
	
	for (UIView *v = self; v != nil; v = v.superview) {
		self.text = [self.text stringByAppendingFormat:
					 @"%@\n"
					 @"frame  (%g, %2g), %g × %g\n"
					 @"bounds (%g, %2g), %g × %g\n",
					 NSStringFromClass(v.class),
					 v.frame.origin.x,  v.frame.origin.y,  v.frame.size.width,  v.frame.size.height,
					 v.bounds.origin.x, v.bounds.origin.y, v.bounds.size.width, v.bounds.size.height
					 ];
	}
	
	CGAffineTransform ctm = CGContextGetCTM(UIGraphicsGetCurrentContext());
	
	self.text = [self.text stringByAppendingFormat:
				 @"\nCTM %5g%5g%5g\n"
				 @"    %5g%5g%5g\n"
				 @"    %5g%5g%5g",
				 ctm.a,  ctm.b,  0.0,
				 ctm.c,  ctm.d,  0.0,
				 ctm.tx, ctm.ty, 1.0
				 ];
	 */
}


@end
