-- The default PAD Chat menu shipped with the addon. Players edit their own copy in
-- the editor window (the "PADEdit" macro or minimap button); this table seeds it on first run
-- and on "Reset to defaults".
--
-- Each level is keyed by the button that picks it: A, X or Y (B is always Cancel).
-- A node with `text` is a message and sends immediately; a node without it is a
-- category that opens the next level, up to four presses deep, so "X then Y
-- then A" works the same as Tribes 2's "V G Y".
--
-- The selected Whisper, Say, Group or Battleground tab determines where messages
-- go. `variants.WHISPER`, `variants.GROUP`, `variants.GUILD` and `variants.RAID`
-- replace options on those tabs; Whisper and Guild inherit Say, Battleground
-- inherits Group, and false clears a slot.
-- A message sends chat text, an `emote` token, or both: "Wave" is emote-only
-- and says nothing. Chat text can hold {location}, {LEVEL} and {CLASS}
-- placeholders, plus {TARGET} and {NAME}. The LFG tab (`variants.LFG`)
-- inherits Whisper; the Roleplay tab (`variants.RP`, `variants.RP_HORDE`)
-- has its own phrases, sent on /say.
-- `battlegrounds[instanceID]` supplies a menu for a specific battleground.
-- On a PlayStation pad A = Cross, X = Square, Y = Triangle, B = Circle.

local _, ns = ...

ns.DefaultMenu = {
	A = { label = "Respond",
		A = { label = "Yes",     text = "Yes!" },
		X = { label = "No",      text = "No." },
		Y = { label = "Thanks",  text = "Thanks!" },
	},
	X = { label = "Social",
		A = { label = "Greet",
			A = { label = "Hello",   text = "Hello" },
			-- An emote only reaches players nearby, never the whisper target, so
			-- the Whisper tab sends text alone.
			X = { label = "Goodbye", text = "Farewell", emote = "WAVE",
				variants = { WHISPER = { label = "Goodbye", text = "Farewell" } } },
			Y = { label = "Wave",    emote = "WAVE",
				variants = { WHISPER = { label = "Thanks for the group", text = "Thanks for the group!" } } },
		},
		X = { label = "Group",
			A = { label = "Invite please!",  text = "Invite please!" },
			X = { label = "Want to group?",  text = "Want to group up?" },
			Y = { label = "Inviting you",    text = "Inviting you now!" },
		},
	},
	Y = { label = "Callout",
		A = { label = "Help!",      text = "Help!" },
		X = { label = "Incoming!",  text = "Incoming!" },
		Y = { label = "Follow me",  text = "Follow me!" },
	},
}

ns.DefaultMenu.X.variants = {
	GROUP = { label = "Readiness",
		A = { label = "Resources",
			A = { label = "Need mana", text = "Need mana.", emote = "OOM" },
			X = { label = "Need healing", text = "Need healing, please!" },
			Y = { label = "Wait up", text = "Wait up!" },
		},
		X = { label = "Preparation",
			A = { label = "Ready", text = "Ready when you are." },
			X = { label = "Buffs please", text = "Buffs please!" },
			Y = { label = "Drinking", text = "Drinking, please wait." },
		},
	},
	RAID = { label = "Objectives",
		A = { label = "Help {location}", text = "Need help at {location}!" },
		X = { label = "Defend {location}", text = "Defend {location}!" },
		Y = { label = "{location} clear", text = "{location} clear." },
	},
}
ns.DefaultMenu.Y.variants = {
	GROUP = { label = "Coordination",
		A = { label = "Help", text = "Need help!" },
		X = { label = "Incoming", text = "Incoming!" },
		Y = { label = "Follow me", text = "Follow me!" },
	},
	RAID = { label = "Team",
		A = { label = "Regroup", text = "Regroup!" },
		X = { label = "Need healing", text = "Need healing, please!" },
		Y = { label = "Need mana", text = "Need mana.", emote = "OOM" },
	},
}
ns.DefaultMenu.A.variants = {
	RAID = { label = "Incoming",
		A = { label = "2-3 inc {location}", text = "2-3 inc {location}" },
		X = { label = "4-6 inc {location}", text = "4-6 inc {location}" },
		Y = { label = "Big INC {location}!", text = "Big INC {location}!" },
	},
}

-- The Guild tab inherits Say, with guild chat calls in place of Callout.
ns.DefaultMenu.Y.variants.GUILD = { label = "Guild",
	A = { label = "Grats!", text = "Grats!" },
	X = { label = "Dungeon run?", text = "Anyone up for a dungeon run?" },
	Y = { label = "Quest help?", text = "Anyone free to help with a quest?" },
}

-- The LFG tab answers a Looking For Group listing with the player's role.
ns.DefaultMenu.A.variants.LFG = { text = "{LEVEL} {CLASS} DPS" }
ns.DefaultMenu.X.variants.LFG = { text = "{LEVEL} {CLASS} HEALS" }
ns.DefaultMenu.Y.variants.LFG = { text = "{LEVEL} {CLASS} TANK" }

