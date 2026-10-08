extends Node

signal RoundTick

var p1:Player
var p2:Player

## recursive round system
func NewRound(plr1:Player, plr2:Player, tbl:Table):
	p1 = plr1
	p2 = plr2
	# ChoosePhase
	tbl.Present(tbl.Side1,plr1)
	tbl.Present(tbl.Side2,plr2)
	
	await ChoosePhaseEnded
	
	for m in tbl.Side1.get_children(): m.queue_free()
	
	
	print("CHOSEN")
	p2.Scan()
	p2.ChooseAttack()
	p2.ChooseDefense()
	p2.FinalizeChoice()
	
	print(p2.GetAttackMask())
	print(p2.GetDefenseMask())
	
	for m in tbl.Side2.get_children(): m.queue_free()
	
	
	# AttackPhase
	print("Attacking")
	await plr1.Attack()
	await plr2.Attack()
	
	print("Attack Finished")
	RoundTick.emit()
	
	# Round end
	plr1.FinalizeTurn()
	plr2.FinalizeTurn()
	
	if min(plr1.GetHealth(),plr2.GetHealth()) > 0:
		return await NewRound(plr1,plr2,tbl)
	else:
		if plr1.GetHealth() > plr2.GetHealth(): return "Win"
		elif plr2.GetHealth() > plr1.GetHealth(): return "Loss"
		else: return "Draw"
	
func Game(plr1:Player, plr2:Player,tbl:Table):
	plr1.SetOpponent(plr2)
	var result = await NewRound(plr1,plr2,tbl)


signal ChoosePhaseEnded

func AwaitBothPlayers():
	if p1 and p2:
		if p1.HasChosen():
			ChoosePhaseEnded.emit()

func _process(delta: float) -> void:
	AwaitBothPlayers()
