#include <iostream>
#include <vector>

#include "example/example.hpp"
#include "fmt/format.h"

auto main() -> int
{
  const auto current_year{2021};

  fmt::print("current year: {}\ncurrent century: {}\n",
             current_year,
             example::year_to_century(current_year));
}
