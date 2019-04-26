#include <iostream>
#include <fmt/format.h>
#include <boost/asio.hpp>

auto main() -> int
{
   boost::asio::io_context io;
   boost::asio::deadline_timer t(io, boost::posix_time::microseconds(1));
   
   t.wait();
   
   std::cout << fmt::format("{}", "test1");
}


