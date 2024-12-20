const std = @import("std");
const mach = @import("mach");

// The set of Mach modules our application may use.
const Modules = mach.Modules(.{
    mach.Core,
    @import("App.zig"),
    @import("Renderer.zig"),
});

pub fn main() !void {
    const allocator = std.heap.c_allocator;

    // Initialize the module system.
    var mods: Modules = undefined;
    try mods.init(allocator);

    // Pass control to our App.zig module.
    const app = mods.get(.app);
    app.run(.main);
}
