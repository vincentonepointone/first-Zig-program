const std = @import("std");

fn ask_user() !i64 {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var buf: [10]u8 = undefined;

    try stdout.print("Guess a number between 1 and 100: ", .{});

    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |user_input| {
        return std.fmt.parseInt(i64, user_input, 10);
    } else {
        return error.InvalidParam;
    }
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const value = prng.random().intRangeAtMost(i64, 1, 100);
    while (true) {
        const guess = try ask_user();
        if (guess == value) {
            break;
        }
        const message =
            if (guess < value)
            "low"
        else
            "high";
        try stdout.print("Too {s}\n", .{message});
    }
    try stdout.print("That's right\n", .{});
}
