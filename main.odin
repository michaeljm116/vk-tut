package main
import "vendor:glfw"
import "base:intrinsics"
import "core:fmt"
import "core:mem"
import "core:log"

main :: proc()
{
    // Memory Leak Detection
    track_alloc: mem.Tracking_Allocator
	mem.tracking_allocator_init(&track_alloc, context.allocator)
	context.allocator = mem.tracking_allocator(&track_alloc)
	defer {
		fmt.eprintf("\n")
		for _, entry in track_alloc.allocation_map {
			fmt.eprintf("- %v leaked %v bytes\n", entry.location, entry.size)
		}
		for entry in track_alloc.bad_free_array {
			fmt.eprintf("- %v bad free\n", entry.location)
		}
		mem.tracking_allocator_destroy(&track_alloc)
		fmt.eprintf("\n")
		free_all(context.temp_allocator)
	}
	context.logger = log.create_console_logger()
	
	init_app()
	run_app()
	close_app()
}