#include <boost/asio.hpp>
#include <fmt/format.h>
#include <iostream>
#include <optional>

auto main() -> int
{
   // makes sure boost is properly linked
   boost::asio::io_context     io;
   boost::asio::deadline_timer t(io, boost::posix_time::microseconds(1));

   t.wait();

   std::cout << fmt::format("{}\n", "Hello, World!");

#ifdef DEBUG
   std::cout << "debug" << std::endl;
#endif

#ifdef NDEBUG
   std::cout << "release" << std::endl;
#endif
}
