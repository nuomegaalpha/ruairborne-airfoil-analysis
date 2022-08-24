import os
from ruairborne_airfoil_analysis import get_airfoil


def main() -> None:
    CWD = os.getcwd()
    foils = ["naca0008", "nacam2", "nacam3"]
    save_dir = os.path.join(CWD, "airfoils")
    for foil in foils:
        foil = foil.lower()
        data = get_airfoil(foil,
                           database="airfoil_tools",
                           save_dir=save_dir,
                           save_file=True)


if __name__ == "__main__":
    main()
