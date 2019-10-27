#include <fmt/format.h>

#include "example.hpp"

#include "clang/Frontend/FrontendActions.h"
#include "clang/Tooling/CommonOptionsParser.h"
#include "clang/Tooling/Tooling.h"
#include "llvm/Support/CommandLine.h"

#ifndef NDEBUG
constexpr auto build_type = "debug";
#else
constexpr auto build_type = "release";
#endif

static llvm::cl::OptionCategory MyToolCategory("my-tool options");

auto main(int argc, const char** argv) -> int
{
  const int current_year{2019};

  fmt::print("Test: {}\nBuild type: {}\n",
             my_app::year_to_century(current_year),
             build_type);

  using namespace clang::tooling;
  using namespace llvm;
  CommonOptionsParser OptionsParser(argc, argv, MyToolCategory);
  ClangTool           Tool(OptionsParser.getCompilations(),
                 OptionsParser.getSourcePathList());
  return Tool.run(newFrontendActionFactory<clang::SyntaxOnlyAction>().get());
}
