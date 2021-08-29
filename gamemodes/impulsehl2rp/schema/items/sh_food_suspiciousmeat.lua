local ITEM = {}

ITEM.UniqueID = "food_suspiciousmeat"
ITEM.Name = "Suspicious Meat"
ITEM.Desc =  "A dried unknown meat..."
ITEM.Category = "Food"
ITEM.Model = Model("models/mosi/skyrim/fooddrink/venison.mdl")
ITEM.FOV = 10.56446991404
ITEM.CamPos = Vector(-27.507164001465, 27.507164001465, 75.64469909668)
ITEM.NoCenter = true
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 6
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 45

function ITEM:OnUse(ply)
	if ply:IsCP() or ply:Team() == TEAM_VORT then
		ply:Notify("You can't eat this.")
		return
	end

    ply:FeedHunger(self.Food)

    local insaneLvl = ply:GetSyncVar(SYNC_INSANE, nil)

    if not insaneLvl then
    	ply:MakeInsane()
    end
    
    return true
end

impulse.RegisterItem(ITEM)
