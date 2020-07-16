using CxxWrap

current_dir = @__DIR__
cxxhome = CxxWrap.prefix_path()
juliahome = dirname(Base.Sys.BINDIR)

# Need to compile with the same compiler that nGraph is.
cxx = "clang++"

cxxflags = [
    "-g",
    "-O3",
    "-Wall",
    "-fPIC",
    "-std=c++17",
    "-DPCM_SILENT",
    "-DJULIA_ENABLE_THREADING",
    "-Dexcept_EXPORTS",
    # Surpress some warnings from Cxx
    "-Wno-unused-variable",
    "-Wno-unused-lambda-capture",
]

includes = [
    "-I$(joinpath(cxxhome, "include"))",
    "-I$(joinpath(juliahome, "include", "julia"))",
    "-I$(joinpath(@__DIR__, "usr", "include"))",
]

loadflags = [
    # Linking flags for Julia
    "-L$(joinpath(juliahome, "lib"))",
    "-Wl,--export-dynamic",
    "-Wl,-rpath,$(joinpath(juliahome, "lib"))",
    "-ljulia",
    # Linking Flags for CxxWrap
    "-L$(joinpath(cxxhome, "lib"))",
    "-Wl,-rpath,$(joinpath(cxxhome, "lib"))",
    "-lcxxwrap_julia",
]

src = joinpath(current_dir, "sync.cpp")
so = joinpath(current_dir, "libsync.so")

cmd = `$cxx $cxxflags $includes -shared $src -lpthread -o $so $loadflags`
@show cmd
run(cmd)
