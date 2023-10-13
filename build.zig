const std = @import("std");

const rp2040 = @import("rp2040");

const Xrun = @import("xrun").Xrun;

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const executable = rp2040.addExecutable(b, .{
        .name = "example",
        .root_source_file = .{ .path = "src/main.zig" },
        .optimize = optimize,
    });

    const rtt_dep = b.dependency("rtt", .{
        .target = executable.target,
        .optimize = optimize,
    });

    executable.addModule("rtt", rtt_dep.module("rtt"));

    b.installArtifact(executable);

    var xrun = Xrun.init(b);
    const xrun_cmd = xrun.addRunArtifact(.{ .executable = executable });
    const xrun_step = b.step("xrun", "Run the example");
    xrun_step.dependOn(&xrun_cmd.step);
}
