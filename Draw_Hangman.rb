class Draw_Hangman
  GALLOWS = [
'    _
   / |
  \X/|
   | |
  / \|
  ----',

'    _
   / |
  \O/|
   | |
    \|
  ----',

'    _
   / |
  \O/|
   | |
     |
  ----',

'    _
   / |
   O/|
   | |
     |
  ----',

'    _
   / |
   O |
   | |
     |
  ----',

'    _
   / |
   O |
     |
     |
  ----',

'    _
   / |
     |
     |
     |
  ----',

  '
     |
     |
     |
     |
  ----',

  '




  ----'].reverse

  def draw(i)
    puts GALLOWS[i]
  end

end
