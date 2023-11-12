NEARBY_DIRECTIONS={{-1,-1},{-1,0},{-1,1},{0,-1},{0,1},{1,-1},{1,0},{1,1}}
grid={}
known_grid={}
selector={1,1}
TESTWIDTH=16
last_frame={}

function _init()
  grid=generate_full_grid(40,TESTWIDTH,TESTWIDTH)
  known_grid=generate_clueless_grid(TESTWIDTH,TESTWIDTH)
end

function _update()
  temp=add_points(get_selector_movement(),selector)
  if validate_point(add_points(temp,{-1,-1}), TESTWIDTH, TESTWIDTH) then
    selector=temp
  end
  if(btnp(5) and known_grid[selector[2]][selector[1]]!="\146") then
    known_grid,this_frame=zero_out({selector[1],selector[2]},grid,known_grid)
    for point in all(this_frame) do
      add(last_frame, point)
    end
  end
  if(btnp(4)) then
    if(known_grid[selector[2]][selector[1]]=="?") then
      known_grid[selector[2]][selector[1]]="\146"
    else 
      known_grid[selector[2]][selector[1]]="?"
    end
  end
end

function _draw()
  cls()
  for x=1,TESTWIDTH do 
    for y=1,TESTWIDTH do
      val=known_grid[y][x]
      if(val=="?" or val=="\146") then
        draw_up_cell((x-1)*7,(y-1)*7, val)
      else
        if(val==0) then
          val=""
        end
        draw_down_cell((x-1)*7,(y-1)*7,val)    
      end
    end
  end
  selx=(selector[1]-1)*7
  sely=(selector[2]-1)*7
  rect(selx,sely,selx+7,sely+7,1)
end

function get_selector_movement()
  fin = {0,0}
  if btnp(0) then
    fin=add_points(fin,{-1,0})
  end
  if btnp(1) then
    fin=add_points(fin,{1,0})
  end
  if(btnp(2)) then
    fin=add_points(fin,{0,-1})
  end
  if(btnp(3)) then
    fin=add_points(fin,{0,1})
  end
  return fin
end

function reveal_cell(x,y,known_grid,unknown_grid)
   temp=known_grid
   temp[y][x]=unknown_grid[y][x]
   return temp
end

