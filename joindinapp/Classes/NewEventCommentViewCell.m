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

#import "NewEventCommentViewCell.h"


@implementation NewEventCommentViewCell
@synthesize uiSubmit;
@synthesize uiComment;
@synthesize uiActivity;
@synthesize EventCommentDelegate;

- (IBAction) uiSubmitted:(id)sender {
    self.uiSubmit.hidden = YES;
    [self.EventCommentDelegate submitComment:self.uiComment.text activityIndicator:self.uiActivity];
}

// Poor-man's initialiser
- (void) doStuff {
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
}

@end
