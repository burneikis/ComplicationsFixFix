#import <UIKit/UIKit.h>

@interface ComplicationsView : UIView

@end

%hook ComplicationsView

- (void)setFrame:(CGRect)frame {
	%orig;

	// Get the y offset from the preferences of the original tweak
	NSDictionary *defaults = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.bengiannis.complicationsprefs"];
	NSNumber *yOffset = [defaults objectForKey:@"yOffset"];

	// Get the height of the sibling UIStackView
	UIStackView *stackView = nil;
	CGFloat height = 0;
	for (UIView *view in self.superview.subviews) {
		if ([view isKindOfClass:NSClassFromString(@"UIStackView")]) {
			stackView = (UIStackView *)view;
			break;
		}
	}
	height = stackView.frame.size.height - 50;

	// Change the y position of the complication view center
	CGFloat complicationCenterY = -45 + [yOffset floatValue] - height;
	self.center = CGPointMake(self.center.x, complicationCenterY);
}

%end
