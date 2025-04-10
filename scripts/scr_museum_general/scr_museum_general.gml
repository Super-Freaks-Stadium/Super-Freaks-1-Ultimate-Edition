enum museum_data
{
	characters = 0,
	cutscenes,
}

enum museum_character_data
{
	image_index = 0,
	unlocked,
	name,
	bio,
	unlock_func,
}

enum museum_cutscene_data
{
	image_index = 0,
	unlocked,
	name,
	room,
	unlock_func,
}

/// @function museum_init
function museum_init()
{
	global.museum_stuff = [];
	global.cutscene_index = 0;
	
	#region Character Cards
		museum_character_create(0,, "The Super Freaks", "The greatest heroes to ever grace reality! ...believe it or not. These half-brothers, when they have Unlimit Energy, seem to exclusively use the worst powers you've ever seen. While they're currently powerless, normally their anarchic ways and Unlimit Energy make them God-tier reality warpers.", function()
		{
			return true;
		});
		museum_character_create(1,, "Scruffy", "John 'Scruffy' Super Freaks is one of the Super Freaks, with a fun loving attitude and a big, toothy grin. While he appears to be a robot, he is actually a crudely drawn stickman wearing an elaborate costume. I'm not sure if that's a belt or TV screen on his chest, and neither is he!", function()
		{
			return true;
		});
		museum_character_create(2,, "King Quincy", "The closest thing the Super Freaks have to a leader. He is relaxed and has a cool head, which is useful whenever his half-brothers get too eccentric for their own good. He also plays a killer saxophone.", function()
		{
			return true;
		});
		museum_character_create(3,, "Gambi", "Don't be fooled by his cutesy appearence--Gambi is a hot blooded seeker of justice and vengeance. He often has to cool himself down with deep breathing exercises. He's also a ghost, but strangely has nothing in common with ghosts, not even being dead.", function()
		{
			return true;
		});
		museum_character_create(4,, "Tikiman", "A guy made of wood, with a brain that might as well be syrup. He is a genius with so many thoughts, he needs to remotely store them with the satellite on his head. He has incredibly ripped abs under his dorky labcoat.", function()
		{
			return true;
		});
		museum_character_create(5,, "Uncle Swordsman", "Before the Super Freaks came of age, Uncle Swordsman was the ultimate hero, and in many ways he is still more skilled than them. He was known for fighting the first set of supervillains, like Michael 'Marrow Prime' Ribson Sr.; and Nemesis, the Freak Devil.", function()
		{
			return true;
		});
		museum_character_create(6,, "One Eyed Bandit", "One Eyed Bandit is the SECOND strongest warrior in the universe. He's always trying to win a fight against Uncle Swordsman to take the top spot. Weird hobby aside, he's a nice guy!", function()
		{
			return true;
		});
		museum_character_create(7,, "The Anti Freaks", "The infamous evil doppelgangers of the Super Freaks. Each individually 'wronged', they came together to try to outdo the Super Freaks, but fail every time. One would think they'd learn, but they'll keep doing this 4ever!...yeah, I know that foreshadowing was awful.", function()
		{
			return true;
		});
		museum_character_create(8,, "Superior", "Scruffy's anti counterpart is obsessed with proving he is the better of the two. His cool mustache is certainly a bullet point in his favor. Unfortunately for him, he tries way too hard and just fails miserably. You have to admire the effort though!", function()
		{
			return true;
		});
		museum_character_create(9,, "Negative Quincy", "A robot version of King Quincy. While Quincy is chill, Negative Quincy takes this to the extreme. He lives in a junkyard which he never cleans, and he blows up stuff for fun. He greatly dislikes authority, but that's lowkey a little relatable.", function()
		{
			return true;
		});
		museum_character_create(10,, "Geyzer", "Geyzer is a fellow ghost-but-not-really, like Gambi. He is brooding and emo, though really this is just for show. He's the only Anti Freak with any real sense of morality, but even then he's still kind of a jerk.", function()
		{
			return true;
		});
		museum_character_create(11,, "Trash Can Man", "Formerly Tikiman's lab assistant. He's got a huge ego and can sell you a used napkin with his fake charisma. He's smart, but in none of the ways that really matter--just ask him about his submarine incident and see how he reacts!", function()
		{
			return true;
		});
		museum_character_create(12,, "The Shadow", "The evil equivalent of Uncle Swordsman. He is not of the same reality; he is an antimatter being of the Negative Zone, who must astral project himself into the Positive Zone. He gathered the Anti Freaks and gave them some kind of mission, whether they like it or not!", function()
		{
			return level_complete_get(level_ids.level_stadium, story_modes.swordsman) || level_complete_get(level_ids.level_stadium, story_modes.anti_freaks);
		});
		museum_character_create(13,, "The X-Freaks", "The Super Freaks of Freakiverse-1963X, known for mutations that give them superpowers. In their universe, they've founded a school for Freak Mutants after the humans deemed them all a threat. They have been successful enough in their heroics to join the H.U.B.", function()
		{
			return level_complete_get(level_ids.level_ludicrous_barrel, story_modes.super_freaks);
		});
		museum_character_create(14,, "Les Slaypool", "Scruffy's X-Freaks equivalent has a mutant immortality, letting him tank any dangerous situation. He can also annoy his foes with quips, which is a talent not many can do well. Can you imagine a universe where everyone quipped like that constantly? That would get old quick, wouldn't it?", function()
		{
			return level_complete_get(level_ids.level_ludicrous_barrel, story_modes.super_freaks);
		});
		museum_character_create(15,, "Cyquops", "The X-Freaks' version of King Quincy is every bit as mature and dignified as his original counterpart--that is to say, just barely enough. Whatever you do, don't yank off his cool helmet. His laser vision goes out of control without it on!", function()
		{
			return level_complete_get(level_ids.level_ludicrous_barrel, story_modes.super_freaks);
		});
		museum_character_create(16,, "Gloverine", "Gambi's X-Freaks counterpart is also quick to anger. His mutant power is being a Canadian. This makes him say 'eh' a lot, but with those blade gloves, he's a killer lumberjack like any good Canadian.", function()
		{
			return level_complete_get(level_ids.level_ludicrous_barrel, story_modes.super_freaks);
		});
		museum_character_create(17,, "Professor T", "The founding member of the X-Freaks and a counterpart of Tikiman. He has incredibly powerful telekinesis and the voice of a Shakespearean actor, qualities which make him a dignified leader. This all came at the cost of his legs, but he has a super cool wheelchair to make up for it.", function()
		{
			return level_complete_get(level_ids.level_ludicrous_barrel, story_modes.super_freaks);
		});
		museum_character_create(18,, "A Brick", "A block, typically of a reddish hue, made of clay and meant to be glued together with other bricks. They are typically layed on top of each other to form walls, or side by side to make roads, by masons. Bricks have a rich thousands of years history of use as construction material.", function()
		{
			return level_complete_get(level_ids.level_supersecret_boss, story_modes.super_freaks) || level_complete_get(level_ids.level_supersecret_boss, story_modes.kranion) || level_complete_get(level_ids.level_supersecret_boss, story_modes.swordsman) || level_complete_get(level_ids.level_supersecret_boss, story_modes.anti_freaks);
		});
		museum_character_create(19,, "The Freak Fathers", "A group of Freak mystics who live on Freaky World. They can sense fluctuations in Unlimit Energy. They are as wise as they are goofy--some have speculated this is because they are the oldest Freaks in existence.", function()
		{
			return level_complete_get(level_ids.level_freaky_ice, story_modes.super_freaks) || level_complete_get(level_ids.level_freaky_ice, story_modes.kranion) || level_complete_get(level_ids.level_freaky_ice, story_modes.swordsman);
		});
		museum_character_create(20,, "Yerr Hey", "The founder of the Freak Fathers. He knew he should not study Unlimit Energy on his own, so he brought his friends together to join him. His goofy appearence hides an incredibly clever mind.", function()
		{
			return level_complete_get(level_ids.level_freaky_ice, story_modes.super_freaks) || level_complete_get(level_ids.level_freaky_ice, story_modes.kranion) || level_complete_get(level_ids.level_freaky_ice, story_modes.swordsman);
		});
		museum_character_create(21,, "Treak", "The oldest Tree Freak, who is part of the Freak Fathers. He is the wisest of the fathers, but gets too caught up in old stories about how he walked to and from school in the snow...stories he doesn't remember right!", function()
		{
			return level_complete_get(level_ids.level_freaky_ice, story_modes.super_freaks) || level_complete_get(level_ids.level_freaky_ice, story_modes.kranion) || level_complete_get(level_ids.level_freaky_ice, story_modes.swordsman);
		});
		museum_character_create(22,, "Papa Freak", "A Freaky Freak elder who is part of the Freak Fathers. He is incredibly eccentric, yet sometimes his wild thoughts lead to new developments in Unlimit Energy uses. More often than not, however, he just kind of does weird things in his village.", function()
		{
			return level_complete_get(level_ids.level_freaky_ice, story_modes.super_freaks) || level_complete_get(level_ids.level_freaky_ice, story_modes.kranion) || level_complete_get(level_ids.level_freaky_ice, story_modes.swordsman);
		});
		museum_character_create(23,, "Noh Bodee", "A face and hands who is in the Freak Fathers. His lack of body allows him to fly anywhere and even appear inside someone's mind. He often uses this astral projection to warn the Super Freaks of danger.", function()
		{
			return level_complete_get(level_ids.level_freaky_ice, story_modes.super_freaks) || level_complete_get(level_ids.level_freaky_ice, story_modes.kranion) || level_complete_get(level_ids.level_freaky_ice, story_modes.swordsman);
		});
		museum_character_create(24,, "Goob", "The Freak Fathers' beloved Freak dog. He is just as attuned to Unlimit Energy as the fathers are, but his keen dog senses take this to a whole other level. His full name is Goobert.", function()
		{
			return level_complete_get(level_ids.level_freaky_ice, story_modes.super_freaks) || level_complete_get(level_ids.level_freaky_ice, story_modes.kranion) || level_complete_get(level_ids.level_freaky_ice, story_modes.swordsman);
		});
		museum_character_create(25,, "Kranion", "Michael 'Mikey' Ribson Jr., aka Kranion, was not the galaxy's first villain but is at this point the most well known. He is known for his Southie accent and attitude. When he wants something, he gets it, unless it ruins the day of his frenemies the Super Freaks.", function()
		{
			return true;
		});
		museum_character_create(26,, "Cranion", "A doppelganger of Kranion who is completely identical other than his more blue color scheme and his name, spelt with a hard C instead of a K. Yeah, I don't get it either.", function()
		{
			return level_complete_get(level_ids.level_kranion_final_boss, story_modes.kranion);
		});
		museum_character_create(27,, "Sticky", "Sticky is the half-brother of Kranion, another evil skeleton who menaced the Super Freaks when they were younger. He and Kranion despise each other even on a good day. Lately he's been working on a secret project.", function()
		{
			return true;
		});
		museum_character_create(28,, "Marrow Prime", "Kranion and Sticky's dad, and the universe's strongest being, thanks to overthrowing the underworld in his youth. Lately he's retired and enjoys life as a bumbling sitcom dad. Unfortunately for us, sometimes he yearns for the good old days.", function()
		{
			return true;
		});
		museum_character_create(29,, "Dino", "William Nancy Dino is the biggest loser in the whole galaxy. Despite his unparalleled skills in all forms of science and robotics, he has failed to do anything useful with them, instead choosing to be Kranion's right hand man in hopes the big lout will reward him with unlimited power.", function()
		{
			return level_complete_get(level_ids.level_kranion_conveyor, story_modes.super_freaks) || level_complete_get(level_ids.level_kranion_conveyor, story_modes.kranion) || level_complete_get(level_ids.level_kranion_conveyor, story_modes.swordsman) || level_complete_get(level_ids.level_kranion_conveyor, story_modes.anti_freaks);
		});
		museum_character_create(30,, "Cinge", "Cinge is a cyborg like being known as a 'Californian', who can light himself on fire. He's actually a pretty nice guy, who is genuinely friends with the Super Freaks--unfortunately, he's fallen in with the wrong crowd: Kranion's crowd.", function()
		{
			return level_complete_get(level_ids.level_normal_boss, story_modes.super_freaks) || level_complete_get(level_ids.level_normal_boss, story_modes.kranion) || level_complete_get(level_ids.level_normal_boss, story_modes.swordsman) || level_complete_get(level_ids.level_normal_boss, story_modes.anti_freaks);
		});
		museum_character_create(31,, "Milk Man", "A milk bottle robot who, get this, is sour. He just wants to sleep and watch TV, and primarily mumbles under his breath. He will fight you pretty intensely just to make sure you won't bother him again.", function()
		{
			return level_complete_get(level_ids.level_crazy_boss, story_modes.super_freaks) || level_complete_get(level_ids.level_crazy_boss, story_modes.kranion) || level_complete_get(level_ids.level_crazy_boss, story_modes.anti_freaks);
		});
		museum_character_create(32,, "Mega Klaw", "A robot far stronger than even base level Kranion, and with the persona of a wrestler! Luckily, he's too nice and friendly to be malicious. He just likes to show off his strength.", function()
		{
			return level_complete_get(level_ids.level_ludicrous_boss, story_modes.super_freaks) || level_complete_get(level_ids.level_ludicrous_boss, story_modes.kranion);
		});
		museum_character_create(33,, "Spike", "A robot orange who is a powerful minion of the Ribsons. He is simple minded but deep, and for some reason he has absolutely immaculate taste. Ask him what his favorite TV series is, you won't be disappointed.", function()
		{
			return level_complete_get(level_ids.level_ludicrous_boss, story_modes.swordsman) || level_complete_get(level_ids.level_ludicrous_boss, story_modes.anti_freaks);
		});
		museum_character_create(34,, "Larry McPeel", "A distant cousin of the Super Freaks. He isn't a bad guy, but he uses Unlimit Energy to do irritating and sometimes life threatening pranks. Kranion frequently recruits him, but even he gets annoyed with Larry!", function()
		{
			return level_complete_get(level_ids.level_insane_boss, story_modes.super_freaks) || level_complete_get(level_ids.level_insane_boss, story_modes.kranion);
		});
		museum_character_create(35,, "Francis", "Of all of Kranion's friends, Francis is the most screwed up. He likes starting fires more than the guy actually made of fire! A favorite hobby of his is to hypnotize people and creatures into doing stupid things for his own amusement.", function()
		{
			return level_complete_get(level_ids.level_freaky_boss, story_modes.super_freaks) || level_complete_get(level_ids.level_freaky_boss, story_modes.anti_freaks);
		});
		museum_character_create(36,, "Wartnose", "Trained by Lord Humerus himself, Wartnose is a powerful wizard and accomplished nerd. What appears to be a snake like body is actually an incredibly long neck, with his microscopic body at the other end! I don't get it either.", function()
		{
			return level_complete_get(level_ids.level_freaky_boss, story_modes.kranion) || level_complete_get(level_ids.level_freaky_boss, story_modes.swordsman);
		});
	#endregion
	
	#region Cutscenes
		museum_cutscene_create(0,, "Welcome to the USC", rm_cutscene_intro, function()
		{
			return true;
		});
        museum_cutscene_create(1,, "Fast Cars Underground 2", rm_cutscene_intro_superfreaks, function()
        {
            return true;
        });
		museum_cutscene_create(2,, "Meet the Anti Freaks", rm_cutscene_antifreaks_intro, function()
		{
			return level_complete_get(level_ids.level_stadium, story_modes.super_freaks);
		});
		museum_cutscene_create(3,, "Gratituous Multiverse Cameos", rm_cutscene_xfreaks, function()
		{
			return level_complete_get(level_ids.level_ludicrous_barrel, story_modes.super_freaks);
		});
		museum_cutscene_create(4,, "The Freak Fathers", rm_cutscene_freak_fathers, function()
		{
			return level_complete_get(level_ids.level_freaky_ice, story_modes.super_freaks);
		});
		museum_cutscene_create(5,, "Castle Numbskull", rm_cutscene_castle, function()
		{
			return level_complete_get(level_ids.level_kranion_conveyor, story_modes.super_freaks);
		});
		museum_cutscene_create(6,, "Pimp My Skullmobile", rm_cutscene_skullmobile, function()
		{
			return level_complete_get(level_ids.level_kranion_boss_secret, story_modes.super_freaks);
		});
		museum_cutscene_create(7,, "Dumb Dino", rm_cutscene_dino, function()
		{
			return level_complete_get(level_ids.level_kranion_boss, story_modes.super_freaks);
		});
		museum_cutscene_create(8,, "The Big Fight", rm_cutscene_kranion, function()
		{
			return level_complete_get(level_ids.level_kranion_final_boss, story_modes.super_freaks);
		});
		museum_cutscene_create(9,, "Normal Ending - Super Freaks", rm_cutscene_ending_normal, function()
		{
			return level_complete_get(level_ids.level_kranion_final_boss, story_modes.super_freaks);
		});
		museum_cutscene_create(10,, "An Exciting Encore", rm_cutscene_encore, function()
		{
			return level_complete_get(level_ids.level_supersecret);
		});
		museum_cutscene_create(11,, "Anti Freak Fight", rm_cutscene_antifreaks_battle, function()
		{
			return level_complete_get(level_ids.level_supersecret_boss);
		});
		museum_cutscene_create(12,, "Secret Ending - Super Freaks", rm_cutscene_ending_secret, function()
		{
			return level_complete_get(level_ids.level_supersecret_boss);
		});
		museum_cutscene_create(13,, "Boneheads Unite!", rm_cutscene_intro_kranion, function()
		{
			return true;
		});
		museum_cutscene_create(14,, "The Boneheads Meet the Anti Freaks", rm_cutscene_antifreaks_intro_villains, function()
		{
			return level_complete_get(level_ids.level_stadium, story_modes.kranion);
		});
		museum_cutscene_create(15,, "The Freak Fathers Are Displeased", rm_cutscene_freak_fathers_villains, function()
		{
			return level_complete_get(level_ids.level_freaky_ice, story_modes.kranion);
		});
		museum_cutscene_create(16,, "Sussing Out the Imposter", rm_cutscene_cranion, function()
		{
			return level_complete_get(level_ids.level_kranion_final_boss, story_modes.kranion);
		});
		museum_cutscene_create(17,, "Normal Ending - Bad Guys", rm_cutscene_ending_normal_villains, function()
		{
			return level_complete_get(level_ids.level_kranion_final_boss, story_modes.kranion);
		});
		museum_cutscene_create(18,, "Secret Ending - Bad Guys", rm_cutscene_ending_secret_villains, function()
		{
			return level_complete_get(level_ids.level_supersecret_boss, story_modes.kranion);
		});
		museum_cutscene_create(19,, "Unretirement", rm_cutscene_intro_swordsman, function()
		{
			return true;
		});
		museum_cutscene_create(20,, "Me and My Shadow", rm_cutscene_after_stadium_swordsman, function()
		{
			return level_complete_get(level_ids.level_stadium, story_modes.swordsman);
		});
		museum_cutscene_create(21,, "80's Training Montage", rm_cutscene_training_swordsman, function()
		{
			return level_complete_get(level_ids.level_ludicrous_barrel, story_modes.swordsman);
		});
		museum_cutscene_create(22,, "Freak Father Freakcation", rm_cutscene_freak_fathers_swordsman, function()
		{
			return level_complete_get(level_ids.level_freaky_ice, story_modes.swordsman);
		});
		museum_cutscene_create(23,, "Prime Energy", rm_cutscene_prime_swordsman, function()
		{
			return level_complete_get(level_ids.level_kranion_final_boss, story_modes.swordsman);
		});
		museum_cutscene_create(24,, "Normal Ending - Swordsmen", rm_cutscene_ending_normal_swordsman, function()
		{
			return level_complete_get(level_ids.level_kranion_final_boss, story_modes.swordsman);
		});
		museum_cutscene_create(25,, "Secret Ending - Swordsmen", rm_cutscene_ending_secret_swordsman, function()
		{
			return level_complete_get(level_ids.level_supersecret_boss, story_modes.swordsman);
		});
		museum_cutscene_create(26,, "Credits", rm_cutscene_credits, function()
		{
			return true;
		});
        museum_cutscene_create(27, 0, "Welcome to the USC (Old)", rm_cutscene_intro_old, function()
        {
            return level_complete_get(level_ids.level_stadium, story_modes.super_freaks);
        });
        museum_cutscene_create(28, 3, "Gratituous Multiverse Cameos (Old)", rm_cutscene_xfreaks_old, function()
        {
            return level_complete_get(level_ids.level_ludicrous_barrel, story_modes.super_freaks);
        });
	#endregion
	
	//museum_load();
}