-- These replacements keep the same button paths as the generic BG menu.
ns.DefaultMenu.A.variants.RAID.battlegrounds = {
	[489] = { label = "Flag route",
		A = { label = "Flag going ramp", text = "Flag going ramp!" },
		X = { label = "Flag going tunnel", text = "Flag going tunnel!" },
		Y = { label = "Flag going graveyard", text = "Flag going graveyard!" },
	},
}
ns.DefaultMenu.X.variants.RAID.battlegrounds = {
	[489] = { label = "Flag support",
		A = { label = "Escort our carrier", text = "Escort our flag carrier!" },
		X = { label = "Intercept enemy carrier", text = "Intercept the enemy flag carrier!" },
		Y = { label = "Return our flag", text = "Return our flag!" },
	},
}

-- The Roleplay tab speaks in character on /say. It doesn't inherit Say: each
-- top slot carries its own `variants.RP` (Alliance) or `variants.RP_HORDE`
-- (Horde) branch, picked by the character's faction. {TARGET} is your
-- target's name ("friend" with no target) and {NAME} is your own.
local function Courtesy()
	return { label = "Courtesy",
		A = { label = "My thanks", text = "You have my thanks.", emote = "THANK" },
		X = { label = "At your service", text = "At your service.", emote = "BOW" },
		Y = { label = "Introduce yourself", text = "I am {NAME}. A pleasure." },
	}
end
local function Banter(toast)
	return { label = "Banter",
		A = { label = "Answers",
			A = { label = "Aye", text = "Aye.", emote = "NOD" },
			X = { label = "Nay", text = "Nay, I think not.", emote = "NO" },
			Y = { label = "Who can say?", text = "Who can say?", emote = "SHRUG" },
		},
		X = { label = "Tavern",
			A = { label = "A round for all", text = "Barkeep! A round for my friends!", emote = "CHEER" },
			X = { label = "Raise a toast", text = toast, emote = "DRINK" },
			Y = { label = "Pull up a chair", text = "Pull up a chair, friend. Rest your feet." },
		},
		Y = { label = "Questions",
			A = { label = "What news?", text = "What news from the road?" },
			X = { label = "Where to?", text = "Where are you headed, {TARGET}?" },
			Y = { label = "Need a hand?", text = "Need a hand with that?" },
		},
	}
end
local function Warnings()
	return { label = "Warnings",
		A = { label = "Watch yourself", text = "Watch yourself out there." },
		X = { label = "Something's amiss", text = "Something is amiss here..." },
		Y = { label = "Stay close", text = "Danger ahead. Stay close." },
	}
end

ns.DefaultMenu.A.variants.RP = { label = "Greetings",
	A = { label = "Hail",
		A = { label = "Well met, {TARGET}", text = "Well met, {TARGET}!", emote = "HAIL" },
		X = { label = "Light be with you", text = "Light be with you.", emote = "BOW" },
		Y = { label = "Greetings, traveler", text = "Greetings, traveler. Welcome.", emote = "WAVE" },
	},
	X = { label = "Farewell",
		A = { label = "Safe travels", text = "Safe travels, {TARGET}.", emote = "WAVE" },
		X = { label = "Light guide you", text = "May the Light guide your path.", emote = "BOW" },
		Y = { label = "Until we meet again", text = "Until we meet again." },
	},
	Y = Courtesy(),
}
ns.DefaultMenu.X.variants.RP = Banter("A toast! To the Alliance!")
ns.DefaultMenu.Y.variants.RP = { label = "Duty",
	A = { label = "Guard",
		A = { label = "Move along", text = "Move along, citizen." },
		X = { label = "Keep out of trouble", text = "Keep out of trouble, you hear?" },
		Y = { label = "Halt!", text = "Halt! State your business." },
	},
	X = { label = "Battle cry",
		A = { label = "For the Alliance!", text = "For the Alliance!", emote = "ROAR" },
		X = { label = "Light give me strength", text = "Light give me strength!" },
		Y = { label = "Hold the line", text = "Stand fast! Hold the line!" },
	},
	Y = Warnings(),
}

ns.DefaultMenu.A.variants.RP_HORDE = { label = "Greetings",
	A = { label = "Hail",
		A = { label = "Throm-Ka, {TARGET}", text = "Throm-Ka, {TARGET}.", emote = "HAIL" },
		X = { label = "Strength and honor", text = "Strength and honor.", emote = "SALUTE" },
		Y = { label = "Aka'Magosh", text = "Aka'Magosh. Blessings upon you.", emote = "BOW" },
	},
	X = { label = "Farewell",
		A = { label = "Safe travels", text = "Safe travels, {TARGET}.", emote = "WAVE" },
		X = { label = "Spirits guide you", text = "May the spirits guide you.", emote = "BOW" },
		Y = { label = "Until we meet again", text = "Until we meet again." },
	},
	Y = Courtesy(),
}
ns.DefaultMenu.X.variants.RP_HORDE = Banter("A toast! To the Horde!")
ns.DefaultMenu.Y.variants.RP_HORDE = { label = "Duty",
	A = { label = "Guard",
		A = { label = "Keep moving", text = "Keep moving, whelp." },
		X = { label = "No trouble here", text = "No trouble here. Understood?" },
		Y = { label = "Halt!", text = "Halt! State your business." },
	},
	X = { label = "Battle cry",
		A = { label = "For the Horde!", text = "For the Horde!", emote = "ROAR" },
		X = { label = "Lok'tar ogar!", text = "Lok'tar ogar! Victory or death!" },
		Y = { label = "Blood and thunder", text = "Blood and thunder!" },
	},
	Y = Warnings(),
}
