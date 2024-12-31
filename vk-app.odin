package main
import vk"vendor:vulkan"
import "vendor:glfw"
import "core:fmt"
import "core:log"

init_vulkan :: proc(){

    context.user_ptr = &v_instance;
	get_proc_address :: proc(p: rawptr, name: cstring) 
	{
		(cast(^rawptr)p)^ = glfw.GetInstanceProcAddress((^vk.Instance)(context.user_ptr)^, name);
	}
	
	vk.load_proc_addresses(get_proc_address);
	create_instance();
	vk.load_proc_addresses(get_proc_address);
}

v_instance : vk.Instance = nil
create_instance :: proc(){
    context.user_ptr = &v_instance
    app_info := vk.ApplicationInfo{
        sType = vk.StructureType.APPLICATION_INFO,
        pApplicationName = "Hello Triangle",
        applicationVersion = vk.MAKE_VERSION(1,0,0),
        pEngineName = "Axiomo",
        engineVersion = vk.MAKE_VERSION(0,0,1),
        apiVersion = vk.API_VERSION_1_3
    }
    
    required_extensions := glfw.GetRequiredInstanceExtensions()
    extension_count := u32(len(required_extensions))
    log.info("Required Extensions: {}", extension_count)
    for i, ext in required_extensions{
        log.info("Extension {}: {}", i, ext)
    }
    create_info := vk.InstanceCreateInfo{
        sType = vk.StructureType.INSTANCE_CREATE_INFO,
        pApplicationInfo = &app_info,
        enabledExtensionCount = extension_count,
        ppEnabledExtensionNames = raw_data(required_extensions),
        enabledLayerCount = 0,
    }
    log.info("Creating Vulkan Instance")
    result := vk.CreateInstance(&create_info, nil, &v_instance)
    if(result != vk.Result.SUCCESS){log.error("Failed to Create Vulkan Instance")}
    //assert(result == vk.Result.SUCCESS)
}

cleanup :: proc(){
    vk.DestroyInstance(v_instance, nil)
}