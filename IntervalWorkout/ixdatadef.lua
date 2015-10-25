IXWorkoutTagType  =
{ 
  Chest = 0,
  Abs = 1,
  Cardio = 2,
  Warmup = 3
}

function CreateWorkout(name,workoutTagTypeList)
  local workout = {}
  workout.name = name
  workout.tags = workoutTagTypeList
  return workout
end

IXExercise_Pushups = CreateWorkout(
  "Pushups",
  {IXWorkoutTagType.Chest})
  
IXExercise_Situps = CreateWorkout(
  "Situps",
  {IXWorkoutTagType.Abs})
  
IXExercise_JumpingJacks = CreateWorkout(
  "Jumping Jacks",
  {
    IXWorkoutTagType.Cardio,
    IXWorkoutTagType.Warmup
  })
  
IXExercise_InPlaceJogging = CreateWorkout(
  "Jogging in Place",
  {
    IXWorkoutTagType.Cardio,
    IXWorkoutTagType.Warmup
  })