/// @functiom museum_character_create
/// @param _index
/// @param _image_index = _index
/// @param _name = ""
/// @param _bio = ""
/// @param _unlock_func = function(){}
function museum_character_create(_index, _image_index = _index, _name = "", _bio = "", _unlock_func = function(){})
{
	global.museum_stuff[museum_data.characters][_index][museum_character_data.image_index] = _image_index;
	global.museum_stuff[museum_data.characters][_index][museum_character_data.name] = _name;
	global.museum_stuff[museum_data.characters][_index][museum_character_data.bio] = _bio;
	global.museum_stuff[museum_data.characters][_index][museum_character_data.unlocked] = false;
	global.museum_stuff[museum_data.characters][_index][museum_character_data.unlock_func] = _unlock_func;
}

/// @functiom museum_cutscene_create
/// @param _index
/// @param _image_index = _index
/// @param _name = ""
/// @param _room = rm_cutscene_parent
/// @param _unlock_func = function(){}
function museum_cutscene_create(_index, _image_index = _index, _name = "", _room = rm_cutscene_parent, _unlock_func = function(){})
{
	global.museum_stuff[museum_data.cutscenes][_index][museum_cutscene_data.image_index] = _image_index;
	global.museum_stuff[museum_data.cutscenes][_index][museum_cutscene_data.name] = _name;
	global.museum_stuff[museum_data.cutscenes][_index][museum_cutscene_data.room] = _room;
	global.museum_stuff[museum_data.cutscenes][_index][museum_cutscene_data.unlocked] = false;
	global.museum_stuff[museum_data.cutscenes][_index][museum_cutscene_data.unlock_func] = _unlock_func;
}

