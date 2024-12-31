package main
import "vendor:vulkan"
import "vendor:glfw"
import "core:log"
init_app :: proc()
{
    init_window()
    init_vulkan()
    log.info("App Initialized")
}

run_app :: proc()
{
    log.info("running app")
    for(!glfw.WindowShouldClose(g_window.handle)){
        glfw.PollEvents()
    }
}

close_app :: proc()
{
    log.info("Cleaning Up")
    cleanup()
    glfw.DestroyWindow(g_window.handle)
    glfw.Terminate()
}

