//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the organisation (joind.in) nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "NewCommentViewCell.h"


@implementation NewCommentViewCell

@synthesize uiSubmit;
@synthesize uiComment;
@synthesize uiActivity;
@synthesize commentDelegate;
@synthesize uiRating1;
@synthesize uiRating2;
@synthesize uiRating3;
@synthesize uiRating4;
@synthesize uiRating5;
@synthesize rating;

- (IBAction) uiSubmitted:(id)sender {
    if (self.rating == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:(NSString *)@"Please choose a rating"
                                              delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else if ([self.uiComment.text isEqualToString:@"Type comment..."] || [self.uiComment.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:(NSString *)@"Please type a comment"
                                                       delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.uiComment becomeFirstResponder];
        [alert show];
        [alert release];
    } else {
        self.uiSubmit.hidden = YES;
        [self.commentDelegate submitComment:self.uiComment.text activityIndicator:self.uiActivity rating:self.rating];
    }
}

- (IBAction) uiRatingPressed:(id)sender {
    if (self.uiRating1.state == UIControlStateHighlighted) {
        self.rating = 1;
    }
    if (self.uiRating2.state == UIControlStateHighlighted) {
        self.rating = 2;
    }
    if (self.uiRating3.state == UIControlStateHighlighted) {
        self.rating = 3;
    }
    if (self.uiRating4.state == UIControlStateHighlighted) {
        self.rating = 4;
    }
    if (self.uiRating5.state == UIControlStateHighlighted) {
        self.rating = 5;
    }

    [self setRatingImageState: (int)self.rating];
}

// Poor-man's initialiser
- (void) doStuff {
    self.rating = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textGotFocus:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self.uiComment];
}

- (void) textGotFocus:(NSNotification*)notification {
    if ([self.uiComment.text isEqualToString:@"Type comment..."]) {
        self.uiComment.text = @"";
    }
}

- (void) reset {
    [self.uiActivity stopAnimating];
    self.uiSubmit.hidden = NO;
    self.uiComment.text = @"";
    self.rating = 0;
    [self setRatingImageState: (int)self.rating];
}

- (void) setRatingImageState:(int)ratingValue {
    NSString *off = @"rating-off.gif";
    NSString *on = @"rating-on.gif";

    [self.uiRating1 setImage:[UIImage imageNamed:(ratingValue > 0 ? on : off)] forState:UIControlStateNormal];
    [self.uiRating2 setImage:[UIImage imageNamed:(ratingValue > 1 ? on : off)] forState:UIControlStateNormal];
    [self.uiRating3 setImage:[UIImage imageNamed:(ratingValue > 2 ? on : off)] forState:UIControlStateNormal];
    [self.uiRating4 setImage:[UIImage imageNamed:(ratingValue > 3 ? on : off)] forState:UIControlStateNormal];
    [self.uiRating5 setImage:[UIImage imageNamed:(ratingValue > 4 ? on : off)] forState:UIControlStateNormal];
}

@end