/// @function museum_save
function museum_save()
{
	var _i, _json;
	var _array = [];
	
	for (_i = 0; _i < array_length(global.museum_stuff[museum_data.characters]); ++_i)
	{
		_array[museum_data.characters][_i] = global.museum_stuff[museum_data.characters][_i][museum_character_data.unlocked];
	}
	for (_i = 0; _i < array_length(global.museum_stuff[museum_data.cutscenes]); ++_i)
	{
		_array[museum_data.cutscenes][_i] = global.museum_stuff[museum_data.cutscenes][_i][museum_cutscene_data.unlocked];
	}
	
	_json = json_stringify(_array);
	string_save(_json, "museum.save");
}

/// @function museum_load
function museum_load()
{
	var _json;
	var _array;
	var _i;
	
	if (file_exists("Save1/museum.save"))
	{
		_json = string_load("Save1/museum.save");
		_array = json_parse(_json);
		
		for (_i = 0; _i < array_length(_array[museum_data.characters]); ++_i)
		{
			global.museum_stuff[museum_data.characters][_i][museum_character_data.unlocked] = _array[museum_data.characters][_i];
		}
		for (_i = 0; _i < array_length(_array[museum_data.cutscenes]); ++_i)
		{
			global.museum_stuff[museum_data.cutscenes][_i][museum_cutscene_data.unlocked] = _array[museum_data.cutscenes][_i];
		}
	}
}

///@function museum_unlocks
function museum_unlocks()
{
	var _i;
	var _func, _unlocked;
	
	for (_i = 0; _i < array_length(global.museum_stuff[museum_data.characters]); ++_i)
	{
		_unlocked = global.museum_stuff[museum_data.characters][_i][museum_character_data.unlocked];
		_func = global.museum_stuff[museum_data.characters][_i][museum_character_data.unlock_func];
		
		if (_unlocked == false && _func() == true)
		{
			global.museum_stuff[museum_data.characters][_i][museum_character_data.unlocked] = true;
			show_debug_message("UNLOCK CHARACTER BIO " + string(_i));
		}
	}
	for (_i = 0; _i < array_length(global.museum_stuff[museum_data.cutscenes]); ++_i)
	{
		_unlocked = global.museum_stuff[museum_data.cutscenes][_i][museum_cutscene_data.unlocked];
		_func = global.museum_stuff[museum_data.cutscenes][_i][museum_cutscene_data.unlock_func];
		
		if (_unlocked == false && _func() == true)
		{
			global.museum_stuff[museum_data.cutscenes][_i][museum_cutscene_data.unlocked] = true;
			show_debug_message("UNLOCK CUTSCENE " + string(_i));
		}
	}
}