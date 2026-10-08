extends Node3D

class_name MaskMesh

@export_file_path("*.tres") var mesh:String

@onready var mMesh = $MeshInstance3D

@onready var Particles = $CPUParticles3D

var mask:Mask

func _ready() -> void:
	mask = get_parent() as Mask
	mMesh.mesh = load(mesh)
	
	HideOtherDetails.connect(ForceHide)
	
	match mask.GetType():
		MaskTypes.ENUM.FIRE:
			Particles.color = Color.ORANGE_RED
			
		MaskTypes.ENUM.WATER:
			Particles.color = Color.AQUA
		
		MaskTypes.ENUM.EARTH:
			Particles.color = Color.SADDLE_BROWN
		
		MaskTypes.ENUM.AIR:
			Particles.color = Color.ANTIQUE_WHITE
		
		MaskTypes.ENUM.ELECTRIC: 
			Particles.color = Color.YELLOW

signal HideOtherDetails
var CanClick = false
var Toggled = false

func ForceHide():
	mask.Details.Disappear()
	Toggled = false

func MouseHoverIn() -> void:
	CanClick = true

func MouseHoverOut() -> void:
	CanClick = false

func _process(delta: float) -> void:
	if CanClick == true:
		if Input.is_action_just_pressed("Click"):
			Toggled = not Toggled
			if Toggled:
				ForceHide()
				Toggled = true
				mask.Details.Appear()
			elif not Toggled: mask.Details.Disappear()
