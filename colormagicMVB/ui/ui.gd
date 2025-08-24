extends Node3D

@onready var color_pass = $"CanvasLayer2/Color pass"
@onready var gray_filter = $"CanvasLayer/grayscale filter"


func _ready():
	color_pass.material.set_shader_parameter("main_depth", ColorView.get_main_depth_texture())
	color_pass.material.set_shader_parameter("color_texture", ColorView.get_color_pass_texture())
	color_pass.material.set_shader_parameter("color_depth", ColorView.get_depth_texture() )

var debugenabled = false
var grayenabled = true
var colorenabled = true

func _unhandled_input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("debug"):
		debugenabled = !debugenabled
		$"CanvasLayer2/Color pass".material.set_shader_parameter("debug_draw", debugenabled)
	
	
	if Input.is_action_just_pressed("disablegray"):
		grayenabled = !grayenabled
		$"CanvasLayer/grayscale filter".visible = grayenabled
	
	
	if Input.is_action_just_pressed("disablecolor"):
		colorenabled = !colorenabled
		$"CanvasLayer2/Color pass".visible = colorenabled
