package main
import "vendor:glfw"
import "core:fmt"

Window :: struct
{
    handle : glfw.WindowHandle,
    width : i32,
    height : i32
}
g_window := Window {width = i32(800), height = i32(600)}

init_window :: proc()
{
    glfw.Init()
    glfw.WindowHint(glfw.CLIENT_API, glfw.NO_API)
    glfw.WindowHint(glfw.RESIZABLE, glfw.FALSE)
    g_window.handle = glfw.CreateWindow(g_window.width, g_window.height, "vktut", nil, nil)
    if(g_window.handle == nil){
        fmt.printf("Error, window creation failed: %s ", g_window.handle)
        return
    }
}