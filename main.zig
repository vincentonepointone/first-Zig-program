const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"World \n I am now a zig programmer"});
}
