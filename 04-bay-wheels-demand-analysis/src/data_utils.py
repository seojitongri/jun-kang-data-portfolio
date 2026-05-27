import pandas as pd
from pathlib import Path

def load_weather_data(path: str | Path) -> pd.DataFrame:
    """
    Load weather dataset used in analysis.

    Parameters
    ----------
    path : str or Path
        Path to weather csv file.

    Returns
    -------
    pd.DataFrame
        Weather dataframe.
    """
    path = Path(path)
    if not path.exists():
        raise FileNotFoundError(f"Missing file: {path}")
    return pd.read_csv(path)


def save_daily_stats(df: pd.DataFrame, out_path: str | Path) -> Path:
    """
    Save daily statistics table to disk.

    Parameters
    ----------
    df : pd.DataFrame
        Daily statistics dataframe.
    out_path : str or Path
        Output csv path.

    Returns
    -------
    Path
        Path written to disk.
    """
    out_path = Path(out_path)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(out_path, index=False)
    return out_path
