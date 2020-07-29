function doSpeedWalk()
  echo("Path we need to take: " .. table.concat(speedWalkDir, ", ") .. "\n")
  echo("Rooms we'll pass through: " .. table.concat(speedWalkPath, ", ") .. "\n")

display(speedWalkDir[mapper.walker.step])
	mapper.walker.timer = tempTimer(mapper.walker.delay, function() 


	end)
end
