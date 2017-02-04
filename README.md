# BlizzMo

Welcome to BlizzMo for Vanilla WoW 1.12

There isn't much to say other than this mod will move any Blizzard Frame and all your Bags. There is 
code to handle just about any situation including keeping the frames visible and to not allow them 
to be dragged off screen. There are no slash commands as none are needed. There are a few user 
options that you can take advantage of.

First is the ability to toggle the save frame locations between game sessions. Just CTRL + Click any 
frame and you'll see a message in chat telling you which mode you're in. SHIFT + Mousewheel will 
scale the individual frames.

NOTE: your mouse cursor must remain over the desired frame that you're making changes to.

If for some reason you get yourself snarled into a bizzare situation and your frames are all 
foobar'd, just go into your game menu and you'll see a reset button for BlizzMo. A confirmation 
popup will occure and your UI will be reloaded after confirming reset.

Here is a list of Frames that are in the SAVE state by default:
	AuctionFrame
	CharacterFrame
	ClassTrainerFrame
	FriendsFrame
	QuestLogFrame
	SpellBookFrame
	TalentFrame
	GossipFrame
	MailFrame
	MerchantFrame
	TradeSkillFrame
	DressUpFrame
	LootFrame
	TaxiFrame
	TradeFrame
	Backpack
	Bag1
	Bag2
	Bag3
	Bag4

You can even add your own custom mods to a table (requires some knowledge of LUA) and is fairly 
straight forward. Just follow the examples that I've already added support for. For your convience 
the section of code is at the very bottom of BlizzMo.lua and it looks like this:

````
---------------------------------------------------------------------------------------------------
-- Add your custom frames from your mods here. If your mod has an XML, then look in there for the
-- main parent frame. If not then you'll have to search through all the files for CreateFrame() to
-- find the name of the primary frame name for your mod. It'll be the one that is attached to
-- *UIParent* and closly matches the mods title.
---------------------------------------------------------------------------------------------------
function CustomFrames()
    SetMoveHandler(EQL3_QuestLogFrame)
    SetMoveHandler(ATSWFrame)
    SetMoveHandler(SuperMacroFrame)
    SetMoveHandler(EnhancedFlightMapFrame)
    SetMoveHandler(AuctioneerFrame)
    SetMoveHandler(SuperInspectFrame)
    SetMoveHandler(XLootFrame)
end
````

These are some of the mods that I use. Feel free to add or remove support for them. If you're not 
using it, don't worry it won't cause any issues.
