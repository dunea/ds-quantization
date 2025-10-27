import os
from typing import Optional

from pydantic.v1 import Field
from pydantic_settings import BaseSettings

use_secret = True
use_secret_env = os.getenv("USE_SECRET")
if use_secret_env and use_secret_env.lower() == "false":
    use_secret = False


class Settings(BaseSettings):
    # deepseek
    DEEPSEEK_API_KEY: str = Field(..., env="DEEPSEEK_API_KEY")

    # 币安
    BINANCE_API_KEY: Optional[str] = os.getenv("BINANCE_API_KEY")
    BINANCE_SECRET: Optional[str] = os.getenv("BINANCE_SECRET")

    # 欧易
    OKX_API_KEY: Optional[str] = os.getenv("OKX_API_KEY")
    OKX_SECRET: Optional[str] = os.getenv("OKX_SECRET")
    OKX_PASSWORD: Optional[str] = os.getenv("OKX_PASSWORD")

    # 交易参数
    SYMBOL: str = Field(..., env="SYMBOL")  # 合约符号
    AMOUNT: int = Field(..., env="AMOUNT")  # 交易数量
    LEVERAGE: int = Field(..., env="LEVERAGE")  # 杠杆倍数

    class Config:
        env_file = ".env"  # 指定 .env 文件路径
        env_file_encoding = 'utf-8'


settings = Settings()
