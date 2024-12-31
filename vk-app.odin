package main
import "vendor:vulkan"
import "vendor:glfw"

init_app :: proc()
{
    init_window()
}

run_app :: proc()
{
    for(!glfw.WindowShouldClose(g_window.handle)){
        glfw.PollEvents()
    }
}

close_app :: proc()
{
    glfw.DestroyWindow(g_window.handle)
    glfw.Terminate()
}