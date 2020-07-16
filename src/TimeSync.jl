module TimeSync

using Dates

module Lib
    using CxxWrap, Libdl

    const DEPSDIR = joinpath(dirname(@__DIR__), "deps")
    Libdl.dlopen(joinpath(DEPSDIR, "libsync.so"))

    @wrapmodule(joinpath(DEPSDIR, "libsync.so"))

    function __init__()
        @initcxx
    end
end # module Lib

using .Lib

cxxtime() = Lib.time_since_epoch()
juliatime() = 1000 * (Dates.value(now()) - Dates.UNIXEPOCH)

end
