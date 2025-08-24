extends SubViewport

@onready var vp = $"."
@onready var camera = $Camera3D

@onready var depth = $depth
@onready var depth_cam = $depth/depth_cam

@onready var main_depth = $main_depth
@onready var main_depth_cam = $main_depth/depth_cam


var win_size : Vector2i = DisplayServer.window_get_size()



func _ready():
	
	var ratio = win_size.y / 240.0 #reduce size of viewport, this wont be noticiable in final build
	win_size = win_size/ratio
	
	
	vp.transparent_bg = true #make background transparent just to be safe
	vp.size = win_size #set its size to the window size
	
	depth.transparent_bg = true
	depth.size = win_size
	
	main_depth.transparent_bg = true
	main_depth.size = win_size


func _process(_delta: float) -> void:
	
	var main_camera = get_tree().get_root().find_child("Camera", true, false)
	
	
	if main_camera:
		camera.global_transform = main_camera.global_transform #copy main camera details to viewport camera
		camera.fov = main_camera.fov #copy main camera details to viewport camera
		camera.near = main_camera.near #copy main camera details to viewport camera
		camera.far = main_camera.far #copy main camera details to viewport camera
		
		depth_cam.global_transform = main_camera.global_transform
		depth_cam.fov = main_camera.fov
		depth_cam.near = main_camera.near
		depth_cam.far = main_camera.far
		
		main_depth_cam.global_transform = main_camera.global_transform
		main_depth_cam.fov = main_camera.fov
		main_depth_cam.near = main_camera.near
		main_depth_cam.far = main_camera.far
	


func get_color_pass_texture() -> Texture2D:
	return get_texture()

func get_depth_texture() -> Texture2D:
	return $depth.get_texture()

func get_main_depth_texture() -> Texture2D:
	return $main_depth.get_texture()

func get_main_pass_texture() -> Texture2D:
	return $main.get_texture()
