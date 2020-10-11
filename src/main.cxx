#include <fmt/format.h>

#include "example.hpp"

#ifndef NDEBUG
constexpr auto build_type = "debug";
#else
constexpr auto build_type = "release";
#endif

auto main() -> int
{
  const int current_year{2020};

  fmt::print("Test: {}\nBuild type: {}\n",
             my_app::year_to_century(current_year),
             build_type);
}
