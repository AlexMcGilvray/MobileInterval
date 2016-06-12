
Exercise = 
{
  newExercise = function(name, category, duration)
    local exercise = {}
    exercise.name = name
    exercise.category = category
    exercise.duration = duration
    return exercise
  end
  
--  name = "unnammed",
--  category = "nocategory",
--  duration = -0.1
}

Workout = 
{
  newWorkout = function(name, exercises)
    local workout = {}
    workout.name = name
    workout.exercises = exercises
    return workout
  end
  
--  exercises = {}, --list of Exercise objects
--  name = "unammed"
}

