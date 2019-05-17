abstract class Zombie{
  int hp, dmg;
  float atk_speed, move_speed, x, y;
  
  Zombie(){
  }
  
  Zombie(int hhp, int ddmg, float atk, float move, float xx, float yy){
    hp = hhp;
    dmg = ddmg;
    atk_speed = atk;
    move_speed = move;
    x = xx;
    y = yy;
  }
  
}

class BasicZombie extends Zombie{
  BasicZombie(){
    //super(200, 100, 
  }
}

class ConeheadZombie extends Zombie{
}
