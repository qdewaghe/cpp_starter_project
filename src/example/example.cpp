#include "example.hpp"

auto example::year_to_century(int year) -> int
{
  if (year <= 0)
  {
    return 0;
  }

  int years_per_century = 100;
  int round_up          = 100 - 1;

  return (year + round_up) / years_per_century;
}
