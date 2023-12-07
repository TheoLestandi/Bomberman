enum TypeSprites {
  
  // Sprites Vide.
  EMPTY, EMPTY_WALL, EMPTY_DESTRUCTIBLE,
  
  // Sprites Mur.
  WALL, WALL_UP, WALL_DOWN, WALL_LEFT, WALL_RIGHT, WALL_CORNER_UP_LEFT, WALL_CORNER_UP_RIGHT, WALL_CORNER_DOWN_LEFT, WALL_CORNER_DOWN_RIGHT,
  
  // Sprites Mur destructible.
  DESTRUCTIBLE_WALL1, DESTRUCTIBLE_WALL2, DESTRUCTIBLE_WALL3, DESTRUCTIBLE_WALL4, 
  DESTRUCTIBLE_WALL_SHADOW1, DESTRUCTIBLE_WALL_SHADOW2, DESTRUCTIBLE_WALL_SHADOW3, DESTRUCTIBLE_WALL_SHADOW4,
  
  // Sprites Sortie.
  EXIT_DOOR1, EXIT_DOOR2,
  
  // Sprites Bomberman.
  BOMBERMAN_DOWN1, BOMBERMAN_DOWN2, BOMBERMAN_DOWN3, BOMBERMAN_UP1, BOMBERMAN_UP2, BOMBERMAN_UP3,
  BOMBERMAN_LEFT1, BOMBERMAN_LEFT2, BOMBERMAN_LEFT3, BOMBERMAN_RIGHT1,  BOMBERMAN_RIGHT2, BOMBERMAN_RIGHT3, 
  BOMBERMAN_DEAD1, BOMBERMAN_DEAD2, BOMBERMAN_DEAD3, BOMBERMAN_DEAD4, BOMBERMAN_DEAD5, BOMBERMAN_DEAD6,
  
  // Sprites Monstre.
  MOB_DOWN1, MOB_DOWN2, MOB_DOWN3, MOB_DOWN4, MOB_UP1, MOB_UP2, MOB_UP3, MOB_UP4, 
  MOB_LEFT1, MOB_LEFT2, MOB_LEFT3, MOB_LEFT4, MOB_RIGHT1,MOB_RIGHT2, MOB_RIGHT3, MOB_RIGHT4,
  
  // Sprites Slime.
  SLIME1, SLIME2, SLIME3, SLIME4, SLIME5, SLIME6
}

class Sprites {
  PImage _imageSprites;
  float _sizeSprite;
  
  Sprites( PImage _file, float _size ) {
    _imageSprites = _file;
    _sizeSprite = _size;
  }
  
  HashMap< TypeSprites, PImage > searchSpriteBoard() {
    
    HashMap < TypeSprites, PImage > sprite_board = new HashMap <> () ; 
      
    // Vide.  
    sprite_board.put(TypeSprites.EMPTY, _imageSprites.get(48, 96, 16, 16));
    sprite_board.put(TypeSprites.EMPTY_WALL, _imageSprites.get(48, 80, 16, 16));      
    sprite_board.put(TypeSprites.EMPTY_DESTRUCTIBLE, _imageSprites.get(64, 96, 16, 16));
    
    // Murs.
    sprite_board.put(TypeSprites.WALL, _imageSprites.get(80, 96, 16, 16));
    sprite_board.put(TypeSprites.WALL_UP, _imageSprites.get(48, 64+8, 16, 8));
    sprite_board.put(TypeSprites.WALL_DOWN, _imageSprites.get(32, 96, 16, 8));
    sprite_board.put(TypeSprites.WALL_LEFT, _imageSprites.get(16, 80, 16, 16));
    sprite_board.put(TypeSprites.WALL_RIGHT, _imageSprites.get(16, 80, 16, 16));
    sprite_board.put(TypeSprites.WALL_CORNER_UP_LEFT, _imageSprites.get(16, 64+8, 16, 8));
    sprite_board.put(TypeSprites.WALL_CORNER_UP_RIGHT, _imageSprites.get(16, 64+8, 16, 8));
    sprite_board.put(TypeSprites.WALL_CORNER_DOWN_LEFT, _imageSprites.get(16, 96, 16, 8));
    sprite_board.put(TypeSprites.WALL_CORNER_DOWN_RIGHT, _imageSprites.get(16, 96, 16, 8));
    
    // Murs destructibles.
    sprite_board.put(TypeSprites.DESTRUCTIBLE_WALL1, _imageSprites.get(64, 64, 16, 16));
    sprite_board.put(TypeSprites.DESTRUCTIBLE_WALL2, _imageSprites.get(80, 64, 16, 16));
    sprite_board.put(TypeSprites.DESTRUCTIBLE_WALL3, _imageSprites.get(96, 64, 16, 16));
    sprite_board.put(TypeSprites.DESTRUCTIBLE_WALL4, _imageSprites.get(112, 64, 16, 16));
    sprite_board.put(TypeSprites.DESTRUCTIBLE_WALL_SHADOW1, _imageSprites.get(64, 80, 16, 16));
    sprite_board.put(TypeSprites.DESTRUCTIBLE_WALL_SHADOW2, _imageSprites.get(80, 80, 16, 16));
    sprite_board.put(TypeSprites.DESTRUCTIBLE_WALL_SHADOW3, _imageSprites.get(96, 80, 16, 16));
    sprite_board.put(TypeSprites.DESTRUCTIBLE_WALL_SHADOW4, _imageSprites.get(112, 80, 16, 16));
    
    // Porte de sortie.
    sprite_board.put(TypeSprites.EXIT_DOOR1, _imageSprites.get(128, 48, 16, 16));
    sprite_board.put(TypeSprites.EXIT_DOOR2, _imageSprites.get(144, 48, 16, 16));
    
    return sprite_board;
  }
  
