# RU Airborne Airfoil Analysis Tool - An XFoil Wrapper
## Dependencies
### XFoil
XFoil 6.99 (the `xfoil.exe`, `pplot.exe`, and `pxplot.exe`) and are in the same directory as `xfoil.m`. This XFoil download comes built in to this download in the correct location.

### XFoil MATLAB Wrapper
This requires that MATLAB > v.2014b is installed.

This uses [this XFoil MATLAB wrapper written by Louis Edelman](https://www.mathworks.com/matlabcentral/fileexchange/49706-xfoil-interface-updated). It is already in the directory when you clone it.

### Python Airfoil Download Script
If you want to use the airfoil downloader, you will need to have Python installed. You can install Python [here](https://www.python.org/downloads/). You will probably need to add Python to PATH; this is shown [here](https://datatofish.com/add-python-to-windows-path/). Make sure that Python is added to PATH by typing `python` or `python3` in a command window. 

You will need the following libraries:
- numpy
- pandas

Both can be installed by typing the following in a command window:
    
    pip install numpy
    pip install pandas

## Installation
Clone this git repository if you know how to use git and want to contribute.

If not, go to the green "Code" dropdown, and download it as zip. Extract the zip to a directory of your choice, and now you can use it.