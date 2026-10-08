extends Node3D

class_name Table

var MaskDirs = DirAccess.get_directories_at("res://Masks/")
var UsedNumbers = []

func FindMaskScene(Dir:String):
	var filePath = "res://Masks/"+Dir+"/"
	var files = DirAccess.get_files_at(filePath)
	
	var found = false
	for i in files:
		if i.ends_with(".tscn"):
			filePath += i
			found = true
			break
	assert(found, "ERROR: this mask directory has no proper scene: " + Dir)
	return filePath
	
	

func GetRandEntry():
	var rEntry = randi() % len(MaskDirs)
	#print(rEntry, UsedNumbers.find(rEntry) == -1)
	if UsedNumbers.find(rEntry) == -1:
		UsedNumbers.append(rEntry)
		return rEntry
	else:
		if len(UsedNumbers) == len(MaskDirs): UsedNumbers.clear()
		return GetRandEntry()

var TakenPositions: Array[Vector2] = []
func GetRandomPosition():
	var rx := randi_range(-6,6)/10.0
	var rz := randf_range(-4,4)/10.0
	var vec = Vector2(rx,rz)
	var alrEx = false
	for i in TakenPositions:
		if i.x == rx and i.y == rz:
			alrEx = false
			break
	if alrEx:
		return GetRandomPosition()
	else:
		return vec
	

func Present(side:Node3D,plr):
	for i in range(5):
		var rEntry = GetRandEntry()
		var TargetMask = MaskDirs[rEntry]
		var MaskInstance = load(FindMaskScene(TargetMask)).instantiate() as Mask
		side.add_child(MaskInstance)
		var pos = GetRandomPosition()
		#MaskInstance.mesh.top_level = true
		MaskInstance.mesh.transform = (
			side.transform.translated(Vector3(pos.x,0.1,pos.y))
			.rotated_local(Vector3.RIGHT,-PI/3.5)
			.rotated_local(Vector3.FORWARD,randf_range(0.0, 2*PI))
		)
		MaskInstance.WearOn(plr)
		
	UsedNumbers.clear()
	TakenPositions.clear()
		
@onready var Side1 = $Side1
@onready var Side2 = $Side2
		
	
