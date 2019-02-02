#include <catch2/catch.hpp>

TEST_CASE("sanity check")
{
	REQUIRE(1 == 1);
}

int year_to_century(int year) {
	return (year + 99) / 100;
}

TEST_CASE("example")
{
	REQUIRE(year_to_century(1905) == 20);
	REQUIRE(year_to_century(1700) == 17);
	REQUIRE(year_to_century(1988) == 20);
	REQUIRE(year_to_century(2000) == 20);
	REQUIRE(year_to_century(2001) == 21);
	REQUIRE(year_to_century(200)  == 2);
	REQUIRE(year_to_century(374)  == 4);
	REQUIRE(year_to_century(45)   == 1);
	REQUIRE(year_to_century(8)    == 1);
	REQUIRE(year_to_century(1) 	  == 1);
	REQUIRE(year_to_century(0)    == 0);
}