-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"

-- event listeners for tab buttons:
local function onFirstView( event )
	composer.gotoScene( "view1" )
end

local function onSecondView( event )
	composer.gotoScene( "view_workout" )
end


-- create a tabBar widget with two buttons at the bottom of the screen

-- table to setup buttons
local tabButtons = {
	{ label="First", defaultFile="icons/icon1.png", overFile="icons/icon1-down.png", width = 32, height = 32, onPress=onFirstView, selected=true },
	{ label="Second", defaultFile="icons/icon2.png", overFile="icons/icon2-down.png", width = 32, height = 32, onPress=onSecondView },
  { label="Third", defaultFile="icons/icon2.png", overFile="icons/icon2-down.png", width = 32, height = 32, onPress=onSecondView },
}

-- create the actual tabBar widget
local tabBar = widget.newTabBar{
	top = display.contentHeight - 50,	-- 50 is default height for tabBar widget
	buttons = tabButtons
}


-- Set default fill color for vector objects to red
display.setDefault( "fillColor", 0, 0, 0 )

-- Set default screen background color to blue
display.setDefault( "background", 0, 0, 0 )

onSecondView()	-- invoke first tab button's onPress event manually