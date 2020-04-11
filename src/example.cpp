#include "example.hpp"

auto my_app::year_to_century(int const year) -> int
{
  if (year <= 0)
  {
    return 0;
  }

  int const years_in_century = 100;
  int const round_up         = 100 - 1;

  return (year + round_up) / years_in_century;
}
