from __future__ import annotations
import pandas as pd
import numpy as np
import os
import pathlib
from typing import Union

SELIG_URL_DIR = "https://m-selig.ae.illinois.edu/ads/coord/"
AIRFOIL_TOOLS_URL_DIR = "http://airfoiltools.com/airfoil/seligdatfile?airfoil="


def get_airfoil(airfoil_name: str, database: str = "airfoil_tools", save_file: bool = False, save_dir: Union[None, str, pathlib.Path] = None) -> Union[np.ndarray, None]:
    """
    Reads an airfoil (IN SELIG FORMAT) from:
        Selig UIUC airfoil database, located at `SELIG_URL_DIR`
        Airfoil tools database, located at `AIRFOIL_TOOLS_URL_DIR` (default) 

    Arguments:
        `airfoil_name: str`: Airfoil name, can contain .dat, but does not have to
        `database: str`: Database to read from. Can either be "airfoil_tools" or "uiuc", defaults to "airfoil_tools" 
        `save_dir: Union[str, pathlib.Path, None] = None`: A directory to save data to (as CSV) (defaults to `None`)
        `save_file: bool = False`: Whether `airfoil_array` should be saved as a CSV to `save_dir`
    Output:
        `airfoil_array` (N X 2) [`np.ndarray`]: Airfoil coordinates in (x,y) pairs

    Usage:
    >>> airfoil_array = get_airfoil('e220.dat', save_file = False, save_dir = None)
    >>> airfoil_array = get_airfoil('e220', save_file = True, save_dir = 'C:\\Users\\noahm\\Documents\\Rutgers\\RU Airborne\\2022-2023\\airfoil-analysis\\airfoils')

    """
    
    database = database.lower()
    
    if database == "airfoil_tools":
        if ".dat" in airfoil_name:
            name = airfoil_name.split(".dat")[0]
        else:
            name = airfoil_name
        url = AIRFOIL_TOOLS_URL_DIR + name + "-il"
    elif database == "uiuc":
        if ".dat" in airfoil_name:
            url = SELIG_URL_DIR + airfoil_name
            name = airfoil_name.split(".dat")[0]
        else:
            url = SELIG_URL_DIR + airfoil_name + ".dat"
            name = airfoil_name
    else:
        raise RuntimeError("Arg database must be either 'uiuc' or 'airfoil_tools' (case insensitive)")
    
    try:
        data = pd.read_csv(url)
        print(f"Downloaded {name}!")
        airfoil_array = []
        for i, row in data.iterrows():
            airfoil_array.append(np.fromstring(row[0], sep=" "))
        airfoil_array = np.array(airfoil_array)

        # save the file
        if save_file and save_dir is not None:
            csv_path = os.path.join(save_dir, name + ".csv")
            np.savetxt(csv_path, airfoil_array, delimiter=",")
            print(f"Saved airfoil {name}!")
        elif save_file and save_dir is None:
            print(f"Cannot save file because save_dir argument is None")

        return airfoil_array
    except Exception:
        print(f"Unable to open {url}. Make sure that the airfoil exists.")
