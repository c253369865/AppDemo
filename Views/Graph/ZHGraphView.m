//
//  ZHGraphView.m
//  AppDemo
//
//  Created by TerryChao on 16/8/16.
//  Copyright © 2016年 czh. All rights reserved.
//

#import "ZHGraphView.h"


#pragma mark Quartz Helpers

// Functions used to draw all content

CGColorRef CreateDeviceGrayColor(CGFloat w, CGFloat a)
{
    CGColorSpaceRef gray = CGColorSpaceCreateDeviceGray();
    CGFloat comps[] = {w, a};
    CGColorRef color = CGColorCreate(gray, comps);
    CGColorSpaceRelease(gray);
    return color;
}

CGColorRef CreateDeviceRGBColor(CGFloat r, CGFloat g, CGFloat b, CGFloat a)
{
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat comps[] = {r, g, b, a};
    CGColorRef color = CGColorCreate(rgb, comps);
    CGColorSpaceRelease(rgb);
    return color;
}

CGColorRef graphBackgroundColor()
{
    static CGColorRef c = NULL;
    if (c == NULL)
    {
        c = CreateDeviceGrayColor(0.6, 1.0);
    }
    return c;
}

CGColorRef graphLineColor()
{
    static CGColorRef c = NULL;
    if (c == NULL)
    {
        c = CreateDeviceGrayColor(0.5, 1.0);
    }
    return c;
}

CGColorRef graphXColor()
{
    static CGColorRef c = NULL;
    if (c == NULL)
    {
        c = CreateDeviceRGBColor(1.0, 0.0, 0.0, 1.0);
    }
    return c;
}

CGColorRef graphYColor()
{
    static CGColorRef c = NULL;
    if (c == NULL)
    {
        c = CreateDeviceRGBColor(0.0, 1.0, 0.0, 1.0);
    }
    return c;
}

CGColorRef graphZColor()
{
    static CGColorRef c = NULL;
    if (c == NULL)
    {
        c = CreateDeviceRGBColor(0.0, 0.0, 1.0, 1.0);
    }
    return c;
}

void DrawGridlines(CGContextRef context, CGFloat x, CGFloat width)
{
    for (CGFloat y = -48.5; y <= 48.5; y += 16.0)
    {
        CGContextMoveToPoint(context, x, y);
        CGContextAddLineToPoint(context, x + width, y);
    }
    CGContextSetStrokeColorWithColor(context, graphLineColor());
    CGContextStrokePath(context);
}









#pragma mark -

// The GraphViewSegment manages up to 32 accelerometer values and a CALayer that it updates with
// the segment of the graph that those values represent.

@interface GraphViewSegment : NSObject
{
    // Need 33 values to fill 32 pixel width.
    UIAccelerationValue xhistory[33];
    UIAccelerationValue yhistory[33];
    UIAccelerationValue zhistory[33];
    int index;
}

// returns true if adding this value fills the segment, which is necessary for properly updating the segments
- (BOOL)addX:(UIAccelerationValue)x y:(UIAccelerationValue)y z:(UIAccelerationValue)z;

// When this object gets recycled (when it falls off the end of the graph)
// -reset is sent to clear values and prepare for reuse.
- (void)reset;

// Returns true if this segment has consumed 32 values.
- (BOOL)isFull;

// Returns true if the layer for this segment is visible in the given rect.
- (BOOL)isVisibleInRect:(CGRect)r;

// The layer that this segment is drawing into
@property(nonatomic, readonly) CALayer *layer;

@end


#pragma mark -

@interface GraphViewSegment () <CALayerDelegate>

@end

@implementation GraphViewSegment

@synthesize layer;

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        layer = [[CALayer alloc] init];
        // the layer will call our -drawLayer:inContext: method to provide content
        // and our -actionForLayer:forKey: for implicit animations
        layer.delegate = self;
        // This sets our coordinate system such that it has an origin of 0.0,-56 and a size of 32,112.
        // This would need to be changed if you change either the number of pixel values that a segment
        // represented, or if you changed the size of the graph view.
        layer.bounds = CGRectMake(0.0, -56.0, 32.0, 112.0);
        // Disable blending as this layer consists of non-transperant content.
        // Unlike UIView, a CALayer defaults to opaque=NO
        layer.opaque = YES;
        // Index represents how many slots are left to be filled in the graph,
        // which is also +1 compared to the array index that a new entry will be added
        index = 33;
    }
    return self;
}

