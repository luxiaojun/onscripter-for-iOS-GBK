//
//  SDL_uikitmoviedelegate.m
//  SDLiPhoneOS
//
//  Created by  yc on 11-1-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SDL_uikitmoviedelegate.h"



@implementation SDL_uikitmoviedelegate


@synthesize moviePlayer;
@synthesize window;

-(void)initAndPlayMovie:(NSURL *)movieURL :(SDL_Window *)sdl_window
{
	SDL_WindowData* sdlw;
	sdlw=(SDL_WindowData*)sdl_window->driverdata;
	window=sdlw->uiwindow;
	if (!window) {
		NSLog(@"window alloc error!");
		return ;
	}
	MPMoviePlayerController *mp = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
	if (mp)
	{
		self.moviePlayer = mp;
		[mp release];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(moviePlayBackDidFinish:)
													 name:MPMoviePlaybackStateStopped
												   object:moviePlayer];
                      
	//	self.moviePlayer.view.transform = CGAffineTransformMakeRotation(M_PI/2);
		 moviePlayer.view.frame = CGRectMake(-80, 80, 480.0, 320.0);
	//	moviePlayer.view.frame = CGRectMake(0, 0, 480.0, 320.0);
		 window.transform = CGAffineTransformMakeRotation(M_PI/2);
		
		
	//	moviePlayer.view.transform =  CGAffineTransformMakeRotation(M_PI/2);
		 [window addSubview:moviePlayer.view];
		
		 if([self.moviePlayer respondsToSelector:@selector(setFullscreen:animated:)]){
			 self.moviePlayer.controlStyle = MPMovieControlStyleNone;
			 self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
			 self.moviePlayer.shouldAutoplay = YES;

			 
			
			
			 [moviePlayer setFullscreen:NO animated:NO];
	}
		else {
			[self.moviePlayer play];
		}
	}

}
-(void) moviePlayBackDidFinish:(NSNotification*)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerPlaybackDidFinishNotification
												  object:moviePlayer];
	if([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)]){
		
	//	[moviePlayer.view dismissMoviePlayerViewControllerAnimated];
		[moviePlayer.view removeFromSuperview];
		window.transform =CGAffineTransformMakeRotation(0);
	}
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { 
	return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
			(interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}

-(void)dealloc {

	
	[moviePlayer release];
	[super dealloc];
	 }

@end
