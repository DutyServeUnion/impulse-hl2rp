impulse.Business.Define("Crate", {
    entity = "impulse_container",
    model = "models/props_junk/wood_crate001a.mdl",  -- old: models/props_junk/wood_crate001a.mdl
    description = "Can store 8kg worth of items.",
    price = 75,
    refund = true,
    postSpawn = function(ent, ply)
    	ent:SetCapacity(8)
    end
})

impulse.Business.Define("Large Crate", {
    entity = "impulse_container",
    model = "models/props_junk/wood_crate002a.mdl", -- old: models/props_junk/wood_crate002a.mdl
    description = "Can store 25kg worth of items.",
    price = 135,
    refund = true,
    postSpawn = function(ent, ply)
        ent:SetCapacity(25)
    end
})