- (void)reset
{
    // Clear out our components and reset the index to 33 to start filling values again...
    memset(xhistory, 0, sizeof(xhistory));
    memset(yhistory, 0, sizeof(yhistory));
    memset(zhistory, 0, sizeof(zhistory));
    index = 33;
    // Inform Core Animation that we need to redraw this layer.
    [layer setNeedsDisplay];
}

- (BOOL)isFull
{
    // Simple, this segment is full if there are no more space in the history.
    return index == 0;
}

- (BOOL)isVisibleInRect:(CGRect)r
{
    // Just check if there is an intersection between the layer's frame and the given rect.
    return CGRectIntersectsRect(r, layer.frame);
}

- (BOOL)addX:(UIAccelerationValue)x y:(UIAccelerationValue)y z:(UIAccelerationValue)z
{
    // If this segment is not full, then we add a new acceleration value to the history.
    if (index > 0)
    {
        // First decrement, both to get to a zero-based index and to flag one fewer position left
        --index;
        xhistory[index] = x;
        yhistory[index] = y;
        zhistory[index] = z;
        // And inform Core Animation to redraw the layer.
        [layer setNeedsDisplay];
    }
    // And return if we are now full or not (really just avoids needing to call isFull after adding a value).
    return index == 0;
}

- (void)drawLayer:(CALayer*)l inContext:(CGContextRef)context
{
    // Fill in the background
    CGContextSetFillColorWithColor(context, graphBackgroundColor());
    CGContextFillRect(context, layer.bounds);
    
    // Draw the grid lines
    DrawGridlines(context, 0.0, 32.0);
    
    // Draw the graph
    CGPoint lines[64];
    int i;
    
    // X
    for (i = 0; i < 32; ++i)
    {
        lines[i*2].x = i;
        lines[i*2].y = -xhistory[i] * 16.0;
        lines[i*2+1].x = i + 1;
        lines[i*2+1].y = -xhistory[i+1] * 16.0;
    }
    CGContextSetStrokeColorWithColor(context, graphXColor());
    CGContextStrokeLineSegments(context, lines, 64);
    
    // Y
    for (i = 0; i < 32; ++i)
    {
        lines[i*2].y = -yhistory[i] * 16.0;
        lines[i*2+1].y = -yhistory[i+1] * 16.0;
    }
    CGContextSetStrokeColorWithColor(context, graphYColor());
    CGContextStrokeLineSegments(context, lines, 64);
    
    // Z
    for (i = 0; i < 32; ++i)
    {
        lines[i*2].y = -zhistory[i] * 16.0;
        lines[i*2+1].y = -zhistory[i+1] * 16.0;
    }
    CGContextSetStrokeColorWithColor(context, graphZColor());
    CGContextStrokeLineSegments(context, lines, 64);
}

- (id)actionForLayer:(CALayer *)layer forKey :(NSString *)key
{
    // We disable all actions for the layer, so no content cross fades, no implicit animation on moves, etc.
    return [NSNull null];
}

// The accessibilityValue of this segment should be the x,y,z values last added.
- (NSString *)accessibilityValue
{
    return [NSString stringWithFormat:NSLocalizedString(@"graphSegmentFormat", @""), xhistory[index], yhistory[index], zhistory[index]];
}

@end


#pragma mark -

// We use a seperate view to draw the text for the graph so that we can layer the segment layers below it
// which gives the illusion that the numbers are draw over the graph, and hides the fact that the graph drawing
// for each segment is incomplete until the segment is filled.

@interface GraphTextView : UIView
@end


#pragma mark -

@implementation GraphTextView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Fill in the background
    CGContextSetFillColorWithColor(context, graphBackgroundColor());
    CGContextFillRect(context, self.bounds);
    
    CGContextTranslateCTM(context, 0.0, 56.0);
    
    // Draw the grid lines
    DrawGridlines(context, 26.0, 6.0);
    
    // Draw the text
//    UIFont *systemFont = [UIFont systemFontOfSize:12.0];
//    [[UIColor whiteColor] set];
//    [@"+3.0" drawInRect:CGRectMake(2.0, -56.0, 24.0, 16.0) withFont:systemFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
//    [@"+2.0" drawInRect:CGRectMake(2.0, -40.0, 24.0, 16.0) withFont:systemFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
//    [@"+1.0" drawInRect:CGRectMake(2.0, -24.0, 24.0, 16.0) withFont:systemFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
//    [@" 0.0" drawInRect:CGRectMake(2.0,  -8.0, 24.0, 16.0) withFont:systemFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
//    [@"-1.0" drawInRect:CGRectMake(2.0,   8.0, 24.0, 16.0) withFont:systemFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
//    [@"-2.0" drawInRect:CGRectMake(2.0,  24.0, 24.0, 16.0) withFont:systemFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
//    [@"-3.0" drawInRect:CGRectMake(2.0,  40.0, 24.0, 16.0) withFont:systemFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
}

