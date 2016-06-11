-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
local widget = require "widget"
local composer = require( "composer" )
local ixdata = require( "ixdatadef" )
local scene = composer.newScene()
local title


local workoutTimeManager = 
{
  --exercise timer
  timerCurrentExercise = nil,
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


--CIRCLE TIMER WIDGET BLOCK BEGIN
local circleWidget

initCircleWidget = function (sceneGroup)
  print( "initCircleWidget" )
  circleWidget = widget.newButton(
      {
          x = display.contentWidth * 0.5,
          y =  300,
          id = "button1",
          label = "Start",
          onEvent = startTimerEvent,
          shape = "circle",
          radius = 125,
          fillColor = { default={ 0.6, 0.6, 0.6, 1 }, over={ 1, 0.2, 0.5, 1 } },
          labelColor = { default={ 0.1, 0.1, 0.1 }, over={ 0, 0, 0, 0.5 } },
          fontSize = 24
      }
    ) 
  
  sceneGroup:insert( circleWidget )
  
  circleWidget.buttonState = "start" 
  transition.to( circleWidget, {time = 2000, alpha = 1, xScale = 2, yScale = 2})
end
--CIRCLE TIMER WIDGET BLOCK END

--CENTER BUTTON BLOCK BEGIN
local startButton = nil
local initStartButton
local deinitStartButton

local function startTimerEvent( event )
    if ( "ended" == event.phase and startButton.buttonState == "start") then
        print( "Button was pressed and released in start state" )
        workoutTimeManager.timerCurrentExercise = timer.performWithDelay( 
          workoutTimeManager.timerCurrentExerciseRefreshInterval, 
          workoutTimeManager.timerCurrentExerciseCallback , 0) 
        startButton:setLabel("stop")
        startButton.buttonState = "stop"
    elseif ( "ended" == event.phase and startButton.buttonState == "stop") then
        print( "Button was pressed and released in stop state" )
        deinitStartButton()
        startButton:setLabel("start")
    end
end

initStartButton = function ()
  print( "initStartButton" )
  startButton = widget.newButton(
      {
          x = display.contentWidth * 0.5,
          y = display.contentHeight - 100,
          id = "button1",
          label = "Start",
          onEvent = startTimerEvent,
          shape = "rect",
          fillColor = { default={ 0.6, 0.6, 0.6, 1 }, over={ 1, 0.2, 0.5, 1 } },
          labelColor = { default={ 0.1, 0.1, 0.1 }, over={ 0, 0, 0, 0.5 } },
          fontSize = 24
      }
    )
  startButton.buttonState = "start"
end

deinitStartButton = function()
  if workoutTimeManager.timerCurrentExercise ~= nil then
        timer.cancel(workoutTimeManager.timerCurrentExercise)
        workoutTimeManager.timerCurrentExercise = nil
      end
end

--CENTER BUTTON BLOCK END

 
function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
--	local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
--	bg.anchorX = 0
--	bg.anchorY = 0
--	bg:setFillColor( 1 )	-- white
	
	-- create some text
  title = display.newText( IXExercise_Pushups.name, 0, 0, native.systemFont, 32 )
	title:setFillColor( 1 )	-- black
	title.x = display.contentWidth * 0.5
	title.y = 125
	sceneGroup:insert( title )
  
      initStartButton()
    initCircleWidget(sceneGroup)
--	local newTextParams = { text = "Loaded by the first tab's\n\"onPress\" listener\nspecified in the 'tabButtons' table", 
--						x = 0, y = 0, 
--						width = 310, height = 310, 
--						font = native.systemFont, fontSize = 14, 
--						align = "center" }
--	local summary = display.newText( newTextParams )
--	summary:setFillColor( 0 ) -- black
--	summary.x = display.contentWidth * 0.5 + 10
--	summary.y = title.y + 215
	
	-- all objects must be added to group (e.g. self.view)
	--sceneGroup:insert( bg )
	
	--sceneGroup:insert( summary )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
    

    
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
    deinitStartButton()
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.) 
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