#include "example.hpp"

auto my_app::year_to_century(int const year) -> int
{
  if (year <= 0)
  {
    return 0;
  }

  int const years_per_century = 100;
<<<<<<< HEAD
  int const round_up         = 100 - 1;
=======
  int const round_up          = 100 - 1;
>>>>>>> 6bc98a429915c16f90358e8f6bf58ebd6f9dc2e7

  return (year + round_up) / years_per_century;  
}
