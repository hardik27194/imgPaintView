imgPaintView
============

ImagePaintView

Image PaintView is an image manipulation view with paint and erase mode. Paint mode will redraw the portion of the image that
is cut off from the erase mode. This is a requirement for some of the applications which require overlaying and drawing of 
certain pattern images.

I made it open because I have struggled a lot for this to happen. 


Integration

==========
Simply add PaintImageView.h and .m to your class. Init with Image and set frame. There is one more line of code to adjustFrame
.

Rest all is taken care by the view.
This currently works only for square images (width ==  height).
