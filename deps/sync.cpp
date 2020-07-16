#include <chrono>
#include <cstdint>

// jlcxx
#include "jlcxx/jlcxx.hpp"

JLCXX_MODULE define_julia_module(jlcxx::Module& mod)
{
    mod.method("time_since_epoch", [](){
        return std::chrono::duration_cast<std::chrono::microseconds>(
            std::chrono::high_resolution_clock::now().time_since_epoch()).count();
    });
}
