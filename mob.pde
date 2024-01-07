 class Mob {
  // position on screen
  PVector [] possibilities = {new PVector(-1, 0), new PVector(0, -1), new PVector(0, 1), new PVector(1, 0)};
  int [] Mobpossibilities;
  PVector _position;
  PVector positionbis;
  
  // position on board
  int _cellX, _cellY;
  
  // display size
  float _size;
  float _ecart;
  
  boolean _pause= false;
  boolean _dead= false;
  
  int compteur=1;
  int chiffre[]=new int[4];
  PVector direction;
  TypeCell cell[][];
  
  Mob(PVector position_on_board, float size, float ecart,Board board) {
    _cellX = int(position_on_board.y);
    _cellY = int(position_on_board.x);
    _size = size;
    _ecart = ecart;
    _position = new PVector(position_on_board.y, position_on_board.x);
    println(_cellX,_cellY);
    println(_position.x,_position.y);
    //positionbis=new PVector(_position.x* _size,_position.y* _size +_ecart);
    Mobpossibilities= new int[0];
    positionbis=new PVector(_position.x* _size,_position.y* _size +_ecart);
    //int chiffre=int(random(0,1));
    
    
    for (int i=0;i<4;i++){
      direction=new PVector (possibilities[i].x,possibilities[i].y);
      if(obst(direction,board,20)){
        Mobpossibilities=append(Mobpossibilities,i);
      }
    }
    
    //println(
    
  }
  
  void move(Board board,float vitesse) {
     
     if(obst(direction,board,vitesse)){
       positionbis.x+=(direction.x*_size)/vitesse;
       positionbis.y+=(direction.y*_size)/vitesse;
       println("mouv1",positionbis.x,positionbis.y);
     }
     else {
       for (int i=0;i<4;i++){
      direction=new PVector (possibilities[i].x,possibilities[i].y);
      if(obst(direction,board,20)){
        Mobpossibilities=append(Mobpossibilities,i);
      }
    }
     int chiffre=Mobpossibilities[int(random(0,Mobpossibilities.length))];
     direction=new PVector (possibilities[chiffre].x,possibilities[chiffre].y);
     }
     
       
  }

     
     
     
    
   
  
   
    
  
  boolean obst(PVector direction, Board board, float vitesse){
    cell=board._parser._cells;
    if (direction.x==1 && direction.y==0){
      float cellRUX=positionbis.x+_size-1+direction.x*_size/vitesse;
      float cellRUY=positionbis.y;
      float cellRDX=positionbis.x+_size-1+direction.x*_size/vitesse;
      float cellRDY=positionbis.y+_size-1;
      if (cell[int(arrondi(cellRUY/_size-2.5))][int(arrondi(cellRUX/_size))]==TypeCell.EMPTY && cell[int(arrondi(cellRDY/_size-2.5))][int(arrondi(cellRDX/_size))]==TypeCell.EMPTY){
        return true;
      }
      else{
        return false;
      }
      
    }
    if (direction.x==-1 && direction.y==0){
      float cellLUX=positionbis.x+direction.x*_size/vitesse;
      float cellLUY=positionbis.y;
      float cellLDX=positionbis.x+direction.x*_size/vitesse;
      float cellLDY=positionbis.y+_size-1;
      if (cell[int(arrondi(cellLUY/_size-2.5))][int(arrondi(cellLUX/_size))]==TypeCell.EMPTY && cell[int(arrondi(cellLDY/_size-2.5))][int(arrondi(cellLDX/_size))]==TypeCell.EMPTY){
        return true;
      }
      else{
        return false;
      }
    }
    if (direction.x==0 && direction.y==1){
      float cellDLX=positionbis.x;
      float cellDLY=positionbis.y+_size-1+direction.y*_size/vitesse;
      float cellDRX=positionbis.x+_size-1;
      float cellDRY=positionbis.y+_size-1+direction.y*_size/vitesse;
      if (cell[int(arrondi(cellDLY/_size-2.5))][int(arrondi(cellDLX/_size))]==TypeCell.EMPTY && cell[int(arrondi(cellDRY/_size-2.5))][int(arrondi(cellDRX/_size))]==TypeCell.EMPTY){
        return true;
      }
      else{
        return false;
      }
    }
    if (direction.x==0 && direction.y==-1){
      float cellULX=positionbis.x;
      float cellULY=positionbis.y+direction.y*_size/vitesse;
      float cellURX=positionbis.x+_size-1;
      float cellURY=positionbis.y+direction.y*_size/vitesse;
      println(cellULX,cellULY,cellURX,cellURY);
      println(int(arrondi(cellULY/_size-2.5)),int(arrondi(cellULX/_size)),int(arrondi(cellURY/_size-2.5)),int(arrondi(cellURX/_size)));
      
      if (cell[int(arrondi(cellULY/_size-2.5))][int(arrondi(cellULX/_size))]==TypeCell.EMPTY && cell[int(arrondi(cellURY/_size-2.5))][int(arrondi(cellULX/_size))]==TypeCell.EMPTY){
        println("move");
        return true;
        
      }
      else{
        return false;
      }
    }
    return false;
    
  }
  float arrondi(float i){
    if (abs(i-round(i))<1e-4){
      return round(i);
    }
    return i;
  }
  
  
  void drawIt() {
    noStroke();
    fill(255,255,0);
    rectMode(CORNER);
    rect(positionbis.x,positionbis.y,_size,_size);
    //rect(_position.x * _size, _position.y* _size + _ecart, _size, _size);
  }
}
