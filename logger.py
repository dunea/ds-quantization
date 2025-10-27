import sys
from typing import Literal

from loguru import logger as _logger

_LEVELS = Literal["TRACE", "DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"]
_LOG_LEVEL: _LEVELS = "INFO"


def set_log_level(level: _LEVELS):
    global _LOG_LEVEL
    _LOG_LEVEL = level


def _filter(r):
    return r["level"].no >= _logger.level(_LOG_LEVEL).no


_logger.remove()
_logger.add(sys.stderr, filter=_filter)
logger = _logger
