local BENCH = {}

BENCH.Class = "general"
BENCH.Name = "General Workbench"
BENCH.Desc = "Can be used to craft basic items."
BENCH.Model = "models/mosi/fallout4/furniture/workstations/workshopbench.mdl"
BENCH.Illegal = true
BENCH.NotIllegalFor = {TEAM_CWU}

impulse.RegisterBench(BENCH)
