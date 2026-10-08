extends Mask

class_name Mutaconda

#region Available members

#Duration - number of turns the player will be wearing this mask

#GetWearer() - returns the player wearing this mask

#endregion

func PrimaryAttack():
	SecondaryAttack()
	Wearer.Opponent.TakeDamage(2)
	
func SecondaryAttack():
	Wearer.Opponent.TakeDamage(5)
	
func Defend():
	var sd = Wearer.GetSustainedDamage()
	Wearer.Heal(round(sd*0.2))
	
	#After all of that#
	super.Defend()

func TickFunc():
	pass
