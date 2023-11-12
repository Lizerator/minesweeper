function generate_full_grid(num_bombs, width, height)
  bombs={}
  bombs=generate_bombs(num_bombs, width, height)                         
  
  local grid={}
  for y=0,height-1 do                                           
    row={}                                                
    for x=0,width-1 do                                         
      if(not table_contains(two_points_equal,bombs,{x,y})) then
        add(row,count_bombs_nearby_points({x,y},bombs,width,height))
      else
        add(row,-1)
        print("bomb")
      end
    end                                                   
    add(grid,row)                                         
  end

  --stop(grid[7][7])
  return grid
end

function generate_clueless_grid(width,height)
  local grid={}
  for y=0, height-1 do
    row={}
    for x=0,width-1 do
      add(row,"?")
    end
    add(grid,row)
  end
  return grid
end

-- uninclusive!
function generate_bombs(bomb_ammount, grid_width, grid_height)
  bombs = {}

  for i=1,bomb_ammount do
    point={}
    repeat
      point=random_point(grid_width,grid_height)
    until(not table_contains(two_points_equal,bombs,point))
    add(bombs,point)
  end

  return bombs
end

function table_contains(equality_function, table, value)
  for i=1,#table do
    if(equality_function(table[i],value)) then
      return true
    end
  end
  return false
end

function random_point(grid_width,grid_height)
  return {random_int(grid_width),random_int(grid_height)}
end

function random_int(uninclusive_limit)
  return flr(rnd()*uninclusive_limit)
end

function two_points_equal(point_1,point_2)
  return ((point_1[1]==point_2[1]) and (point_1[2]==point_2[2]))
end

function draw_up_cell(x,y,val)
  rectfill(x,y,x+6,y+6,6)   
  rectfill(x,y+7,x+6,y+7,1)
  offset=0
  if(ord(val)>126) then
    offset=-2
  end
  print(val,x+2+offset,y+1,1)
end

function draw_down_cell(x,y,grid_val)
  rectfill(x,y+1,x+6,y+6+1,13)   
  print(grid_val,x+2,y+1+1,1)        
end


function zero_out(point,grid,change_grid)                                                                                                         
  local known_grid=change_grid
  to_search={point}                                                                                                                              
  if(grid[point[2]][point[1]]==-1) then                                                                                                          
    stop()                                                                                                                                       
  end                                                                                                                                            
  already_searched={}                                                                                                                            
  while(#to_search>0 and #to_search<10) do                                                                                                                         
    current_point=deli(to_search,1)                                                                                                              
    print(current_point[1])                                                                                                                      
    add(already_searched, current_point)                                                                                                         
    if(grid[current_point[2]][current_point[1]]!=-1) then                                                                                        
      known_grid=reveal_cell(current_point[1],current_point[2], known_grid, grid)                                                                
    end                                                                                                                                          
                                                                                                                                                 
    if(grid[current_point[2]][current_point[1]]==0) then                                                                                         
      for dir in all(NEARBY_DIRECTIONS) do                                                                                                       
        new_point=add_points(dir,current_point)                                                                                                  
        if(validate_point(add_points({-1,-1},new_point),#grid,#grid[1]) and not table_contains(two_points_equal,already_searched,new_point)) then
          add(to_search,new_point)                                                                                                               
        end                                                                                                                                      
      end                                                                                                                                        
    end                                                                                                                                          
  end                                   
  return known_grid, to_search
end                                                                                                                                              
