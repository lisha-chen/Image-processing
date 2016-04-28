# Image-Thresholding
convert color image or gray image to binary image

Introduction.

Image Thresholding methods based on papers written in matlab.

References.

If you use the Toolbox, we appreciate it if you cite an appropriate subset of the following papers:

J. M. S. Prewitt and M. L. Mendelsohn, "The analysis of cell images," innnals of the New York Academy of Sciences, vol. 128, pp. 1035-1053, 1966.

C. A. Glasbey, "An analysis of histogram-based thresholding algorithms," CVGIP: Graphical Models and Image Processing, vol. 55, pp. 532-537, 1993.

W. Tsai, “Moment-preserving thresholding: a new approach,” Comput.Vision Graphics Image Process., vol. 29, pp. 377-393, 1985.

Kittler, J & Illingworth, J (1986), "Minimum error thresholding", Pattern Recognition 19: 41-47

Ridler, TW & Calvard, S (1978), "Picture thresholding using an iterative selection method", IEEE Transactions on Systems, Man and Cybernetics 8: 630-632

Shanbhag, Abhijit G. (1994), "Utilization of information measure as a means of image thresholding", Graph. Models Image Process. (Academic Press, Inc.) 56 (5): 414--419, ISSN 1049-9652, DOI 10.1006/cgip.1994.1037

Yen J.C., Chang F.J., and Chang S. (1995) "A New Criterion  for Automatic Multilevel Thresholding" IEEE Trans. on Image  Processing, 4(3): 370-378

Sezgin M. and Sankur B. (2004) "Survey over Image Thresholding Techniques and Quantitative Performance Evaluation" Journal of  Electronic Imaging, 13(1): 146-165



Usage.

 The main function is im2binary.
 
The first parameter is the input image.

The last parameter is the method you choose.

All methods except for P_Tile have 2 parameters.

P_Tile requires an additional P which ranges from 0 to 1 
to determine the percent of foreground pixels and background pixels.

example:

output=im2binary(I,0.5,'P_Tile');

output=im2binary(I,'momentPreserving');

###################################################################