  HashMap< TypeSprites, PImage > searchSpriteHero() {
    
    HashMap < TypeSprites, PImage > sprite_hero = new HashMap <> () ;
    
    // Bomberman mouvement vers le bas.
    sprite_hero.put(TypeSprites.BOMBERMAN_DOWN1, _imageSprites.get(16, 0, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_DOWN2, _imageSprites.get(0, 0, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_DOWN3, _imageSprites.get(32, 0, 16, 24));
    
    // Bomberman mouvement vers le haut.
    sprite_hero.put(TypeSprites.BOMBERMAN_UP1, _imageSprites.get(64, 0, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_UP2, _imageSprites.get(48, 0, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_UP3, _imageSprites.get(80, 0, 16, 24));
    
    // Bomberman mouvement vers la gauche.
    sprite_hero.put(TypeSprites.BOMBERMAN_LEFT1, _imageSprites.get(0, 16, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_LEFT2, _imageSprites.get(32, 16, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_LEFT3, _imageSprites.get(16, 16, 16, 24));
    
    // Bomberman mouvement vers la droite.
    sprite_hero.put(TypeSprites.BOMBERMAN_RIGHT1, _imageSprites.get(48, 16, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_RIGHT2, _imageSprites.get(64, 16, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_RIGHT3, _imageSprites.get(80, 16, 16, 24));

    // Bomberman sprites de la mort.
    sprite_hero.put(TypeSprites.BOMBERMAN_DEAD1, _imageSprites.get(0, 32, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_DEAD2, _imageSprites.get(16, 32, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_DEAD3, _imageSprites.get(32, 32, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_DEAD4, _imageSprites.get(48, 32, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_DEAD5, _imageSprites.get(64, 32, 16, 24));
    sprite_hero.put(TypeSprites.BOMBERMAN_DEAD6, _imageSprites.get(80, 32, 16, 24));
    
    return sprite_hero;
  }
  
  HashMap< TypeSprites, PImage > searchSpriteMob() {
    
    HashMap < TypeSprites, PImage > sprite_mob = new HashMap <> () ; 
    
    // Mob mouvement vers le bas.
    sprite_mob.put(TypeSprites.MOB_DOWN1, _imageSprites.get(0, 48, 16, 24));
    sprite_mob.put(TypeSprites.MOB_DOWN2, _imageSprites.get(16, 48, 16, 24));
    sprite_mob.put(TypeSprites.MOB_DOWN3, _imageSprites.get(32, 48, 16, 24));
    sprite_mob.put(TypeSprites.MOB_DOWN4, _imageSprites.get(48, 48, 16, 24));

    // Mob mouvement vers le haut.
    sprite_mob.put(TypeSprites.MOB_UP1, _imageSprites.get(64, 48, 16, 24));
    sprite_mob.put(TypeSprites.MOB_UP2, _imageSprites.get(80, 48, 16, 24));
    sprite_mob.put(TypeSprites.MOB_UP3, _imageSprites.get(96, 48, 16, 24));
    sprite_mob.put(TypeSprites.MOB_UP4, _imageSprites.get(112, 48, 16, 24));
    
    // Mob mouvement vers la gauche.
    sprite_mob.put(TypeSprites.MOB_LEFT1, _imageSprites.get(0, 64, 16, 24));
    sprite_mob.put(TypeSprites.MOB_LEFT2, _imageSprites.get(16, 64, 16, 24));
    sprite_mob.put(TypeSprites.MOB_LEFT3, _imageSprites.get(32, 64, 16, 24));
    sprite_mob.put(TypeSprites.MOB_LEFT4, _imageSprites.get(48, 64, 16, 24));
    
    // Mob mouvement vers la droite.
    sprite_mob.put(TypeSprites.MOB_RIGHT1, _imageSprites.get(64, 64, 16, 24));
    sprite_mob.put(TypeSprites.MOB_RIGHT2, _imageSprites.get(80, 64, 16, 24));
    sprite_mob.put(TypeSprites.MOB_RIGHT3, _imageSprites.get(96, 64, 16, 24));
    sprite_mob.put(TypeSprites.MOB_RIGHT4, _imageSprites.get(112, 64, 16, 24));

    // Slime animations.
    sprite_mob.put(TypeSprites.SLIME1, _imageSprites.get(0, 80, 16, 24));
    sprite_mob.put(TypeSprites.SLIME2, _imageSprites.get(16, 80, 16, 24));
    sprite_mob.put(TypeSprites.SLIME3, _imageSprites.get(32, 80, 16, 24));
    sprite_mob.put(TypeSprites.SLIME4, _imageSprites.get(48, 80, 16, 24));
    sprite_mob.put(TypeSprites.SLIME5, _imageSprites.get(64, 80, 16, 24));
    sprite_mob.put(TypeSprites.SLIME6, _imageSprites.get(80, 80, 16, 24));
    
    return sprite_mob;
  }

}
