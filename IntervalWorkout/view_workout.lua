-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local ixdata = require( "ixdatadef" )
local scene = composer.newScene()
local title

local workoutTimeManager = 
{
  --exercise timer
  timerCurrentExercise = {},
  timerCurrentExerciseRefreshInterval = 66, 
  timerCurrentExerciseTarget = 30000, 
  timerCurrentExerciseCurrent = 0, 
  timerCurrentExerciseCallback = function ( event )
      timerCurrentExerciseCurrent = event.time
      title.text = "Time left : " .. timerCurrentExerciseCurrent 
      
    end, 
    
  init = function () 
    timerCurrentExerciseRefreshInterval = 66
    timerCurrentExerciseTarget = 30000
    timerCurrentExerciseCurrent = 0
    if not timerCurrentExercise then
      timerCurrentExercise.cancel()
      
    end
  end
  
} 

 
function scene:create( event )
	local sceneGroup = self.view
	
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	bg.anchorX = 0
	bg.anchorY = 0
	bg:setFillColor( 1 )	-- white
	
	-- create some text
  title = display.newText( IXExercise_Pushups.name, 0, 0, native.systemFont, 32 )
	title:setFillColor( 0 )	-- black
	title.x = display.contentWidth * 0.5
	title.y = 125
	
	local newTextParams = { text = "Loaded by the first tab's\n\"onPress\" listener\nspecified in the 'tabButtons' table", 
						x = 0, y = 0, 
						width = 310, height = 310, 
						font = native.systemFont, fontSize = 14, 
						align = "center" }
	local summary = display.newText( newTextParams )
	summary:setFillColor( 0 ) -- black
	summary.x = display.contentWidth * 0.5 + 10
	summary.y = title.y + 215
	
	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( bg )
	sceneGroup:insert( title )
	sceneGroup:insert( summary )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
    workoutTimeManager.timerCurrentExercise = timer.performWithDelay( 
      workoutTimeManager.timerCurrentExerciseRefreshInterval, 
      workoutTimeManager.timerCurrentExerciseCallback , 
      0)
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
    timer.cancel(workoutTimeManager.timerCurrentExercise)
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
    timer.cancel( workoutTimeManager.timerCurrentExercise)
	elseif phase == "did" then

		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene