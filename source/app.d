module app;

import std.stdio;
import std.array;
import std.getopt;

import generate;

void main(string[] args) {
	string cmd;
	int stone = 5, zk = 24, timelimit = 60;

	if (args.length > 1) cmd = args[1];
	auto helpInformation = getopt (
		args,
		"stone", &stone,
		"zk", &zk,
		"z", &zk,
		"time", &timelimit);

	if (helpInformation.helpWanted) {
		defaultGetoptPrinter(
			"Some information about the program.",
			helpInformation.options);
	} else if (cmd == "gen") {
		if (!(1 <= stone && stone <= 256) && !(1 <= zk && zk <= 1024)) {
			writeln("Error: Invalid gen command parameter.");
			return;
		}
		gen(stone, zk);

	} else if (cmd == "server") {
		writeln("Server command is not available now.");
	}
}