@end










#pragma mark - ZHGraphView

@interface ZHGraphView()

// Internal accessors
@property (nonatomic, strong) NSMutableArray *segments;
@property (nonatomic, unsafe_unretained) GraphViewSegment *current;
@property (nonatomic) GraphTextView *text;

// A common init routine for use with -initWithFrame: and -initWithCoder:
- (void)commonInit;

// Creates a new segment, adds it to 'segments', and returns a weak reference to that segment
// Typically a graph will have around a dozen segments, but this depends on the width of the graph view and segments
- (GraphViewSegment *)addSegment;

// Recycles a segment from 'segments' into  'current'
- (void)recycleSegment;

@end

@implementation ZHGraphView


//••@synthesize segments, current, text;

// Designated initializer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        [self commonInit];
    }
    return self;
}

// Designated initializer
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self != nil)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    // Create the text view and add it as a subview. We keep a weak reference
    // to that view afterwards for laying out the segment layers.
    _text = [[GraphTextView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0, 112.0)];
    [self addSubview:self.text];
    
    // Create a mutable array to store segments, which is required by -addSegment
    _segments = [[NSMutableArray alloc] init];
    
    // Create a new current segment, which is required by -addX:y:z and other methods.
    // This is also a weak reference (we assume that the 'segments' array will keep the strong reference).
    self.current = [self addSegment];
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Fill in the background
    CGContextSetFillColorWithColor(context, graphBackgroundColor());
    CGContextFillRect(context, self.bounds);
    
    CGFloat width = self.bounds.size.width;
    CGContextTranslateCTM(context, 0.0, 56.0);
    DrawGridlines(context, 0.0, width);
}

- (void)addX:(UIAccelerationValue)x y:(UIAccelerationValue)y z:(UIAccelerationValue)z
{
    // First, add the new acceleration value to the current segment
    if ([self.current addX:x y:y z:z])
    {
        // If after doing that we've filled up the current segment, then we need to
        // determine the next current segment
        [self recycleSegment];
        // And to keep the graph looking continuous, we add the acceleration value to the new segment as well.
        [self.current addX:x y:y z:z];
    }
    // After adding a new data point, we need to advance the x-position of all the segment layers by 1 to
    // create the illusion that the graph is advancing.
    for (GraphViewSegment *s in self.segments)
    {
        CGPoint position = s.layer.position;
        position.x += 1.0;
        s.layer.position = position;
    }
}

#define kSegmentInitialPosition CGPointMake(14.0, 56.0);

- (GraphViewSegment *)addSegment
{
    // Create a new segment and add it to the segments array.
    GraphViewSegment *segment = [[GraphViewSegment alloc] init];
    // We add it at the front of the array because -recycleSegment expects the oldest segment
    // to be at the end of the array. As long as we always insert the youngest segment at the front
    // this will be true.
    [self.segments insertObject:segment atIndex:0];
    // this is now a weak reference
    
    // Ensure that newly added segment layers are placed after the text view's layer so that the text view
    // always renders above the segment layer.
    [self.layer insertSublayer:segment.layer below:self.text.layer];
    // Position it properly (see the comment for kSegmentInitialPosition)
    segment.layer.position = kSegmentInitialPosition;
    
    return segment;
}

- (void)recycleSegment
{
    // We start with the last object in the segments array, as it should either be visible onscreen,
    // which indicates that we need more segments, or pushed offscreen which makes it eligable for recycling.
    GraphViewSegment *last = [self.segments lastObject];
    if ([last isVisibleInRect:self.layer.bounds])
    {
        // The last segment is still visible, so create a new segment, which is now the current segment
        self.current = [self addSegment];
    }
    else
    {
        // The last segment is no longer visible, so we reset it in preperation to be recycled.
        [last reset];
        // Position it properly (see the comment for kSegmentInitialPosition)
        last.layer.position = kSegmentInitialPosition;
        // Move the segment from the last position in the array to the first position in the array
        // as it is now the youngest segment.
        [self.segments insertObject:last atIndex:0];
        [self.segments removeLastObject];
        // And make it our current segment
        self.current = last;
    }
}

// Return an up-to-date value for the graph.
- (NSString *)accessibilityValue
{
    if (self.segments.count == 0)
    {
        return nil;
    }
    
    // Let the GraphViewSegment handle its own accessibilityValue;
    GraphViewSegment *graphViewSegment = self.segments[0];
    return [graphViewSegment accessibilityValue];
}


@end
