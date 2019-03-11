[![Generic badge](https://img.shields.io/badge/build-passing-<COLOR>.svg)](https://shields.io/)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

# Image Morphing

Image Morphing is a MATLAB script designed to take to different images and compute the warping path between them.

## Description

Image Morphing is a MATLAB script designed to take in as input two different images and compute the frames between them. After the user specifies which two images to process, he or she is asked to plot several reference points on both images. These points serve as anchors so as to compute the smoothest warping possible. The result is a 60 frame animation playing out over 1 second which illustrates the warping between the two images.

## Instructions

### Download

Clone or download the repository above.

### Usage

Choose two images from your library of which you would like to see the warping path. Place both your starting image and your end image in your project directory and name them 'start_image.jpg' and 'end_image.jpg' respectively.

![Directory Image](res/tracer_images/directory.png?raw=true "Image that shows directory screen")

After the images have been placed in the directory and correctly named, run the script in your MATLAB window. You will then be prompted to place your anchor points for each image.

![Sequence gif](res/tracer_images/anchor.gif?raw=true "Animation that shows a user selecting anchor points")

Place at least four reference points and close the window when you are satisfied with your anchors.

### Results

The warping path is processed and displayed on-screen. The animation repeats until the user opts to close the display window.

![Warping gif](res/tracer_images/warping_bronut.gif?raw=true "Animation that shows broccoli morphing into a donut")

## Author

**Danny Tryon** - [tryond](https://github.com/tryond?tab=repositories)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

