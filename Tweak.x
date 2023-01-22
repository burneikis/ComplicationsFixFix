#import <UIKit/UIKit.h>

@interface ComplicationsView : UIView

@end

%hook ComplicationsView

- (void)setFrame:(CGRect)frame {
	%orig;

	NSDictionary *defaults = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.bengiannis.complicationsprefs"];
	NSNumber *yOffset = [defaults objectForKey:@"yOffset"];

	UIStackView *stackView = nil;
	CGFloat height = 0;
	for (UIView *view in self.superview.subviews) {
		if ([view isKindOfClass:NSClassFromString(@"UIStackView")]) {
			stackView = (UIStackView *)view;
			break;
		}
	}

	height = stackView.frame.size.height - 50;

	CGFloat complicationCenterHeight = -45 + [yOffset floatValue] - height;

	// Change complication center height to accomodate the new height
	self.center = CGPointMake(self.center.x, complicationCenterHeight);
}

%end
