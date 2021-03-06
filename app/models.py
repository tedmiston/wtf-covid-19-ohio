from dataclasses import dataclass


@dataclass
class Metric:
    """A metric."""

    label: str
    value: str

    def __str__(self) -> str:
        return f"{self.value.rjust(7)}  {self.label}"
