
-- -1 for bomb, 0-8 for bomb count
function bomb_location_value(point, bombs)
  if(table_contains(two_points_equal,bombs,point)) then
    return -1
  end
end

function point_contains_bomb(point,bombs)
  return (table_contains(two_points_equal,bombs,point))
end

function add_points(point_1,point_2)
  return {point_1[1]+point_2[1],point_1[2]+point_2[2]}
end

function validate_point(point,grid_height,grid_width)
  if(point[1]>=0 and point[1]<grid_width) then
    if(point[2]>=0 and point[2]<grid_height) then
      return true
    end
  end
  return false
end

function count_bombs_nearby_points(point, bombs, grid_height, grid_width)
  bomb_count=0
  for i=1, #NEARBY_DIRECTIONS do
    new_point=add_points(point,NEARBY_DIRECTIONS[i])
    if(validate_point(new_point,grid_height,grid_width) and point_contains_bomb(new_point, bombs)) then
      bomb_count+=1
    end
  end
  return bomb_count
end

