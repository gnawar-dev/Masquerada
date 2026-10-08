extends Node
class_name MaskTypes
enum ENUM {
	FIRE,
	WATER,
	EARTH,
	AIR,
	ELECTRIC
}

static func InferiorOf(Superior:ENUM):
	match Superior:
		ENUM.FIRE: return;
		ENUM.WATER: return;
		ENUM.EARTH: return;
		ENUM.AIR: return;
		ENUM.ELECTRIC: return;
	
