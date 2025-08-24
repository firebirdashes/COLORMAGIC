# COLORMAGIC



hey, so this effect only works at runtime, as it relies on an autoload

theoraticaly it could be done in the editor, but this is a cut down version of an implementation done for another project, and i tried to keep it as close as possible to how it was implememnted in there



### this is a godot 4.4 effect, though it should work in later versions, dont quote me on that

### 

### USE: allows for per object screen based effects, in the example it is done via a grayscale shader, however, any effect should be possible





CONTROLS:

wasd - move

space - jump

1 - enable debug rendering

2 - disable grayscale effect

3 - disable color layer



description of filter



the filter consists of

3 viewports

4 cameras

and some color-rectangles in the ui





3 viewports

COLORPASS

COLORDEPTH

MAINDEPTH



each have a camera each, and are all set up to follow the main camera (placed in the scene) at the same rotation, angle and FOV



the MainCAMERA only renders objects on render layer 1 and 2, this is to allow for proper shadows on from layer 2 objects



COLORPASS and it's camera only draw objects on layer 2, which is all objects that i will denote as "COLOR EXEMPT"



COLORDEPTH draws render layers 2 and 3

and MAINDEPTH only draws layers 1 and 3



layer 3 has a quad locked to the camera, that draws the depth texture





in the ui, the render order is as follows (from first to last)



MAIN PASS (this is the output from the whatever camera is marked as "current" in engine

GRAY FILTER (a grayscale filter, a more complex one is used in my own project, but its not important right now)

COLOR TEXTURE (a color rect, with the shader depth cull attached)

... \[rest of ui as needed]





UI manager:

the ui manager just gets the outputs from the 3 viewports, and passes them into COLOR TEXTURE as shader parameters



COLOR TEXTURE:

colortexture has a shader on it,

DEPTH CULL

depthcull takes in

the output of the color pass viewport, and the output's of the 2 depth pass viewports

in the fragment shader, it sets the albedo to the output of COLORPASS at that pixel



it compairs the two depth passes, and if the depth of the main viewport is less than or equal to the depth of the color viewport (in this pixel, the closest object to the camera is NOT on render layer 2), then the alpha value is set to 0,

(this prevents objects in the color pass from always drawing over objects in the main pass

# 

# 

