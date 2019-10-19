#include <fmt/format.h>

#include "example.hpp"

#ifndef NDEBUG
constexpr auto build_type = "debug";
#else
constexpr auto build_type = "release";
#endif

struct Base {
   virtual void reimplementMe(int a) {}
};
struct Derived : public Base  {
   virtual void reimplementMe(int a) {}
};

auto main() -> int
{
  const int current_year{2019};

  fmt::print("Test: {}\nBuild type: {}\n",
             my_app::year_to_century(current_year),
             build_type);
}
