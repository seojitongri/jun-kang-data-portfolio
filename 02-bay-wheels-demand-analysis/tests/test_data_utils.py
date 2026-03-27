import pandas as pd
import pytest
from src.data_utils import load_weather_data, save_daily_stats

def test_save_daily_stats(tmp_path):
    df = pd.DataFrame({"x": [1, 2]})
    out = tmp_path / "daily.csv"
    p = save_daily_stats(df, out)
    assert p.exists()

def test_load_weather_data_missing(tmp_path):
    with pytest.raises(FileNotFoundError):
        load_weather_data(tmp_path / "missing.csv")
