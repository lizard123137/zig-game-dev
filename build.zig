const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mach_dep = b.dependency("mach", .{
        .target = target,
        .optimize = optimize,
    });

    const mach = mach_dep.module("mach");
    const mach_artifact = mach_dep.artifact("mach");

    const exe = b.addExecutable(.{
        .name = "zig-game-dev",
        .root_source_file = b.path("src/main.zig"),
        .optimize = optimize,
        .target = target,
    });

    exe.linkLibrary(mach_artifact);
    exe.root_module.addImport("mach", mach);

    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run application");
    run_step.dependOn(&run_cmd.step);

    b.installArtifact(exe);
}
