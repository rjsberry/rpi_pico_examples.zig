usingnamespace @import("rp2040_startup");

const rtt = @import("rtt");

export fn main() callconv(.C) noreturn {
    rtt.println("hello {s}", .{"world"});
    while (true) {
        @breakpoint();
    }
}
